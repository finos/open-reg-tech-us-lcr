{-
   Copyright 2022 Morgan Stanley
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at
       http://www.apache.org/licenses/LICENSE-2.0
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-}


module Regulation.US.LCR.Calculations exposing (..)

import Basics as Math
import Morphir.SDK.Dict as Dict exposing (Dict)
import Regulation.US.FR2052A.DataTables as DataTables exposing (DataTables, Inflows)
import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (Assets)
import Regulation.US.FR2052A.DataTables.Inflows.Secured as Inflows
import Regulation.US.FR2052A.DataTables.Outflows as Outflows exposing (Outflows)
import Regulation.US.FR2052A.DataTables.Outflows.Deposits exposing (Deposits)
import Regulation.US.FR2052A.DataTables.Outflows.Other exposing (Other)
import Regulation.US.FR2052A.DataTables.Outflows.Secured exposing (Secured)
import Regulation.US.FR2052A.DataTables.Outflows.Wholesale exposing (Wholesale)
import Regulation.US.FR2052A.DataTables.Supplemental.DerivativesCollateral as Supplemental exposing (DerivativesCollateral)
import Regulation.US.FR2052A.DataTables.Supplemental.LiquidityRiskMeasurement exposing (LiquidityRiskMeasurement)
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket(..))
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct exposing (SubProduct)
import Regulation.US.LCR.Basics exposing (Balance)
import Regulation.US.LCR.Flows as Flows exposing (..)
import Regulation.US.LCR.Rule exposing (Rule)
import Regulation.US.LCR.Rules as Rules
import Tuple exposing (second)



-- import Regulation.US.LCR.Supplemental.Rules as Rules
{-
   Formulas from: https://www.federalreserve.gov/reportforms/formsreview/Appendix%20VI%20and%20VII.pdf
-}

lcr : DataTables -> Float -> Balance
lcr data outflow_adjustment_percentage =
    (hqla_amount data) / (total_net_cash_outflows outflow_adjustment_percentage data.outflows data.inflows)

hqla_amount : DataTables -> Balance
hqla_amount data =
     ((level_1_HQLA_additive_values data) - (level_1_HQLA_subtractive_values data))
     + 0.85 * ((level_2A_HQLA_additive_values data) - (level_2A_HQLA_subtractive_values data))
     + 0.5 * ((level_2B_HQLA_additive_values data) - (level_2A_HQLA_additive_values data))
     + Math.max (unadjusted_excess_HQLA data) (adjusted_excess_HQLA data)

unadjusted_excess_HQLA : DataTables -> Balance
unadjusted_excess_HQLA data =
     (level_2_cap_excess_amount data) + (level_2B_cap_excess_amount data)

level_2_cap_excess_amount : DataTables -> Balance
level_2_cap_excess_amount data =
 let
     amount =
         0.85 * ((level_2A_HQLA_additive_values data) - (level_2A_HQLA_subtractive_values data))
         + 0.5 * ((level_2B_HQLA_additive_values data) - (level_2B_HQLA_subtractive_values data))
         - 0.6667 * ((level_1_HQLA_additive_values data) - (level_1_HQLA_subtractive_values data))
 in
     Math.max 0 amount

level_2B_cap_excess_amount : DataTables -> Balance
level_2B_cap_excess_amount data =
 let
     amount =
         0.5 * ((level_2B_HQLA_additive_values data) - (level_2B_HQLA_subtractive_values data))
         - (level_2_cap_excess_amount data)
         + 0.1765 * ((level_1_HQLA_additive_values data) - (level_1_HQLA_subtractive_values data))
         - 0.85 * ((level_2A_HQLA_additive_values data) - (level_2A_HQLA_subtractive_values data))
 in
     Basics.max 0 amount


