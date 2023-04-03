module Regulation.US.LCR.AggregatedRuleBalances exposing (..)

import Morphir.SDK.Aggregate as Aggregate
import Regulation.US.FR2052A.DataTables as DataTables
import Regulation.US.LCR.Basics exposing (Balance)
import Regulation.US.LCR.Inflows.Assets as Assets
import Regulation.US.LCR.Inflows.Other as InflowOther
import Regulation.US.LCR.Inflows.Secured as InflowSecured
import Regulation.US.LCR.Inflows.Unsecured as Unsecured
import Regulation.US.LCR.MaturityBucket exposing (FromDate)
import Regulation.US.LCR.Outflows.Deposits as Deposits
import Regulation.US.LCR.Rules exposing (RuleBalance)



-- TODO Apply respective rule rates


inflow_values : FromDate -> DataTables.Inflows -> Balance
inflow_values fromDate inflows =
    (List.concat
        [ --Assets.toRuleBalances inflows.assets
          --,
          --  InflowOther.toRuleBalances inflows.other
          --,
          InflowSecured.toRuleBalances fromDate inflows.secured
        , Unsecured.toRuleBalances fromDate inflows.unsecured
        ]
        |> aggregateRuleBalances
        |> sum
    )
        + Assets.apply_rules fromDate inflows.assets
        + InflowOther.apply_rules fromDate inflows.other


outflow_values : FromDate -> DataTables.Outflows -> Balance
outflow_values fromDate outflows =
    List.concat
        [ Deposits.toRuleBalances fromDate outflows.deposits

        --, OutflowOther.toRuleBalances outflows.other
        --, OutflowSecured.toRuleBalances outflows.secured
        --, Wholesale.toRuleBalances outflows.wholesale
        ]
        |> aggregateRuleBalances
        |> sum


aggregateRuleBalances : List RuleBalance -> List RuleBalance
aggregateRuleBalances ruleBalances =
    ruleBalances
        |> Aggregate.groupBy .rule
        |> Aggregate.aggregate
            (\key balances ->
                RuleBalance key (balances (Aggregate.sumOf .amount))
            )


sum : List RuleBalance -> Balance
sum ruleBalances =
    ruleBalances
        |> List.map .amount
        |> List.sum
