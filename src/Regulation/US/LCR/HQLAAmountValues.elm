module Regulation.US.LCR.HQLAAmountValues exposing (..)

import Basics
import Regulation.US.FR2052A.DataTables as DataTables exposing (DataTables, Inflows)
import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (Assets)
import Regulation.US.FR2052A.DataTables.Inflows.Secured as Inflows
import Regulation.US.FR2052A.DataTables.Supplemental.DerivativesCollateral as Supplemental exposing (DerivativesCollateral)
import Regulation.US.FR2052A.DataTables.Supplemental.LiquidityRiskMeasurement exposing (LiquidityRiskMeasurement)
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct exposing (SubProduct, isSubProduct)
import Regulation.US.LCR.Basics exposing (Balance, Ratio)
import Regulation.US.LCR.Flows as Flows exposing (..)
import Regulation.US.LCR.Inflows.Assets as Assets
import Regulation.US.LCR.MaturityBucket exposing (FromDate)
import Regulation.US.LCR.Rules as Rules


level_1_HQLA_additive_values : FromDate -> DataTables -> Balance
level_1_HQLA_additive_values fromDate data =
    let
        level_1_inflow_assets : List Assets
        level_1_inflow_assets =
            data.inflows.assets
                |> List.filter (\a -> SubProduct.isSubProduct a.subProduct SubProduct.isHQLALevel1)

        level_1_inflow_secured : List Inflows.Secured
        level_1_inflow_secured =
            data.inflows.secured
                |> List.filter (\s -> SubProduct.isSubProduct s.subProduct SubProduct.isHQLALevel1)

        level_1_inflows : DataTables.Inflows
        level_1_inflows =
            { assets = level_1_inflow_assets, other = [], secured = level_1_inflow_secured, unsecured = [] }

        level_1_supplemental_derivativesCollateral : List Supplemental.DerivativesCollateral
        level_1_supplemental_derivativesCollateral =
            data.supplemental.derivativesCollateral
                |> List.filter (\d -> SubProduct.isSubProduct d.subProduct SubProduct.isHQLALevel1)

        level_1_supplementals : DataTables.Supplemental
        level_1_supplementals =
            { balanceSheet = [], derivativesCollateral = level_1_supplemental_derivativesCollateral, foreignExchange = [], informational = [], liquidityRiskMeasurement = [] }

        inflow_amount : Balance
        inflow_amount =
            Flows.applyInflowRules fromDate level_1_inflows
                |> Rules.matchAndSum
                    [ "33(c)"
                    , "33(d)(1)"
                    , "33(d)(2)"
                    , "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    ]

        supplemental_amount : Balance
        supplemental_amount =
            Flows.applySupplementalRules level_1_supplementals
                |> Rules.matchAndSum
                    [ "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    , "20(a)(1)C"
                    ]
    in
    inflow_amount + supplemental_amount


level_2A_HQLA_additive_values : FromDate -> DataTables -> Balance
level_2A_HQLA_additive_values fromDate data =
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
        level_2A_inflows =
            { assets = level_2A_inflow_assets, other = [], secured = level_2A_inflow_secured, unsecured = [] }

        level_2A_supplemental_derivativesCollateral : List Supplemental.DerivativesCollateral
        level_2A_supplemental_derivativesCollateral =
            data.supplemental.derivativesCollateral
                |> List.filter (\d -> isSubProduct d.subProduct SubProduct.isHQLALevel2A)

        level_2A_supplementals : DataTables.Supplemental
        level_2A_supplementals =
            { balanceSheet = [], derivativesCollateral = level_2A_supplemental_derivativesCollateral, foreignExchange = [], informational = [], liquidityRiskMeasurement = [] }

        inflow_amount : Balance
        inflow_amount =
            Flows.applyInflowRules fromDate level_2A_inflows
                |> Rules.matchAndSum
                    [ "33(c)"
                    , "33(d)(1)"
                    , "33(d)(2)"
                    , "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    ]

        supplemental_amount : Balance
        supplemental_amount =
            Flows.applySupplementalRules level_2A_supplementals
                |> Rules.matchAndSum
                    [ "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    , "20(a)(1)C"
                    ]
    in
    inflow_amount + supplemental_amount


level_2B_HQLA_additive_values : FromDate -> DataTables -> Balance
level_2B_HQLA_additive_values fromDate data =
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
        level_2B_inflows =
            { assets = level_2B_inflow_assets, other = [], secured = level_2B_inflow_secured, unsecured = [] }

        level_2B_supplemental_derivativesCollateral : List Supplemental.DerivativesCollateral
        level_2B_supplemental_derivativesCollateral =
            data.supplemental.derivativesCollateral
                |> List.filter (\d -> isSubProduct d.subProduct SubProduct.isHQLALevel2B)

        level_2B_supplementals : DataTables.Supplemental
        level_2B_supplementals =
            { balanceSheet = [], derivativesCollateral = level_2B_supplemental_derivativesCollateral, foreignExchange = [], informational = [], liquidityRiskMeasurement = [] }

        inflow_amount : Balance
        inflow_amount =
            Flows.applyInflowRules fromDate level_2B_inflows
                |> Rules.matchAndSum
                    [ "33(c)"
                    , "33(d)(1)"
                    , "33(d)(2)"
                    , "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    ]

        supplemental_amount : Balance
        supplemental_amount =
            Flows.applySupplementalRules level_2B_supplementals
                |> Rules.matchAndSum
                    [ "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    , "20(a)(1)C"
                    ]
    in
    inflow_amount + supplemental_amount


level_1_HQLA_subtractive_values : DataTables -> Balance
level_1_HQLA_subtractive_values data =
    let
        level_1_supplemental_LiquidityRiskMeasurement : List LiquidityRiskMeasurement
        level_1_supplemental_LiquidityRiskMeasurement =
            data.supplemental.liquidityRiskMeasurement

        --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)
        level_1_supplementals : DataTables.Supplemental
        level_1_supplementals =
            { informational = [], derivativesCollateral = [], liquidityRiskMeasurement = level_1_supplemental_LiquidityRiskMeasurement, balanceSheet = [], foreignExchange = [] }

        level_1_supplemental_DerivativesCollateral : List DerivativesCollateral
        level_1_supplemental_DerivativesCollateral =
            data.supplemental.derivativesCollateral

        --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)
        level_1_supplementals_derivatives : DataTables.Supplemental
        level_1_supplementals_derivatives =
            { informational = [], derivativesCollateral = level_1_supplemental_DerivativesCollateral, liquidityRiskMeasurement = [], balanceSheet = [], foreignExchange = [] }

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
        liquidity_risk_amount : Balance
        liquidity_risk_amount =
            Flows.applySupplementalRules level_1_supplementals
                |> Rules.matchAndSum
                    [ "22(b)(3)L1"
                    , "22(a)(3)L1"
                    ]

        derivatives_collateral_amount : Balance
        derivatives_collateral_amount =
            Flows.applySupplementalRules level_1_supplementals_derivatives
                |> Rules.matchAndSum
                    [ "22(b)(5)L1" ]
    in
    derivatives_collateral_amount + liquidity_risk_amount


level_2A_HQLA_subtractive_values : DataTables -> Balance
level_2A_HQLA_subtractive_values data =
    let
        level_2A_supplemental_LiquidityRiskMeasurement : List LiquidityRiskMeasurement
        level_2A_supplemental_LiquidityRiskMeasurement =
            data.supplemental.liquidityRiskMeasurement

        --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)
        level_2A_supplementals : DataTables.Supplemental
        level_2A_supplementals =
            { informational = [], derivativesCollateral = [], liquidityRiskMeasurement = level_2A_supplemental_LiquidityRiskMeasurement, balanceSheet = [], foreignExchange = [] }

        level_2A_supplemental_DerivativesCollateral : List DerivativesCollateral
        level_2A_supplemental_DerivativesCollateral =
            data.supplemental.derivativesCollateral

        --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)
        level_2A_supplementals_derivatives : DataTables.Supplemental
        level_2A_supplementals_derivatives =
            { informational = [], derivativesCollateral = level_2A_supplemental_DerivativesCollateral, liquidityRiskMeasurement = [], balanceSheet = [], foreignExchange = [] }

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
        liquidity_risk_amount : Balance
        liquidity_risk_amount =
            Flows.applySupplementalRules level_2A_supplementals
                |> Rules.matchAndSum
                    [ "22(b)(3)L2a"
                    , "22(a)(3)L2a"
                    ]

        derivatives_collateral_amount : Balance
        derivatives_collateral_amount =
            Flows.applySupplementalRules level_2A_supplementals_derivatives
                |> Rules.matchAndSum
                    [ "22(b)(5)L2a" ]
    in
    derivatives_collateral_amount + liquidity_risk_amount


