module Regulation.US.LCR.AggregatedRuleBalances exposing (..)

import Morphir.SDK.Aggregate as Aggregate
import Regulation.US.FR2052A.DataTables as DataTables
import Regulation.US.LCR.Basics exposing (Balance)
import Regulation.US.LCR.Inflows.Assets as Assets
import Regulation.US.LCR.Inflows.Other as InflowOther
import Regulation.US.LCR.Inflows.Secured as InflowSecured
import Regulation.US.LCR.Inflows.Unsecured as Unsecured
import Regulation.US.LCR.Outflows.Deposits as Deposits
import Regulation.US.LCR.Outflows.Other as OutflowOther
import Regulation.US.LCR.Outflows.Secured as OutflowSecured
import Regulation.US.LCR.Rules exposing (RuleBalance)



-- TODO Apply respective rule rates


inflow_values : DataTables.Inflows -> Balance
inflow_values inflows =
    (List.concat
        [ --Assets.toRuleBalances inflows.assets
          --,
          --  InflowOther.toRuleBalances inflows.other
          --,
          InflowSecured.toRuleBalances inflows.secured
        , Unsecured.toRuleBalances inflows.unsecured
        ]
        |> aggregateRuleBalances
        |> sum
    )
        + Assets.apply_rules inflows.assets
        + InflowOther.apply_rules inflows.other


outflow_values : DataTables.Outflows -> Balance
outflow_values outflows =
    List.concat
        [ Deposits.toRuleBalances outflows.deposits

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