adjusted_level_1_HQLA_additive_values : DataTables -> Inflows -> DataTables.Outflows -> Inflows -> Inflows -> Float
adjusted_level_1_HQLA_additive_values data securedLending securedFunding assetExchangeUnwind assetExunwindcollateral =
    let
        hqla_add_values : Balance
        hqla_add_values = level_1_HQLA_additive_values data
        secured_lending_unwind_maturity_amounts : Float
        secured_lending_unwind_maturity_amounts = Flows.inflowRules securedLending
                                                                    |> Rules.findAll
                                                                     [ "21(a)(todo)" ] |> List.map (\( v, u ) -> u) |> List.sum
        secured_lending_unwind_collateral_values_with_level_1_collateral_class : Float
        secured_lending_unwind_collateral_values_with_level_1_collateral_class =
            Flows.inflowRules securedLending
                    |> Rules.findAll
                    [ "33(f)(1)(iii)" ] |> List.map (\( v, u ) -> u) |> List.sum
        secured_funding_unwind_maturity_amounts : Float
        secured_funding_unwind_maturity_amounts =
            Flows.outflowRules securedFunding
                            |> Rules.findAll
                                [ "21(b)(todo)" ] |> List.map (\( v, u ) -> u) |> List.sum
        secured_funding_unwind_collateral_values_with_level_1_collateral_class : Float
        secured_funding_unwind_collateral_values_with_level_1_collateral_class =
            Flows.outflowRules securedFunding
                                        |> Rules.findAll
                                            [ "32(j)(1)(i)" ] |> List.map (\( v, u ) -> u) |> List.sum
        asset_exchange_unwind_maturity_amounts_with_level_1_subproduct : Float
        asset_exchange_unwind_maturity_amounts_with_level_1_subproduct =
            Flows.inflowRules assetExchangeUnwind
                                |> Rules.findAll
                                [ "21(c)(todo)" ] |> List.map (\( v, u ) -> u) |> List.sum
        asset_exchange_unwind_collateral_values_with_level_1_collateral_class : Float
        asset_exchange_unwind_collateral_values_with_level_1_collateral_class =
            Flows.inflowRules assetExunwindcollateral
                                           |> Rules.findAll
                                           [ "33(f)(2)(i)" ] |> List.map (\( v, u ) -> u) |> List.sum
    in
        hqla_add_values + secured_lending_unwind_maturity_amounts
        - secured_lending_unwind_collateral_values_with_level_1_collateral_class
        - secured_funding_unwind_maturity_amounts
        + secured_funding_unwind_collateral_values_with_level_1_collateral_class
        + asset_exchange_unwind_maturity_amounts_with_level_1_subproduct
        - asset_exchange_unwind_collateral_values_with_level_1_collateral_class


adjusted_Level2A_HQLA_Additive_Values : Inflows -> DataTables.Outflows -> Inflows -> Inflows -> Float
adjusted_Level2A_HQLA_Additive_Values securedLending securedFunding assetExchangeUnwind assetExunwindcollateral =
    let
        securedFunds : List Flow
        securedFunds =
            Flows.outflowRules securedFunding
                |> Rules.findAll
                    [ "21(b)(todo)" ]

        securedFundings : Float
        securedFundings =
            List.map (\( u, v ) -> v) securedFunds
                |> List.sum

        securedLen : List Flow
        securedLen =
            Flows.inflowRules securedLending
                |> Rules.findAll
                    [ "33(f)(1)(iv)" ]

        securedlendings : Float
        securedlendings =
            List.map (\( v, u ) -> u) securedLen
                |> List.sum

        assetExchangeMat : List Flow
        assetExchangeMat =
            Flows.inflowRules assetExchangeUnwind
                |> Rules.findAll
                    [ "21(c)(todo)" ]

        assetExchange : Float
        assetExchange =
            List.map (\( v, u ) -> u) assetExchangeMat
                |> List.sum

        assetCollateral : List Flow
        assetCollateral =
            Flows.inflowRules assetExunwindcollateral
                |> Rules.findAll
                    [ "33(f)(2)(i)" ]

        assetExcahngeUnwindColl : Float
        assetExcahngeUnwindColl =
            List.map (\( v, u ) -> u) assetCollateral
                |> List.sum
    in
    (level_2A_HQLA_additive_values data) - securedlendings + securedFundings + assetExchange - assetExcahngeUnwindColl



