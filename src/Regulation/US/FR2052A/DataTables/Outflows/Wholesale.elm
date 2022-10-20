module Regulation.US.FR2052A.DataTables.Outflows.Wholesale exposing (..)


import Regulation.US.FR2052A.Fields.BusinessLine exposing (BusinessLine)
import Regulation.US.FR2052A.Fields.CollateralClass exposing (CollateralClass)
import Regulation.US.FR2052A.Fields.CollateralValue exposing (CollateralValue)
import Regulation.US.FR2052A.Fields.Converted exposing (Converted)
import Regulation.US.FR2052A.Fields.Counterparty exposing (Counterparty)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency)
import Regulation.US.FR2052A.Fields.ForwardStartAmount exposing (ForwardStartAmount)
import Regulation.US.FR2052A.Fields.ForwardStartBucket exposing (ForwardStartBucket)
import Regulation.US.FR2052A.Fields.GSIB exposing (GSIB)
import Regulation.US.FR2052A.Fields.Internal exposing (Internal)
import Regulation.US.FR2052A.Fields.InternalCounterparty exposing (InternalCounterparty)
import Regulation.US.FR2052A.Fields.LossAbsorbency exposing (LossAbsorbency)
import Regulation.US.FR2052A.Fields.MaturityAmount exposing (MaturityAmount)
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket)
import Regulation.US.FR2052A.Fields.MaturityOptionality exposing (MaturityOptionality)
import Regulation.US.FR2052A.Fields.ReportingEntity exposing (ReportingEntity)


{-| Represents a record in the Outflows - Wholesale data table.
-}
type alias Wholesale =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , product : Product
    , counterparty : Maybe Counterparty
    , gSIB : Maybe GSIB
    , maturityAmount : MaturityAmount
    , maturityBucket : MaturityBucket
    , maturityOptionality : Maybe MaturityOptionality
    , collateralClass : Maybe CollateralClass
    , collateralValue : Maybe CollateralValue
    , forwardStartAmount : Maybe ForwardStartAmount
    , forwardStartBucket : Maybe ForwardStartBucket
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    , lossAbsorbency : Maybe LossAbsorbency
    , businessLine : BusinessLine
    }


{-| Represents all Outflows - Wholesale products:

  - O.W.1: Asset-Backed Commercial Paper (ABCP) Single-Seller (as `AssetBackedCommercialPaperSingleSeller`)
  - O.W.2: Asset-Backed Commercial Paper (ABCP) Multi-Seller (as `AssetBackedCommercialPaperMultiSeller`)
  - O.W.3: Collateralized Commercial Paper (as `CollateralizedCommercialPaper`)
  - O.W.4: Asset-Backed Securities (ABS) (as `AssetBackedSecurities`)
  - O.W.5: Covered Bonds (as `CoveredBonds`)
  - O.W.6: Tender Option Bonds (as `TenderOptionBonds`)
  - O.W.7: Other Asset-Backed Financing (as `OtherAssetBackedFinancing`)
  - O.W.8: Commercial Paper (as `CommercialPaper`)
  - O.W.9: Onshore Borrowing (as `OnshoreBorrowing`)
  - O.W.10: Offshore Borrowing (as `OffshoreBorrowing`)
  - O.W.11: Unstructured Long Term Debt (as `UnstructuredLongTermDebt`)
  - O.W.12: Structured Long Term Debt (as `StructuredLongTermDebt`)
  - O.W.13: Government Supported Debt (as `GovernmentSupportedDebt`)
  - O.W.14: Unsecured Notes (as `UnsecuredNotes`)
  - O.W.15: Structured Notes (as `StructuredNotes`)
  - O.W.16: Wholesale CDs (as `WholesaleCDs`)
  - O.W.17: Draws on Committed Lines (as `DrawsOnCommittedLines`)
  - O.W.18: Free Credits (as `FreeCredits`)
  - O.W.19: Other Unsecured Financing (as `OtherUnsecuredFinancing`)

-}
type Product
    = AssetBackedCommercialPaperSingleSeller
    | AssetBackedCommercialPaperMultiSeller
    | CollateralizedCommercialPaper
    | AssetBackedSecurities
    | CoveredBonds
    | TenderOptionBonds
    | OtherAssetBackedFinancing
    | CommercialPaper
    | OnshoreBorrowing
    | OffshoreBorrowing
    | UnstructuredLongTermDebt
    | StructuredLongTermDebt
    | GovernmentSupportedDebt
    | UnsecuredNotes
    | StructuredNotes
    | WholesaleCDs
    | DrawsOnCommittedLines
    | FreeCredits
    | OtherUnsecuredFinancing


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just AssetBackedCommercialPaperSingleSeller

        2 ->
            Just AssetBackedCommercialPaperMultiSeller

        3 ->
            Just CollateralizedCommercialPaper

        4 ->
            Just AssetBackedSecurities

        5 ->
            Just CoveredBonds

        6 ->
            Just TenderOptionBonds

        7 ->
            Just OtherAssetBackedFinancing

        8 ->
            Just CommercialPaper

        9 ->
            Just OnshoreBorrowing

        10 ->
            Just OffshoreBorrowing

        11 ->
            Just UnstructuredLongTermDebt

        12 ->
            Just StructuredLongTermDebt

        13 ->
            Just GovernmentSupportedDebt

        14 ->
            Just UnsecuredNotes

        15 ->
            Just StructuredNotes

        16 ->
            Just WholesaleCDs

        17 ->
            Just DrawsOnCommittedLines

        18 ->
            Just FreeCredits

        19 ->
            Just OtherUnsecuredFinancing

        _ ->
            Nothing


