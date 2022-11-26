module Regulation.US.LCR.AggregatedRuleBalances exposing (..)

import Morphir.SDK.Aggregate as Aggregate
import Regulation.US.FR2052A.DataTables as DataTables
import Regulation.US.LCR.Inflows.Assets as Assets
import Regulation.US.LCR.Inflows.Other as InflowOther
import Regulation.US.LCR.Inflows.Secured as InflowSecured
import Regulation.US.LCR.Inflows.Unsecured as Unsecured
import Regulation.US.LCR.Outflows.Deposits as Deposits
import Regulation.US.LCR.Outflows.Other as OutflowOther
import Regulation.US.LCR.Outflows.Secured as OutflowSecured
import Regulation.US.LCR.Rules exposing (RuleBalance)



--inflow_values_corresponding_to_33c_d_e_f : DataTables.Inflows -> MaturityBucket -> Balance
--inflow_values_corresponding_to_33c_d_e_f data maturityBucket =
--    -- TODO
--    1.0
--inflow_values : DataTables.Inflows -> MaturityBucket -> Balance
--inflow_values inflows maturityBucket =


inflow_values : DataTables.Inflows -> List RuleBalance
inflow_values inflows =
    List.concat
        [ Assets.toRuleBalances inflows.assets
        , InflowOther.toRuleBalances inflows.other
        , InflowSecured.toRuleBalances inflows.secured
        , Unsecured.toRuleBalances inflows.unsecured
        ]
        |> aggregateRuleBalances



--
--outflow_values : DataTables.Outflows -> List RuleBalance
--outflow_values outflows =
--    List.concat
--        [ Deposits.toRuleBalances outflows.deposits
--
--        --, OutflowOther.toRuleBalances outflows.other
--        --, OutflowSecured.toRuleBalances outflows.secured
--        --, Wholesale.toRuleBalances outflows.wholesale
--        ]
--    |> aggregateRuleBalances


aggregateRuleBalances : List RuleBalance -> List RuleBalance
aggregateRuleBalances ruleBalances =
    ruleBalances
        |> Aggregate.groupBy .rule
        |> Aggregate.aggregate
            (\key balances ->
                RuleBalance key (balances (Aggregate.sumOf .amount))
            )
