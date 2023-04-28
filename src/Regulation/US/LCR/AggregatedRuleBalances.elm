module Regulation.US.LCR.AggregatedRuleBalances exposing (..)

import Morphir.SDK.Aggregate as Aggregate
import Regulation.US.FR2052A.DataTables as DataTables
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (FromDate)
import Regulation.US.LCR.Basics exposing (Balance)
import Regulation.US.LCR.Inflows.Assets as Assets
import Regulation.US.LCR.Inflows.Other as InOther
import Regulation.US.LCR.Inflows.Secured as InSecured
import Regulation.US.LCR.Inflows.Unsecured as Unsecured
import Regulation.US.LCR.Outflows.Deposits as Deposits
import Regulation.US.LCR.Outflows.Other as OutOther
import Regulation.US.LCR.Outflows.Secured as OutSecured
import Regulation.US.LCR.Outflows.Wholesale as Wholesales
import Regulation.US.LCR.Rules exposing (RuleBalance)
import Regulation.US.LCR.Supplemental.DerivativesCollateral as DerivativesCollateral
import Regulation.US.LCR.Supplemental.LiquidityRiskMeasurement as LiquidityRiskMeasurement



-- TODO Apply respective rule rates


{-| The list of all rules pertaining to inflows.
-}
applyInflowRules : FromDate -> DataTables.Inflows -> List RuleBalance
applyInflowRules fromDate inflows =
    List.concat
        [ Assets.toRuleBalances fromDate inflows.assets
        , Unsecured.toRuleBalances fromDate inflows.unsecured
        , InSecured.toRuleBalances fromDate inflows.secured
        , InOther.toRuleBalances fromDate inflows.other
        ]


inflow_values : FromDate -> DataTables.Inflows -> Balance
inflow_values fromDate inflows =
    applyInflowRules fromDate inflows |> groupAndSum


{-| The list of all rules pertaining to outflows.
-}
applyOutflowRules : FromDate -> DataTables.Outflows -> List RuleBalance
applyOutflowRules fromDate outflows =
    List.concat
        [ Deposits.toRuleBalances fromDate outflows.deposits
        , OutSecured.toRuleBalances fromDate outflows.secured
        , Wholesales.toRuleBalances fromDate outflows.wholesale
        , OutOther.toRuleBalances fromDate outflows.other
        ]


outflow_values : FromDate -> DataTables.Outflows -> Balance
outflow_values fromDate outflows =
    applyOutflowRules fromDate outflows |> groupAndSum


{-| The list of all rules pertaining to supplementals.
-}
applySupplementalRules : DataTables.Supplemental -> List RuleBalance
applySupplementalRules supplementals =
    List.concat
        [ List.concatMap (\d -> DerivativesCollateral.applyRules d) supplementals.derivativesCollateral
        , List.concatMap (\l -> LiquidityRiskMeasurement.applyRules l) supplementals.liquidityRiskMeasurement
        ]


supplemental_values : FromDate -> DataTables.Supplemental -> Balance
supplemental_values fromDate flows =
    applySupplementalRules flows |> groupAndSum



{- Utilities -}


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


groupAndSum : List RuleBalance -> Balance
groupAndSum ruleBalances =
    ruleBalances |> aggregateRuleBalances |> sum