--securedFundings = List.filter(\flow -> flow.assetType == L2Assets)
--                     |> List.map(\(v,u) -> u) securedFunds
-- securedFunding L2A : 32(j)(1)(ii)
--securedLending
--Asset Exchange
-- output : lvl 2A HQLA - SecuredLending unwind + se
--
--adjusted_Level2B_HQLA_Additive_Values : Int -> DataTables.Outflows -> DataTables.Inflows -> Balance
--adjusted_Level2B_HQLA_Additive_Values int outflows inflows =
--  let
--      securedLen : List Flow
--      securedLen =
--       Flows.inflowRules Inflows
--           |> Rules.findAll
--              [ "33(f)(1)(v)"]


adjusted_Level2B_HQLA_Additive_Values : DataTables.Inflows -> DataTables.Outflows -> Inflows -> Inflows -> Float
adjusted_Level2B_HQLA_Additive_Values securedLending securedFunding assetExchangeUnwind assetExunwindcollateral =
    let
        securedLen : List Flow
        securedLen =
            Flows.inflowRules securedLending
                |> Rules.findAll
                    [ "33(f)(1)(v)" ]

        securedlendings : Float
        securedlendings =
            List.map (\( v, u ) -> u) securedLen
                |> List.sum

        assetExchangeMat : List Flow
        assetExchangeMat =
            Flows.inflowRules assetExchangeUnwind
                |> Rules.findAll
                    [ "21(c)(todo)" ]

        assetExchange : Float
        assetExchange =
            List.map (\( v, u ) -> u) assetExchangeMat
                |> List.sum

        assetCollateral : List Flow
        assetCollateral =
            Flows.inflowRules assetExunwindcollateral
                |> Rules.findAll
                    [ "33(f)(2)(i)" ]

        assetExcahngeUnwindColl : Float
        assetExcahngeUnwindColl =
            List.map (\( v, u ) -> u) assetCollateral
                |> List.sum

        securedFund : List Flow
        securedFund =
            Flows.outflowRules securedFunding
                |> Rules.findAll
                    [ "21(b)(todo)" ]

        securedFundings : Float
        securedFundings =
            List.map (\( u, v ) -> v) securedFund
                |> List.sum
    in
    (level_2B_HQLA_additive_values data) - securedlendings + securedFundings + assetExchange - assetExcahngeUnwindColl



adjusted_excess_HQLA : DataTables -> Balance
adjusted_excess_HQLA data = adjusted_level2_cap_excess_amount data + adjusted_level2b_cap_excess_amount data

adjusted_level2_cap_excess_amount : DataTables -> Balance
adjusted_level2_cap_excess_amount data =
    Math.max 0
    (0.85 * ((adjusted_Level2A_HQLA_Additive_Values data) -
    (level_2A_HQLA_subtractive_values data)) +
    0.5 * ((adjusted_Level2B_HQLA_Additive_Values data) -
    (level_2B_HQLA_subtractive_values data)) -
    0.6667 * ((adjusted_level_1_HQLA_additive_values data) -
    (level_1_HQLA_subtractive_values data)))

adjusted_level2b_cap_excess_amount : DataTables -> Balance
adjusted_level2b_cap_excess_amount data =
    Math.max 0
        (0.5 * ((adjusted_Level2B_HQLA_Additive_Values data) -
        (level_2B_HQLA_subtractive_values data)) -
        (adjusted_level2_cap_excess_amount data)
        - 0.1765 * (((adjusted_level_1_HQLA_additive_values data) - (level_1_HQLA_subtractive_values data))
        +0.85 * ((adjusted_Level2A_HQLA_Additive_Values data) - (level_2A_HQLA_subtractive_values data))))