{-| O.W.1: Outflows - Wholesale - Asset-Backed Commercial Paper (ABCP) Single-Seller
-}
o_W_1 : Product
o_W_1 =
    AssetBackedCommercialPaperSingleSeller


{-| O.W.2: Outflows - Wholesale - Asset-Backed Commercial Paper (ABCP) Multi-Seller
-}
o_W_2 : Product
o_W_2 =
    AssetBackedCommercialPaperMultiSeller


{-| O.W.3: Outflows - Wholesale - Collateralized Commercial Paper
-}
o_W_3 : Product
o_W_3 =
    CollateralizedCommercialPaper


{-| O.W.4: Outflows - Wholesale - Asset-Backed Securities (ABS)
-}
o_W_4 : Product
o_W_4 =
    AssetBackedSecurities


{-| O.W.5: Outflows - Wholesale - Covered Bonds
-}
o_W_5 : Product
o_W_5 =
    CoveredBonds


{-| O.W.6: Outflows - Wholesale - Tender Option Bonds
-}
o_W_6 : Product
o_W_6 =
    TenderOptionBonds


{-| O.W.7: Outflows - Wholesale - Other Asset-Backed Financing
-}
o_W_7 : Product
o_W_7 =
    OtherAssetBackedFinancing


{-| O.W.8: Outflows - Wholesale - Commercial Paper
-}
o_W_8 : Product
o_W_8 =
    CommercialPaper


{-| O.W.9: Outflows - Wholesale - Onshore Borrowing
-}
o_W_9 : Product
o_W_9 =
    OnshoreBorrowing


{-| O.W.10: Outflows - Wholesale - Offshore Borrowing
-}
o_W_10 : Product
o_W_10 =
    OffshoreBorrowing


{-| O.W.11: Outflows - Wholesale - Unstructured Long Term Debt
-}
o_W_11 : Product
o_W_11 =
    UnstructuredLongTermDebt


{-| O.W.12: Outflows - Wholesale - Structured Long Term Debt
-}
o_W_12 : Product
o_W_12 =
    StructuredLongTermDebt


{-| O.W.13: Outflows - Wholesale - Government Supported Debt
-}
o_W_13 : Product
o_W_13 =
    GovernmentSupportedDebt


{-| O.W.14: Outflows - Wholesale - Unsecured Notes
-}
o_W_14 : Product
o_W_14 =
    UnsecuredNotes


{-| O.W.15: Outflows - Wholesale - Structured Notes
-}
o_W_15 : Product
o_W_15 =
    StructuredNotes


{-| O.W.16: Outflows - Wholesale - Wholesale CDs
-}
o_W_16 : Product
o_W_16 =
    WholesaleCDs


{-| O.W.17: Outflows - Wholesale - Draws on Committed Lines
-}
o_W_17 : Product
o_W_17 =
    DrawsOnCommittedLines


{-| O.W.18: Outflows - Wholesale - Free Credits
-}
o_W_18 : Product
o_W_18 =
    FreeCredits


{-| O.W.19: Outflows - Wholesale - Other Unsecured Financing
-}
o_W_19 : Product
o_W_19 =
    OtherUnsecuredFinancing