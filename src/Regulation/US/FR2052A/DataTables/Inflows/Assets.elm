module Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (..)


import Regulation.US.FR2052A.Fields.AccountingDesignation exposing (AccountingDesignation)
import Regulation.US.FR2052A.Fields.BusinessLine exposing (BusinessLine)
import Regulation.US.FR2052A.Fields.CollateralClass exposing (CollateralClass)
import Regulation.US.FR2052A.Fields.Converted exposing (Converted)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency)
import Regulation.US.FR2052A.Fields.EffectiveMaturityBucket exposing (EffectiveMaturityBucket)
import Regulation.US.FR2052A.Fields.EncumbranceType exposing (EncumbranceType)
import Regulation.US.FR2052A.Fields.ForwardStartAmount exposing (ForwardStartAmount)
import Regulation.US.FR2052A.Fields.ForwardStartBucket exposing (ForwardStartBucket)
import Regulation.US.FR2052A.Fields.InternalCounterparty exposing (InternalCounterparty)
import Regulation.US.FR2052A.Fields.LendableValue exposing (LendableValue)
import Regulation.US.FR2052A.Fields.MarketValue exposing (MarketValue)
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket)
import Regulation.US.FR2052A.Fields.ReportingEntity exposing (ReportingEntity)
import Regulation.US.FR2052A.Fields.SubProduct exposing (SubProduct)
import Regulation.US.FR2052A.Fields.TreasuryControl exposing (TreasuryControl)


{-| Represents a record in the Inflows - Assets data table.
-}
type alias Assets =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , product : Product
    , subProduct : Maybe SubProduct
    , marketValue : MarketValue
    , lendableValue : LendableValue
    , maturityBucket : MaturityBucket
    , forwardStartAmount : Maybe ForwardStartAmount
    , forwardStartBucket : Maybe ForwardStartBucket
    , collateralClass : CollateralClass
    , treasuryControl : TreasuryControl
    , accountingDesignation : AccountingDesignation
    , effectiveMaturityBucket : Maybe EffectiveMaturityBucket
    , encumbranceType : Maybe EncumbranceType
    , internalCounterparty : Maybe InternalCounterparty
    , businessLine : BusinessLine
    }


{-| Represents all Inflows - Assets products:

  - I.A.1: Unencumbered Assets (as `UnencumberedAssets`)
  - I.A.2: Capacity (as `Capacity`)
  - I.A.3: Unrestricted Reserve Balances (as `UnrestrictedReserveBalances`)
  - I.A.4: Restricted Reserve Balances (as `RestrictedReserveBalances`)
  - I.A.5: Unsettled Asset Purchases (as `UnsettledAssetPurchases`)
  - I.A.6: Forward Asset Purchases (as `ForwardAssetPurchases`)
  - I.A.7: Encumbered Assets (as `EncumberedAssets`)

-}
type Product
    = UnencumberedAssets
    | Capacity
    | UnrestrictedReserveBalances
    | RestrictedReserveBalances
    | UnsettledAssetPurchases
    | ForwardAssetPurchases
    | EncumberedAssets


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just UnencumberedAssets

        2 ->
            Just Capacity

        3 ->
            Just UnrestrictedReserveBalances

        4 ->
            Just RestrictedReserveBalances

        5 ->
            Just UnsettledAssetPurchases

        6 ->
            Just ForwardAssetPurchases

        7 ->
            Just EncumberedAssets

        _ ->
            Nothing


{-| I.A.1: Inflows - Assets - Unencumbered Assets
-}
i_A_1 : Product
i_A_1 =
    UnencumberedAssets


{-| I.A.2: Inflows - Assets - Capacity
-}
i_A_2 : Product
i_A_2 =
    Capacity


{-| I.A.3: Inflows - Assets - Unrestricted Reserve Balances
-}
i_A_3 : Product
i_A_3 =
    UnrestrictedReserveBalances


{-| I.A.4: Inflows - Assets - Restricted Reserve Balances
-}
i_A_4 : Product
i_A_4 =
    RestrictedReserveBalances


{-| I.A.5: Inflows - Assets - Unsettled Asset Purchases
-}
i_A_5 : Product
i_A_5 =
    UnsettledAssetPurchases


{-| I.A.6: Inflows - Assets - Forward Asset Purchases
-}
i_A_6 : Product
i_A_6 =
    ForwardAssetPurchases


{-| I.A.7: Inflows - Assets - Encumbered Assets
-}
i_A_7 : Product
i_A_7 =
    EncumberedAssets