level_1_HQLA_additive_values : DataTables -> Balance
level_1_HQLA_additive_values data =
    let
        level_1_inflow_assets : List Assets
        level_1_inflow_assets =
            data.inflows.assets
            |> List.filter (\a -> isSubProduct a.subProduct SubProduct.isHQLALevel1)

        level_1_inflow_secured : List Inflows.Secured
        level_1_inflow_secured =
             data.inflows.secured
             |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)

        level_1_inflows : DataTables.Inflows
        level_1_inflows = { assets = level_1_inflow_assets, other = [], secured = level_1_inflow_secured, unsecured = [] }

        level_1_supplemental_derivativesCollateral : List Supplemental.DerivativesCollateral
        level_1_supplemental_derivativesCollateral =
             data.supplemental.derivativesCollateral
             |> List.filter (\d -> isSubProduct d.subProduct SubProduct.isHQLALevel1)

        level_1_supplementals : DataTables.Supplemental
        level_1_supplementals = { balanceSheet = [], derivativesCollateral = level_1_supplemental_derivativesCollateral, foreignExchange = [], informational = [], liquidityRiskMeasurement = []}

        inflow_rules : List Flow
        inflow_rules =
            Flows.inflowRules level_1_inflows
                |> Rules.findAll
                    [ "33(c)"
                    , "33(d)(1)"
                    , "33(d)(2)"
                    , "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    ]
        inflowAmount : Float
        inflowAmount =
            List.sum (List.map (\f -> second f) inflow_rules)

        supplemantal_rules : List Flow
        supplemantal_rules =
            Flows.supplementalRules level_1_supplementals
                |> Rules.findAll
                    [ "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    , "20(a)(1)C"
                    ]

        supplementalAmount : Float
        supplementalAmount =
            List.sum (List.map (\f -> second f) supplemantal_rules)
    in
        inflowAmount + supplementalAmount


level_2A_HQLA_additive_values : DataTables -> Balance
level_2A_HQLA_additive_values data =
    let
        level_2A_inflow_assets : List Assets
        level_2A_inflow_assets =
            data.inflows.assets
            |> List.filter (\a -> isSubProduct a.subProduct SubProduct.isHQLALevel2A)

        level_2A_inflow_secured : List Inflows.Secured
        level_2A_inflow_secured =
             data.inflows.secured
             |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel2A)

        level_2A_inflows : DataTables.Inflows
        level_2A_inflows = { assets = level_2A_inflow_assets, other = [], secured = level_2A_inflow_secured, unsecured = [] }

        level_2A_supplemental_derivativesCollateral : List Supplemental.DerivativesCollateral
        level_2A_supplemental_derivativesCollateral =
             data.supplemental.derivativesCollateral
             |> List.filter (\d -> isSubProduct d.subProduct SubProduct.isHQLALevel2A)

        level_2A_supplementals : DataTables.Supplemental
        level_2A_supplementals = { balanceSheet = [], derivativesCollateral = level_2A_supplemental_derivativesCollateral, foreignExchange = [], informational = [], liquidityRiskMeasurement = []}

        inflow_rules : List Flow
        inflow_rules =
            Flows.inflowRules level_2A_inflows
                |> Rules.findAll
                    [ "33(c)"
                    , "33(d)(1)"
                    , "33(d)(2)"
                    , "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    ]
        inflowAmount : Float
        inflowAmount =
            List.sum (List.map (\f -> second f) inflow_rules)

        supplemantal_rules : List Flow
        supplemantal_rules =
            Flows.supplementalRules level_2A_supplementals
                |> Rules.findAll
                    [ "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    , "20(a)(1)C"
                    ]

        supplementalAmount : Float
        supplementalAmount =
            List.sum (List.map (\f -> second f) supplemantal_rules)
    in
        inflowAmount + supplementalAmount

level_2B_HQLA_additive_values : DataTables -> Balance
level_2B_HQLA_additive_values data =
    let
        level_2B_inflow_assets : List Assets
        level_2B_inflow_assets =
            data.inflows.assets
            |> List.filter (\a -> isSubProduct a.subProduct SubProduct.isHQLALevel2B)

        level_2B_inflow_secured : List Inflows.Secured
        level_2B_inflow_secured =
             data.inflows.secured
             |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel2B)

        level_2B_inflows : DataTables.Inflows
        level_2B_inflows = { assets = level_2B_inflow_assets, other = [], secured = level_2B_inflow_secured, unsecured = [] }

        level_2B_supplemental_derivativesCollateral : List Supplemental.DerivativesCollateral
        level_2B_supplemental_derivativesCollateral =
             data.supplemental.derivativesCollateral
             |> List.filter (\d -> isSubProduct d.subProduct SubProduct.isHQLALevel2B)

        level_2B_supplementals : DataTables.Supplemental
        level_2B_supplementals = { balanceSheet = [], derivativesCollateral = level_2B_supplemental_derivativesCollateral, foreignExchange = [], informational = [], liquidityRiskMeasurement = []}

        inflow_rules : List Flow
        inflow_rules =
            Flows.inflowRules level_2B_inflows
                |> Rules.findAll
                    [ "33(c)"
                    , "33(d)(1)"
                    , "33(d)(2)"
                    , "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    ]
        inflowAmount : Float
        inflowAmount =
            List.sum (List.map (\f -> second f) inflow_rules)

        supplemantal_rules : List Flow
        supplemantal_rules =
            Flows.supplementalRules level_2B_supplementals
                |> Rules.findAll
                    [ "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    , "20(a)(1)C"
                    ]

        supplementalAmount : Float
        supplementalAmount =
            List.sum (List.map (\f -> second f) supplemantal_rules)
    in
        inflowAmount + supplementalAmount


level_1_HQLA_subtractive_values : DataTables -> Balance
level_1_HQLA_subtractive_values data =
    let
        level_1_supplemental_LiquidityRiskMeasurement : List LiquidityRiskMeasurement
        level_1_supplemental_LiquidityRiskMeasurement =
            data.supplemental.liquidityRiskMeasurement
        --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)

        level_1_suplementals : DataTables.Supplemental
        level_1_suplementals = { informational = [], derivativesCollateral = [], liquidityRiskMeasurement = level_1_supplemental_LiquidityRiskMeasurement, balanceSheet = [], foreignExchange = []}


        level_1_supplemental_DerivativesCollateral : List DerivativesCollateral
        level_1_supplemental_DerivativesCollateral =
           data.supplemental.derivativesCollateral
                --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)

        level_1_suplementals_derivates : DataTables.Supplemental
        level_1_suplementals_derivates = { informational = [], derivativesCollateral = level_1_supplemental_DerivativesCollateral, liquidityRiskMeasurement = [], balanceSheet = [], foreignExchange = []}


        --level_1_inflow_secured : List Inflows.Secured
        --level_1_inflow_secured =
        --    data.inflows.secured
        --    --|> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)
        --
        --level_1_inflow_assets : List Assets
        --level_1_inflow_assets =
        --    data.inflows.assets
        --    --|> List.filter (\a -> isSubProduct a.subProduct SubProduct.isHQLALevel1)

        --level_1_inflows : DataTables.Inflows
        --level_1_inflows = { assets = level_1_inflow_assets, other = [], secured = level_1_inflow_secured, unsecured = [] }
        ----
        supplemental_rules_liquidity_risk : List Flow
        supplemental_rules_liquidity_risk =
            Flows.supplementalRules level_1_suplementals
                |> Rules.findAll
                    [ "22(b)(3)L1"
                    , "22(a)(3)L1"
                    ]

        liquidity_risk_amount : Float
        liquidity_risk_amount =
            List.sum (List.map (\f -> second f) supplemental_rules_liquidity_risk)

        supplemental_rules_derivaties_collateral : List Flow
        supplemental_rules_derivaties_collateral =
            Flows.supplementalRules level_1_suplementals_derivates
                |> Rules.findAll
                    [ "22(b)(5)L1"]
        deravativesCollectoralAmt : Float
        deravativesCollectoralAmt =
            List.sum (List.map (\f -> second f) supplemental_rules_derivaties_collateral)

    in
        deravativesCollectoralAmt + liquidity_risk_amount