level_2B_HQLA_subtractive_values : DataTables -> Balance
level_2B_HQLA_subtractive_values data =
    let
        level_2B_supplemental_LiquidityRiskMeasurement : List LiquidityRiskMeasurement
        level_2B_supplemental_LiquidityRiskMeasurement =
            data.supplemental.liquidityRiskMeasurement

        --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)
        level_2B_supplementals : DataTables.Supplemental
        level_2B_supplementals =
            { informational = [], derivativesCollateral = [], liquidityRiskMeasurement = level_2B_supplemental_LiquidityRiskMeasurement, balanceSheet = [], foreignExchange = [] }

        level_2B_supplemental_DerivativesCollateral : List DerivativesCollateral
        level_2B_supplemental_DerivativesCollateral =
            data.supplemental.derivativesCollateral

        --    |> List.filter (\s -> isSubProduct s.subProduct SubProduct.isHQLALevel1)
        level_2B_supplementals_derivatives : DataTables.Supplemental
        level_2B_supplementals_derivatives =
            { informational = [], derivativesCollateral = level_2B_supplemental_DerivativesCollateral, liquidityRiskMeasurement = [], balanceSheet = [], foreignExchange = [] }

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
        liquidity_risk_amount : Balance
        liquidity_risk_amount =
            Flows.applySupplementalRules level_2B_supplementals
                |> Rules.matchAndSum
                    [ "22(b)(3)L2b"
                    , "22(a)(3)L2b"
                    ]

        derivatives_collateral_amount : Balance
        derivatives_collateral_amount =
            Flows.applySupplementalRules level_2B_supplementals_derivatives
                |> Rules.matchAndSum
                    [ "22(b)(5)L2b" ]
    in
    derivatives_collateral_amount + liquidity_risk_amount



