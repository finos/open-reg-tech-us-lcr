module Regulation.US.FR2052A.DataTables.Outflows.Deposits exposing (..)


import Regulation.US.FR2052A.Fields.BusinessLine exposing (BusinessLine)
import Regulation.US.FR2052A.Fields.CollateralClass exposing (CollateralClass)
import Regulation.US.FR2052A.Fields.CollateralValue exposing (CollateralValue)
import Regulation.US.FR2052A.Fields.Converted exposing (Converted)
import Regulation.US.FR2052A.Fields.Counterparty exposing (Counterparty)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency)
import Regulation.US.FR2052A.Fields.GSIB exposing (GSIB)
import Regulation.US.FR2052A.Fields.Insured exposing (Insured)
import Regulation.US.FR2052A.Fields.Internal exposing (Internal)
import Regulation.US.FR2052A.Fields.InternalCounterparty exposing (InternalCounterparty)
import Regulation.US.FR2052A.Fields.MaturityAmount exposing (MaturityAmount)
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket)
import Regulation.US.FR2052A.Fields.MaturityOptionality exposing (MaturityOptionality)
import Regulation.US.FR2052A.Fields.Rehypothecated exposing (Rehypothecated)
import Regulation.US.FR2052A.Fields.ReportingEntity exposing (ReportingEntity)
import Regulation.US.FR2052A.Fields.Trigger exposing (Trigger)


{-| Represents a record in the Outflows - Deposits data table.
-}
type alias Deposits =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , product : Product
    , counterparty : Counterparty
    , gSIB : Maybe GSIB
    , maturityAmount : MaturityAmount
    , maturityBucket : MaturityBucket
    , maturityOptionality : Maybe MaturityOptionality
    , collateralClass : Maybe CollateralClass
    , collateralValue : Maybe CollateralValue
    , insured : Insured
    , trigger : Trigger
    , rehypothecated : Maybe Rehypothecated
    , businessLine : BusinessLine
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    }


{-| Represents all Outflows - Deposits products:

  - O.D.1: Transactional Accounts (as `TransactionalAccounts`)
  - O.D.2: Non-Transactional Relationship Accounts (as `NonTransactionalRelationshipAccounts`)
  - O.D.3: Non-Transactional Non-Relationship Accounts (as `NonTransactionalNonRelationshipAccounts`)
  - O.D.4: Operational Account Balances (as `OperationalAccountBalances`)
  - O.D.5: Excess Balances in Operational Accounts (as `ExcessBalancesInOperationalAccounts`)
  - O.D.6: Non-Operational Account Balances (as `NonOperationalAccountBalances`)
  - O.D.7: Operational Escrow Accounts (as `OperationalEscrowAccounts`)
  - O.D.8: Non-Reciprocal Brokered Accounts (as `NonReciprocalBrokeredAccounts`)
  - O.D.9: Stable Affiliated Sweep Account Balances (as `StableAffiliatedSweepAccountBalances`)
  - O.D.10: Less Stable Affiliated Sweep Account Balances (as `LessStableAffiliatedSweepAccountBalances`)
  - O.D.11: Non-Affiliated Sweep Accounts (as `NonAffiliatedSweepAccounts`)
  - O.D.12: Other Product Sweep Accounts (as `OtherProductSweepAccounts`)
  - O.D.13: Reciprocal Accounts (as `ReciprocalAccounts`)
  - O.D.14: Other Third-Party Deposits (as `OtherThirdPartyDeposits`)
  - O.D.15: Other Accounts (as `OtherAccounts`)

-}
type Product
    = TransactionalAccounts
    | NonTransactionalRelationshipAccounts
    | NonTransactionalNonRelationshipAccounts
    | OperationalAccountBalances
    | ExcessBalancesInOperationalAccounts
    | NonOperationalAccountBalances
    | OperationalEscrowAccounts
    | NonReciprocalBrokeredAccounts
    | StableAffiliatedSweepAccountBalances
    | LessStableAffiliatedSweepAccountBalances
    | NonAffiliatedSweepAccounts
    | OtherProductSweepAccounts
    | ReciprocalAccounts
    | OtherThirdPartyDeposits
    | OtherAccounts


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just TransactionalAccounts

        2 ->
            Just NonTransactionalRelationshipAccounts

        3 ->
            Just NonTransactionalNonRelationshipAccounts

        4 ->
            Just OperationalAccountBalances

        5 ->
            Just ExcessBalancesInOperationalAccounts

        6 ->
            Just NonOperationalAccountBalances

        7 ->
            Just OperationalEscrowAccounts

        8 ->
            Just NonReciprocalBrokeredAccounts

        9 ->
            Just StableAffiliatedSweepAccountBalances

        10 ->
            Just LessStableAffiliatedSweepAccountBalances

        11 ->
            Just NonAffiliatedSweepAccounts

        12 ->
            Just OtherProductSweepAccounts

        13 ->
            Just ReciprocalAccounts

        14 ->
            Just OtherThirdPartyDeposits

        15 ->
            Just OtherAccounts

        _ ->
            Nothing


{-| O.D.1: Outflows - Deposits - Transactional Accounts
-}
o_D_1 : Product
o_D_1 =
    TransactionalAccounts


{-| O.D.2: Outflows - Deposits - Non-Transactional Relationship Accounts
-}
o_D_2 : Product
o_D_2 =
    NonTransactionalRelationshipAccounts


{-| O.D.3: Outflows - Deposits - Non-Transactional Non-Relationship Accounts
-}
o_D_3 : Product
o_D_3 =
    NonTransactionalNonRelationshipAccounts


{-| O.D.4: Outflows - Deposits - Operational Account Balances
-}
o_D_4 : Product
o_D_4 =
    OperationalAccountBalances


{-| O.D.5: Outflows - Deposits - Excess Balances in Operational Accounts
-}
o_D_5 : Product
o_D_5 =
    ExcessBalancesInOperationalAccounts


{-| O.D.6: Outflows - Deposits - Non-Operational Account Balances
-}
o_D_6 : Product
o_D_6 =
    NonOperationalAccountBalances


{-| O.D.7: Outflows - Deposits - Operational Escrow Accounts
-}
o_D_7 : Product
o_D_7 =
    OperationalEscrowAccounts


{-| O.D.8: Outflows - Deposits - Non-Reciprocal Brokered Accounts
-}
o_D_8 : Product
o_D_8 =
    NonReciprocalBrokeredAccounts


{-| O.D.9: Outflows - Deposits - Stable Affiliated Sweep Account Balances
-}
o_D_9 : Product
o_D_9 =
    StableAffiliatedSweepAccountBalances


{-| O.D.10: Outflows - Deposits - Less Stable Affiliated Sweep Account Balances
-}
o_D_10 : Product
o_D_10 =
    LessStableAffiliatedSweepAccountBalances


{-| O.D.11: Outflows - Deposits - Non-Affiliated Sweep Accounts
-}
o_D_11 : Product
o_D_11 =
    NonAffiliatedSweepAccounts


{-| O.D.12: Outflows - Deposits - Other Product Sweep Accounts
-}
o_D_12 : Product
o_D_12 =
    OtherProductSweepAccounts


{-| O.D.13: Outflows - Deposits - Reciprocal Accounts
-}
o_D_13 : Product
o_D_13 =
    ReciprocalAccounts


{-| O.D.14: Outflows - Deposits - Other Third-Party Deposits
-}
o_D_14 : Product
o_D_14 =
    OtherThirdPartyDeposits


{-| O.D.15: Outflows - Deposits - Other Accounts
-}
o_D_15 : Product
o_D_15 =
    OtherAccounts