level_2A_HQLA_subtractive_values : DataTables -> Balance
level_2A_HQLA_subtractive_values data =
    let
        level_2A_supplemental_LiquidityRiskMeasurement : List LiquidityRiskMeasurement
        level_2A_supplemental_LiquidityRiskMeasurement =
            data.supplemental.liquidityRiskMeasurement
        --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)

        level_2A_suplementals : DataTables.Supplemental
        level_2A_suplementals = { informational = [], derivativesCollateral = [], liquidityRiskMeasurement = level_2A_supplemental_LiquidityRiskMeasurement, balanceSheet = [], foreignExchange = []}


        level_2A_supplemental_DerivativesCollateral : List DerivativesCollateral
        level_2A_supplemental_DerivativesCollateral =
           data.supplemental.derivativesCollateral
                --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)

        level_2A_suplementals_derivates : DataTables.Supplemental
        level_2A_suplementals_derivates = { informational = [], derivativesCollateral = level_2A_supplemental_DerivativesCollateral, liquidityRiskMeasurement = [], balanceSheet = [], foreignExchange = []}


        --level_1_inflow_secured : List Inflows.Secured
        --level_1_inflow_secured =
        --    data.inflows.secured
        --    --|> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)
        --
        --level_1_inflow_assets : List Assets
        --level_1_inflow_assets =
        --    data.inflows.assets
        --    --|> List.filter (\a -> isSubProduct a.subProduct SubProduct.isHQLALevel1)

        --level_1_inflows : DataTables.Inflows
        --level_1_inflows = { assets = level_1_inflow_assets, other = [], secured = level_1_inflow_secured, unsecured = [] }
        ----
        supplemental_rules_liquidity_risk : List Flow
        supplemental_rules_liquidity_risk =
            Flows.supplementalRules level_2A_suplementals
                |> Rules.findAll
                    [ "22(b)(3)L2a"
                    , "22(a)(3)L2a"
                    ]

        liquidity_risk_amount : Float
        liquidity_risk_amount =
            List.sum (List.map (\f -> second f) supplemental_rules_liquidity_risk)

        supplemental_rules_derivaties_collateral : List Flow
        supplemental_rules_derivaties_collateral =
            Flows.supplementalRules level_2A_suplementals_derivates
                |> Rules.findAll
                    [ "22(b)(5)L2a"]
        deravativesCollectoralAmt : Float
        deravativesCollectoralAmt =
            List.sum (List.map (\f -> second f) supplemental_rules_derivaties_collateral)

    in
        deravativesCollectoralAmt + liquidity_risk_amount