---------- Aggregation Functions
-- 1A


secured_lending_unwind_maturity_amounts : FromDate -> DataTables -> Balance
secured_lending_unwind_maturity_amounts fromDate data =
    Flows.applyInflowRules fromDate data.inflows
        |> Rules.matchAndSum
            [ "21(a)(todo)" ]


secured_lending_unwind_collateral_values_with_level_1_collateral_class : FromDate -> DataTables -> Balance
secured_lending_unwind_collateral_values_with_level_1_collateral_class fromDate data =
    Flows.applyInflowRules fromDate data.inflows
        |> Rules.matchAndSum
            [ "33(f)(1)(iii)" ]


secured_funding_unwind_maturity_amounts : FromDate -> DataTables -> Balance
secured_funding_unwind_maturity_amounts fromDate data =
    Flows.applyOutflowRules fromDate data.outflows
        |> Rules.matchAndSum
            [ "21(b)(todo)" ]


secured_funding_unwind_collateral_values_with_level_1_collateral_class : FromDate -> DataTables -> Balance
secured_funding_unwind_collateral_values_with_level_1_collateral_class fromDate data =
    Flows.applyOutflowRules fromDate data.outflows
        |> Rules.matchAndSum
            [ "32(j)(1)(i)" ]


asset_exchange_unwind_maturity_amounts_with_level_1_subProduct : FromDate -> DataTables -> Balance
asset_exchange_unwind_maturity_amounts_with_level_1_subProduct fromDate data =
    Flows.applyInflowRules fromDate data.inflows
        |> Rules.matchAndSum
            [ "21(c)(todo)" ]


asset_exchange_unwind_collateral_values_with_level_1_collateral_class : FromDate -> DataTables -> Balance
asset_exchange_unwind_collateral_values_with_level_1_collateral_class fromDate data =
    Flows.applyInflowRules fromDate data.inflows
        |> Rules.matchAndSum
            [ "33(f)(2)(i)" ]



--2A


secured_lending_unwind_collateral_values_with_level_2A_collateral_class : FromDate -> DataTables -> Balance
secured_lending_unwind_collateral_values_with_level_2A_collateral_class fromDate data =
    Flows.applyInflowRules fromDate data.inflows
        |> Rules.matchAndSum
            [ "33(f)(1)(iv)" ]


secured_funding_unwind_collateral_values_with_level_2A_collateral_class : FromDate -> DataTables -> Balance
secured_funding_unwind_collateral_values_with_level_2A_collateral_class fromDate data =
    Flows.applyOutflowRules fromDate data.outflows
        |> Rules.matchAndSum
            [ "32(j)(1)(ii)" ]


asset_exchange_unwind_maturity_amounts_with_level_2A_subProduct : FromDate -> DataTables -> Balance
asset_exchange_unwind_maturity_amounts_with_level_2A_subProduct fromDate data =
    Flows.applyInflowRules fromDate data.inflows
        |> Rules.matchAndSum
            [ "32(j)(3)(ii)" ]


asset_exchange_unwind_collateral_values_with_level_2A_collateral_class : FromDate -> DataTables -> Balance
asset_exchange_unwind_collateral_values_with_level_2A_collateral_class fromDate data =
    Flows.applyInflowRules fromDate data.inflows
        |> Rules.matchAndSum
            [ "21(c)(todo)" ]



-- 2B


secured_lending_unwind_collateral_values_with_level_2B_collateral_class : FromDate -> DataTables -> Balance
secured_lending_unwind_collateral_values_with_level_2B_collateral_class fromDate data =
    Flows.applyInflowRules fromDate data.inflows
        |> Rules.matchAndSum
            [ "33(f)(1)(v)" ]


secured_funding_unwind_collateral_values_with_level_2B_collateral_class : FromDate -> DataTables -> Balance
secured_funding_unwind_collateral_values_with_level_2B_collateral_class fromDate data =
    Flows.applyOutflowRules fromDate data.outflows
        |> Rules.matchAndSum
            [ "32(j)(1)(iv)" ]


asset_exchange_unwind_maturity_amounts_with_level_2B_subProduct : FromDate -> DataTables -> Balance
asset_exchange_unwind_maturity_amounts_with_level_2B_subProduct fromDate data =
    Flows.applyInflowRules fromDate data.inflows
        |> Rules.matchAndSum
            [ "32(j)(3)(iii)" ]


asset_exchange_unwind_collateral_values_with_level_2B_collateral_class : FromDate -> DataTables -> Balance
asset_exchange_unwind_collateral_values_with_level_2B_collateral_class fromDate data =
    Flows.applyInflowRules fromDate data.inflows
        |> Rules.matchAndSum
            [ "21(c)(todo)" ]
