module Regulation.US.FR2052A.DataTables.Supplemental.DerivativesCollateral exposing (..)


import Regulation.US.FR2052A.Fields.BusinessLine exposing (BusinessLine)
import Regulation.US.FR2052A.Fields.CollateralClass exposing (CollateralClass)
import Regulation.US.FR2052A.Fields.CollateralLevel exposing (CollateralLevel)
import Regulation.US.FR2052A.Fields.Converted exposing (Converted)
import Regulation.US.FR2052A.Fields.Counterparty exposing (Counterparty)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency)
import Regulation.US.FR2052A.Fields.EffectiveMaturityBucket exposing (EffectiveMaturityBucket)
import Regulation.US.FR2052A.Fields.EncumbranceType exposing (EncumbranceType)
import Regulation.US.FR2052A.Fields.GSIB exposing (GSIB)
import Regulation.US.FR2052A.Fields.Internal exposing (Internal)
import Regulation.US.FR2052A.Fields.InternalCounterparty exposing (InternalCounterparty)
import Regulation.US.FR2052A.Fields.MarketValue exposing (MarketValue)
import Regulation.US.FR2052A.Fields.NettingEligible exposing (NettingEligible)
import Regulation.US.FR2052A.Fields.ReportingEntity exposing (ReportingEntity)
import Regulation.US.FR2052A.Fields.SubProduct exposing (SubProduct)
import Regulation.US.FR2052A.Fields.SubProduct2 exposing (SubProduct2)
import Regulation.US.FR2052A.Fields.TreasuryControl exposing (TreasuryControl)


{-| Represents a record in the Supplemental - Derivatives & Collateral data table.
-}
type alias DerivativesCollateral =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , product : Product
    , subProduct : Maybe SubProduct
    , subProduct2 : Maybe SubProduct2
    , marketValue : MarketValue
    , collateralClass : Maybe CollateralClass
    , collateralLevel : Maybe CollateralLevel
    , counterparty : Maybe Counterparty
    , gSIB : Maybe GSIB
    , effectiveMaturityBucket : Maybe EffectiveMaturityBucket
    , encumbranceType : Maybe EncumbranceType
    , nettingEligible : Maybe NettingEligible
    , treasuryControl : Maybe TreasuryControl
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    , businessLine : BusinessLine
    }


{-| Represents all Supplemental - Derivatives & Collateral products:

  - S.DC.1: Gross Derivative Asset Values (as `GrossDerivativeAssetValues`)
  - S.DC.2: Gross Derivative Liability Values (as `GrossDerivativeLiabilityValues`)
  - S.DC.3: Derivative Settlement Payments Delivered (as `DerivativeSettlementPaymentsDelivered`)
  - S.DC.4: Derivative Settlement Payments Received (as `DerivativeSettlementPaymentsReceived`)
  - S.DC.5: Initial Margin Posted - House (as `InitialMarginPostedHouse`)
  - S.DC.6: Initial Margin Posted - Customer (as `InitialMarginPostedCustomer`)
  - S.DC.7: Initial Margin Received (as `InitialMarginReceived`)
  - S.DC.8: Variation Margin Posted - House (as `VariationMarginPostedHouse`)
  - S.DC.9: Variation Margin Posted - Customer (as `VariationMarginPostedCustomer`)
  - S.DC.10: Variation Margin Received (as `VariationMarginReceived`)
  - S.DC.11: Derivative CCP Default Fund Contribution (as `DerivativeCCPDefaultFundContribution`)
  - S.DC.12: Other CCP Pledges and Contributions (as `OtherCCPPledgesAndContributions`)
  - S.DC.13: Collateral Disputes Deliverables (as `CollateralDisputesDeliverables`)
  - S.DC.14: Collateral Disputes Receivables (as `CollateralDisputesReceivables`)
  - S.DC.15: Sleeper Collateral Deliverables (as `SleeperCollateralDeliverables`)
  - S.DC.16: Required Collateral Deliverables (as `RequiredCollateralDeliverables`)
  - S.DC.17: Sleeper Collateral Receivables (as `SleeperCollateralReceivables`)
  - S.DC.18: Derivative Collateral Substitution Risk (as `DerivativeCollateralSubstitutionRisk`)
  - S.DC.19: Derivative Collateral Substitution Capacity (as `DerivativeCollateralSubstitutionCapacity`)
  - S.DC.20: Other Collateral Substitution Risk (as `OtherCollateralSubstitutionRisk`)
  - S.DC.21: Other Collateral Substitution Capacity (as `OtherCollateralSubstitutionCapacity`)

-}
type Product
    = GrossDerivativeAssetValues
    | GrossDerivativeLiabilityValues
    | DerivativeSettlementPaymentsDelivered
    | DerivativeSettlementPaymentsReceived
    | InitialMarginPostedHouse
    | InitialMarginPostedCustomer
    | InitialMarginReceived
    | VariationMarginPostedHouse
    | VariationMarginPostedCustomer
    | VariationMarginReceived
    | DerivativeCCPDefaultFundContribution
    | OtherCCPPledgesAndContributions
    | CollateralDisputesDeliverables
    | CollateralDisputesReceivables
    | SleeperCollateralDeliverables
    | RequiredCollateralDeliverables
    | SleeperCollateralReceivables
    | DerivativeCollateralSubstitutionRisk
    | DerivativeCollateralSubstitutionCapacity
    | OtherCollateralSubstitutionRisk
    | OtherCollateralSubstitutionCapacity


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just GrossDerivativeAssetValues

        2 ->
            Just GrossDerivativeLiabilityValues

        3 ->
            Just DerivativeSettlementPaymentsDelivered

        4 ->
            Just DerivativeSettlementPaymentsReceived

        5 ->
            Just InitialMarginPostedHouse

        6 ->
            Just InitialMarginPostedCustomer

        7 ->
            Just InitialMarginReceived

        8 ->
            Just VariationMarginPostedHouse

        9 ->
            Just VariationMarginPostedCustomer

        10 ->
            Just VariationMarginReceived

        11 ->
            Just DerivativeCCPDefaultFundContribution

        12 ->
            Just OtherCCPPledgesAndContributions

        13 ->
            Just CollateralDisputesDeliverables

        14 ->
            Just CollateralDisputesReceivables

        15 ->
            Just SleeperCollateralDeliverables

        16 ->
            Just RequiredCollateralDeliverables

        17 ->
            Just SleeperCollateralReceivables

        18 ->
            Just DerivativeCollateralSubstitutionRisk

        19 ->
            Just DerivativeCollateralSubstitutionCapacity

        20 ->
            Just OtherCollateralSubstitutionRisk

        21 ->
            Just OtherCollateralSubstitutionCapacity

        _ ->
            Nothing