level_2B_HQLA_subtractive_values : DataTables -> Balance
level_2B_HQLA_subtractive_values data =
    let
        level_2B_supplemental_LiquidityRiskMeasurement : List LiquidityRiskMeasurement
        level_2B_supplemental_LiquidityRiskMeasurement =
            data.supplemental.liquidityRiskMeasurement
        --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)

        level_2B_suplementals : DataTables.Supplemental
        level_2B_suplementals = { informational = [], derivativesCollateral = [], liquidityRiskMeasurement = level_2B_supplemental_LiquidityRiskMeasurement, balanceSheet = [], foreignExchange = []}


        level_2B_supplemental_DerivativesCollateral : List DerivativesCollateral
        level_2B_supplemental_DerivativesCollateral =
           data.supplemental.derivativesCollateral
                --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)

        level_2B_suplementals_derivates : DataTables.Supplemental
        level_2B_suplementals_derivates = { informational = [], derivativesCollateral = level_2B_supplemental_DerivativesCollateral, liquidityRiskMeasurement = [], balanceSheet = [], foreignExchange = []}


        --level_1_inflow_secured : List Inflows.Secured
        --level_1_inflow_secured =
        --    data.inflows.secured
        --    --|> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)
        --
        --level_1_inflow_assets : List Assets
        --level_1_inflow_assets =
        --    data.inflows.assets
        --    --|> List.filter (\a -> isSubProduct a.subProduct SubProduct.isHQLALevel1)

        --level_1_inflows : DataTables.Inflows
        --level_1_inflows = { assets = level_1_inflow_assets, other = [], secured = level_1_inflow_secured, unsecured = [] }
        ----
        supplemental_rules_liquidity_risk : List Flow
        supplemental_rules_liquidity_risk =
            Flows.supplementalRules level_2B_suplementals
                |> Rules.findAll
                    [ "22(b)(3)L2b"
                    , "22(a)(3)L2b"
                    ]

        liquidity_risk_amount : Float
        liquidity_risk_amount =
            List.sum (List.map (\f -> second f) supplemental_rules_liquidity_risk)

        supplemental_rules_derivaties_collateral : List Flow
        supplemental_rules_derivaties_collateral =
            Flows.supplementalRules level_2B_suplementals_derivates
                |> Rules.findAll
                    [ "22(b)(5)L2b"]
        deravativesCollectoralAmt : Float
        deravativesCollectoralAmt =
            List.sum (List.map (\f -> second f) supplemental_rules_derivaties_collateral)

    in
        deravativesCollectoralAmt + liquidity_risk_amount


