module Regulation.US.FR2052A.DataTables.Inflows.Secured exposing (..)


import Regulation.US.FR2052A.Fields.BusinessLine exposing (BusinessLine)
import Regulation.US.FR2052A.Fields.CollateralClass exposing (CollateralClass)
import Regulation.US.FR2052A.Fields.CollateralValue exposing (CollateralValue)
import Regulation.US.FR2052A.Fields.Converted exposing (Converted)
import Regulation.US.FR2052A.Fields.Counterparty exposing (Counterparty)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency)
import Regulation.US.FR2052A.Fields.EffectiveMaturityBucket exposing (EffectiveMaturityBucket)
import Regulation.US.FR2052A.Fields.EncumbranceType exposing (EncumbranceType)
import Regulation.US.FR2052A.Fields.ForwardStartAmount exposing (ForwardStartAmount)
import Regulation.US.FR2052A.Fields.ForwardStartBucket exposing (ForwardStartBucket)
import Regulation.US.FR2052A.Fields.GSIB exposing (GSIB)
import Regulation.US.FR2052A.Fields.Internal exposing (Internal)
import Regulation.US.FR2052A.Fields.InternalCounterparty exposing (InternalCounterparty)
import Regulation.US.FR2052A.Fields.MaturityAmount exposing (MaturityAmount)
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket)
import Regulation.US.FR2052A.Fields.MaturityOptionality exposing (MaturityOptionality)
import Regulation.US.FR2052A.Fields.ReportingEntity exposing (ReportingEntity)
import Regulation.US.FR2052A.Fields.RiskWeight exposing (RiskWeight)
import Regulation.US.FR2052A.Fields.Settlement exposing (Settlement)
import Regulation.US.FR2052A.Fields.SubProduct exposing (SubProduct)
import Regulation.US.FR2052A.Fields.TreasuryControl exposing (TreasuryControl)
import Regulation.US.FR2052A.Fields.Unencumbered exposing (Unencumbered)


{-| Represents a record in the Inflows - Secured data table.
-}
type alias Secured =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , product : Product
    , subProduct : Maybe SubProduct
    , maturityAmount : MaturityAmount
    , maturityBucket : MaturityBucket
    , maturityOptionality : Maybe MaturityOptionality
    , effectiveMaturityBucket : Maybe EffectiveMaturityBucket
    , encumbranceType : Maybe EncumbranceType
    , forwardStartAmount : Maybe ForwardStartAmount
    , forwardStartBucket : Maybe ForwardStartBucket
    , collateralClass : CollateralClass
    , collateralValue : CollateralValue
    , unencumbered : Unencumbered
    , treasuryControl : TreasuryControl
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    , riskWeight : Maybe RiskWeight
    , businessLine : BusinessLine
    , settlement : Settlement
    , counterparty : Counterparty
    , gSIB : Maybe GSIB
    }


{-| Represents all Inflows - Secured products:

  - I.S.1: Reverse Repo (as `ReverseRepo`)
  - I.S.2: Securities Borrowing (as `SecuritiesBorrowing`)
  - I.S.3: Dollar Rolls (as `DollarRolls`)
  - I.S.4: Collateral Swaps (as `CollateralSwaps`)
  - I.S.5: Margin Loans (as `MarginLoans`)
  - I.S.6: Other Secured Loans - Rehypothecatable (as `OtherSecuredLoansRehypothecatable`)
  - I.S.7: Outstanding Draws on Secured Revolving Facilities (as `OutstandingDrawsOnSecuredRevolvingFacilities`)
  - I.S.8: Other Secured Loans - Non-Rehypothecatable (as `OtherSecuredLoansNonRehypothecatable`)
  - I.S.9: Synthetic Customer Longs (as `SyntheticCustomerLongs`)
  - I.S.10: Synthetic Firm Sourcing (as `SyntheticFirmSourcing`)

-}
type Product
    = ReverseRepo
    | SecuritiesBorrowing
    | DollarRolls
    | CollateralSwaps
    | MarginLoans
    | OtherSecuredLoansRehypothecatable
    | OutstandingDrawsOnSecuredRevolvingFacilities
    | OtherSecuredLoansNonRehypothecatable
    | SyntheticCustomerLongs
    | SyntheticFirmSourcing


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just ReverseRepo

        2 ->
            Just SecuritiesBorrowing

        3 ->
            Just DollarRolls

        4 ->
            Just CollateralSwaps

        5 ->
            Just MarginLoans

        6 ->
            Just OtherSecuredLoansRehypothecatable

        7 ->
            Just OutstandingDrawsOnSecuredRevolvingFacilities

        8 ->
            Just OtherSecuredLoansNonRehypothecatable

        9 ->
            Just SyntheticCustomerLongs

        10 ->
            Just SyntheticFirmSourcing

        _ ->
            Nothing


{-| I.S.1: Inflows - Secured - Reverse Repo
-}
i_S_1 : Product
i_S_1 =
    ReverseRepo


{-| I.S.2: Inflows - Secured - Securities Borrowing
-}
i_S_2 : Product
i_S_2 =
    SecuritiesBorrowing


{-| I.S.3: Inflows - Secured - Dollar Rolls
-}
i_S_3 : Product
i_S_3 =
    DollarRolls


{-| I.S.4: Inflows - Secured - Collateral Swaps
-}
i_S_4 : Product
i_S_4 =
    CollateralSwaps


{-| I.S.5: Inflows - Secured - Margin Loans
-}
i_S_5 : Product
i_S_5 =
    MarginLoans


{-| I.S.6: Inflows - Secured - Other Secured Loans - Rehypothecatable
-}
i_S_6 : Product
i_S_6 =
    OtherSecuredLoansRehypothecatable


{-| I.S.7: Inflows - Secured - Outstanding Draws on Secured Revolving Facilities
-}
i_S_7 : Product
i_S_7 =
    OutstandingDrawsOnSecuredRevolvingFacilities


{-| I.S.8: Inflows - Secured - Other Secured Loans - Non-Rehypothecatable
-}
i_S_8 : Product
i_S_8 =
    OtherSecuredLoansNonRehypothecatable


{-| I.S.9: Inflows - Secured - Synthetic Customer Longs
-}
i_S_9 : Product
i_S_9 =
    SyntheticCustomerLongs


{-| I.S.10: Inflows - Secured - Synthetic Firm Sourcing
-}
i_S_10 : Product
i_S_10 =
    SyntheticFirmSourcing