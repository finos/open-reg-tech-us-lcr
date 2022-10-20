module Regulation.US.FR2052A.DataTables.Supplemental.LiquidityRiskMeasurement exposing (..)


import Regulation.US.FR2052A.Fields.CollateralClass exposing (CollateralClass)
import Regulation.US.FR2052A.Fields.Converted exposing (Converted)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency)
import Regulation.US.FR2052A.Fields.Internal exposing (Internal)
import Regulation.US.FR2052A.Fields.InternalCounterparty exposing (InternalCounterparty)
import Regulation.US.FR2052A.Fields.MarketValue exposing (MarketValue)
import Regulation.US.FR2052A.Fields.ReportingEntity exposing (ReportingEntity)


{-| Represents a record in the Supplemental - Liquidity Risk Measurement data table.
-}
type alias LiquidityRiskMeasurement =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , product : Product
    , marketValue : MarketValue
    , collateralClass : Maybe CollateralClass
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    }


{-| Represents all Supplemental - Liquidity Risk Measurement products:

  - S.L.1: Subsidiary Liquidity That Cannot Be Transferred (as `SubsidiaryLiquidityThatCannotBeTransferred`)
  - S.L.2: Subsidiary Liquidity Available for Transfer (as `SubsidiaryLiquidityAvailableForTransfer`)
  - S.L.3: Unencumbered Asset Hedges – Early Termination Outflows (as `UnencumberedAssetHedgesEarlyTerminationOutflows`)
  - S.L.4: Non-Structured Debt Maturing in Greater than 30-days – Primary Market Maker (as `NonStructuredDebtMaturingInGreaterThan30DaysPrimaryMarketMaker`)
  - S.L.5: Structured Debt Maturing in Greater than 30-days – Primary Market Maker (as `StructuredDebtMaturingInGreaterThan30DaysPrimaryMarketMaker`)
  - S.L.6: Liquidity Coverage Ratio (as `LiquidityCoverageRatio`)
  - S.L.7: Subsidiary Funding That Cannot Be Transferred (as `SubsidiaryFundingThatCannotBeTransferred`)
  - S.L.8: Subsidiary Funding Available for Transfer (as `SubsidiaryFundingAvailableForTransfer`)
  - S.L.9: Additional Funding Requirement for Off-Balance Sheet Rehypothecated Assets (as `AdditionalFundingRequirementForOffBalanceSheetRehypothecatedAssets`)
  - S.L.10: Net Stable Funding Ratio (as `NetStableFundingRatio`)

-}
type Product
    = SubsidiaryLiquidityThatCannotBeTransferred
    | SubsidiaryLiquidityAvailableForTransfer
    | UnencumberedAssetHedgesEarlyTerminationOutflows
    | NonStructuredDebtMaturingInGreaterThan30DaysPrimaryMarketMaker
    | StructuredDebtMaturingInGreaterThan30DaysPrimaryMarketMaker
    | LiquidityCoverageRatio
    | SubsidiaryFundingThatCannotBeTransferred
    | SubsidiaryFundingAvailableForTransfer
    | AdditionalFundingRequirementForOffBalanceSheetRehypothecatedAssets
    | NetStableFundingRatio


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just SubsidiaryLiquidityThatCannotBeTransferred

        2 ->
            Just SubsidiaryLiquidityAvailableForTransfer

        3 ->
            Just UnencumberedAssetHedgesEarlyTerminationOutflows

        4 ->
            Just NonStructuredDebtMaturingInGreaterThan30DaysPrimaryMarketMaker

        5 ->
            Just StructuredDebtMaturingInGreaterThan30DaysPrimaryMarketMaker

        6 ->
            Just LiquidityCoverageRatio

        7 ->
            Just SubsidiaryFundingThatCannotBeTransferred

        8 ->
            Just SubsidiaryFundingAvailableForTransfer

        9 ->
            Just AdditionalFundingRequirementForOffBalanceSheetRehypothecatedAssets

        10 ->
            Just NetStableFundingRatio

        _ ->
            Nothing


{-| S.L.1: Supplemental - Liquidity Risk Measurement - Subsidiary Liquidity That Cannot Be Transferred
-}
s_L_1 : Product
s_L_1 =
    SubsidiaryLiquidityThatCannotBeTransferred


{-| S.L.2: Supplemental - Liquidity Risk Measurement - Subsidiary Liquidity Available for Transfer
-}
s_L_2 : Product
s_L_2 =
    SubsidiaryLiquidityAvailableForTransfer


{-| S.L.3: Supplemental - Liquidity Risk Measurement - Unencumbered Asset Hedges – Early Termination Outflows
-}
s_L_3 : Product
s_L_3 =
    UnencumberedAssetHedgesEarlyTerminationOutflows


{-| S.L.4: Supplemental - Liquidity Risk Measurement - Non-Structured Debt Maturing in Greater than 30-days – Primary Market Maker
-}
s_L_4 : Product
s_L_4 =
    NonStructuredDebtMaturingInGreaterThan30DaysPrimaryMarketMaker


{-| S.L.5: Supplemental - Liquidity Risk Measurement - Structured Debt Maturing in Greater than 30-days – Primary Market Maker
-}
s_L_5 : Product
s_L_5 =
    StructuredDebtMaturingInGreaterThan30DaysPrimaryMarketMaker


{-| S.L.6: Supplemental - Liquidity Risk Measurement - Liquidity Coverage Ratio
-}
s_L_6 : Product
s_L_6 =
    LiquidityCoverageRatio


{-| S.L.7: Supplemental - Liquidity Risk Measurement - Subsidiary Funding That Cannot Be Transferred
-}
s_L_7 : Product
s_L_7 =
    SubsidiaryFundingThatCannotBeTransferred


{-| S.L.8: Supplemental - Liquidity Risk Measurement - Subsidiary Funding Available for Transfer
-}
s_L_8 : Product
s_L_8 =
    SubsidiaryFundingAvailableForTransfer


{-| S.L.9: Supplemental - Liquidity Risk Measurement - Additional Funding Requirement for Off-Balance Sheet Rehypothecated Assets
-}
s_L_9 : Product
s_L_9 =
    AdditionalFundingRequirementForOffBalanceSheetRehypothecatedAssets


{-| S.L.10: Supplemental - Liquidity Risk Measurement - Net Stable Funding Ratio
-}
s_L_10 : Product
s_L_10 =
    NetStableFundingRatio