total_net_cash_outflows : Float -> DataTables.Outflows -> DataTables.Inflows -> Balance
total_net_cash_outflows outflow_adjustment_percentage outflows inflows =
    let
        outflows_summed : Float
        outflows_summed =
            List.map (\o -> second o) (Flows.outflowRules outflows) |> List.sum

        inflows_summed : Float
        inflows_summed =
            List.map (\o -> second o) (Flows.inflowRules inflows) |> List.sum
    in
    outflow_adjustment_percentage * (outflows_summed - min inflows_summed (0.75 * outflows_summed) + maturity_Mismatch_Add_On outflows inflows)


maturity_Mismatch_Add_On : DataTables.Outflows -> DataTables.Inflows -> Balance
maturity_Mismatch_Add_On out inf =
    let
        cum_outflow : Balance
        cum_outflow =
            max 0 (net_day30_cumulative_maturity_outflow_amount out inf)

        largest_outflow : Balance
        largest_outflow =
            max 0 (largest_net_cumulative_maturity_outflow_amount out inf)
    in
    largest_outflow - cum_outflow


cumulative_outflow_amount_from_one_to_m : Int -> DataTables.Outflows -> DataTables.Inflows -> Balance
cumulative_outflow_amount_from_one_to_m m out inf =
    let
        applicable_buckets : List Int
        applicable_buckets =
            List.range 1 m

        --maturity_buckets : Dict MaturityBucket (List Outflows)
        --maturity_buckets =
        --    Dict.empty
        --
        --outflows_flattened : List Outflows
        --outflows_flattened =
        --    deconstruct_outflows out
        outflow_rules : List Flow
        outflow_rules =
            Flows.outflowRules out
                |> Rules.findAll
                    [ "32(g)(1)"
                    , "32(g)(2)"
                    , "32(g)(3)"
                    , "32(g)(4)"
                    , "32(g)(5)"
                    , "32(g)(6)"
                    , "32(g)(7)"
                    , "32(g)(8)"
                    , "32(g)(9)"
                    , "32(h)(1)"
                    , "32(h)(2)"
                    , "32(h)(5)"
                    , "32(j)"
                    , "32(k)"
                    , "32(l)"
                    ]

        outflowAmount : Float
        outflowAmount =
            applicable_buckets
                -- TODO : figure out how to take maturity bucket into account
                -- |> List.concatMap (\n -> List.filter (getDayFromMaturityBucket .maturityBucket == n) outflow_rules)
                |> List.concatMap (\n -> outflow_rules)
                |> List.map (\( rule, amount ) -> amount)
                |> List.sum

        inflow_rules : List Flow
        inflow_rules =
            Flows.inflowRules inf
                |> Rules.findAll [ "33(c)", "33(d)", "33(e)", "33(f)" ]

        inflowAmount : Float
        inflowAmount =
            applicable_buckets
                -- TODO : figure out how to take maturity bucket into account
                -- |> List.concatMap (\n -> List.filter (getDayFromMaturityBucket .maturityBucket == n) inflow_rules)
                |> List.concatMap (\n -> inflow_rules)
                |> List.map (\( rule, amount ) -> amount)
                |> List.sum
    in
    outflowAmount - inflowAmount