{-| S.DC.1: Supplemental - Derivatives & Collateral - Gross Derivative Asset Values
-}
s_DC_1 : Product
s_DC_1 =
    GrossDerivativeAssetValues


{-| S.DC.2: Supplemental - Derivatives & Collateral - Gross Derivative Liability Values
-}
s_DC_2 : Product
s_DC_2 =
    GrossDerivativeLiabilityValues


{-| S.DC.3: Supplemental - Derivatives & Collateral - Derivative Settlement Payments Delivered
-}
s_DC_3 : Product
s_DC_3 =
    DerivativeSettlementPaymentsDelivered


{-| S.DC.4: Supplemental - Derivatives & Collateral - Derivative Settlement Payments Received
-}
s_DC_4 : Product
s_DC_4 =
    DerivativeSettlementPaymentsReceived


{-| S.DC.5: Supplemental - Derivatives & Collateral - Initial Margin Posted - House
-}
s_DC_5 : Product
s_DC_5 =
    InitialMarginPostedHouse


{-| S.DC.6: Supplemental - Derivatives & Collateral - Initial Margin Posted - Customer
-}
s_DC_6 : Product
s_DC_6 =
    InitialMarginPostedCustomer


{-| S.DC.7: Supplemental - Derivatives & Collateral - Initial Margin Received
-}
s_DC_7 : Product
s_DC_7 =
    InitialMarginReceived


{-| S.DC.8: Supplemental - Derivatives & Collateral - Variation Margin Posted - House
-}
s_DC_8 : Product
s_DC_8 =
    VariationMarginPostedHouse


{-| S.DC.9: Supplemental - Derivatives & Collateral - Variation Margin Posted - Customer
-}
s_DC_9 : Product
s_DC_9 =
    VariationMarginPostedCustomer


{-| S.DC.10: Supplemental - Derivatives & Collateral - Variation Margin Received
-}
s_DC_10 : Product
s_DC_10 =
    VariationMarginReceived


{-| S.DC.11: Supplemental - Derivatives & Collateral - Derivative CCP Default Fund Contribution
-}
s_DC_11 : Product
s_DC_11 =
    DerivativeCCPDefaultFundContribution


{-| S.DC.12: Supplemental - Derivatives & Collateral - Other CCP Pledges and Contributions
-}
s_DC_12 : Product
s_DC_12 =
    OtherCCPPledgesAndContributions


{-| S.DC.13: Supplemental - Derivatives & Collateral - Collateral Disputes Deliverables
-}
s_DC_13 : Product
s_DC_13 =
    CollateralDisputesDeliverables


{-| S.DC.14: Supplemental - Derivatives & Collateral - Collateral Disputes Receivables
-}
s_DC_14 : Product
s_DC_14 =
    CollateralDisputesReceivables


{-| S.DC.15: Supplemental - Derivatives & Collateral - Sleeper Collateral Deliverables
-}
s_DC_15 : Product
s_DC_15 =
    SleeperCollateralDeliverables


{-| S.DC.16: Supplemental - Derivatives & Collateral - Required Collateral Deliverables
-}
s_DC_16 : Product
s_DC_16 =
    RequiredCollateralDeliverables


{-| S.DC.17: Supplemental - Derivatives & Collateral - Sleeper Collateral Receivables
-}
s_DC_17 : Product
s_DC_17 =
    SleeperCollateralReceivables


{-| S.DC.18: Supplemental - Derivatives & Collateral - Derivative Collateral Substitution Risk
-}
s_DC_18 : Product
s_DC_18 =
    DerivativeCollateralSubstitutionRisk


{-| S.DC.19: Supplemental - Derivatives & Collateral - Derivative Collateral Substitution Capacity
-}
s_DC_19 : Product
s_DC_19 =
    DerivativeCollateralSubstitutionCapacity


{-| S.DC.20: Supplemental - Derivatives & Collateral - Other Collateral Substitution Risk
-}
s_DC_20 : Product
s_DC_20 =
    OtherCollateralSubstitutionRisk


{-| S.DC.21: Supplemental - Derivatives & Collateral - Other Collateral Substitution Capacity
-}
s_DC_21 : Product
s_DC_21 =
    OtherCollateralSubstitutionCapacity