largest_net_cumulative_maturity_outflow_amount : DataTables.Outflows -> DataTables.Inflows -> Balance
largest_net_cumulative_maturity_outflow_amount out inf =
    let
        maturityBuckets : List Int
        maturityBuckets =
            List.range 1 30

        cumulative_outflows : List Balance
        cumulative_outflows =
            List.map (\m -> cumulative_outflow_amount_from_one_to_m m out inf) maturityBuckets

        max_val : Maybe Balance
        max_val =
            List.maximum cumulative_outflows
    in
    case max_val of
        Just v ->
            v

        Nothing ->
            -1


net_day30_cumulative_maturity_outflow_amount : DataTables.Outflows -> DataTables.Inflows -> Balance
net_day30_cumulative_maturity_outflow_amount out inf =
    cumulative_outflow_amount_from_one_to_m 30 out inf


isSubProduct : Maybe SubProduct -> (SubProduct -> Bool) -> Bool
isSubProduct subProduct filter =
    case subProduct of
        Just sp ->
            filter sp

        Nothing ->
            False


--deconstruct_outflows : DataTables.Outflows -> List Outflows
--deconstruct_outflows out =
--    let
--        deposits : List Deposits
--        deposits =
--            out.deposits
--
--        other : List Other
--        other =
--            out.other
--
--        secured : List Secured
--        secured =
--            out.secured
--
--        wholesale : List Wholesale
--        wholesale =
--            out.wholesale
--    in
--    List.concat
--        [ List.map (\d -> Outflows.Deposits d) deposits
--        , List.map (\o -> Outflows.Other o) other
--        , List.map (\s -> Outflows.Secured s) secured
--        , List.map (\w -> Outflows.Wholesale w) wholesale
--        ]
--maturity_buckets_dict_out : Dict MaturityBucket (List Outflows) -> Outflows -> Dict MaturityBucket (List Outflows)
--maturity_buckets_dict_out dict_out out =
--    let
--        maturity_bucket : MaturityBucket
--        maturity_bucket =
--            get_maturity_bucket_from_outflow out
--
--        outflows_for_bucket : List Outflows
--        outflows_for_bucket =
--            List.singleton out
--
--        outflows : Maybe (List Outflows)
--        outflows =
--            Dict.get maturity_bucket dict_out
--    in
--    case outflows of
--        Just o ->
--            Dict.insert maturity_bucket (out :: o) dict_out
--
--        Nothing ->
--            Dict.insert maturity_bucket outflows_for_bucket dict_out
--get_maturity_bucket_from_outflow : Outflows -> MaturityBucket
--get_maturity_bucket_from_outflow out =
--    case out of
--        Outflows.Deposits d ->
--            d.maturityBucket
--
--        Outflows.Other o ->
--            o.maturityBucket
--
--        Outflows.Secured s ->
--            s.maturityBucket
--
--        Outflows.Wholesale w ->
--            w.maturityBucket
--getDayFromMaturityBucket : MaturityBucket -> Int
--getDayFromMaturityBucket bucket =
--    case bucket of
--        Day d ->
--            d
--
--        _ ->
--            -1
--type alias BucketRule =
--    { rule : String
--    , amount : Float
--    , maturityBucket : MaturityBucket
--    }


{-| Helper function to accumulated steps of a sum across a list. This is used in calculating the maturity mismatch add-on.
-}
accumulate : number -> List number -> List number
accumulate starter list =
    let
        ( sum, acc ) =
            List.foldl (\y ( x, xs ) -> ( x + y, (x + y) :: xs )) ( starter, [] ) list
    in
    List.reverse acc