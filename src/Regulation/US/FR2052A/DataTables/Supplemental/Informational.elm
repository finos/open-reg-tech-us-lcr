module Regulation.US.FR2052A.DataTables.Supplemental.Informational exposing (..)


import Regulation.US.FR2052A.Fields.BusinessLine exposing (BusinessLine)
import Regulation.US.FR2052A.Fields.CollateralClass exposing (CollateralClass)
import Regulation.US.FR2052A.Fields.Converted exposing (Converted)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency)
import Regulation.US.FR2052A.Fields.Internal exposing (Internal)
import Regulation.US.FR2052A.Fields.InternalCounterparty exposing (InternalCounterparty)
import Regulation.US.FR2052A.Fields.MarketValue exposing (MarketValue)
import Regulation.US.FR2052A.Fields.ReportingEntity exposing (ReportingEntity)


{-| Represents a record in the Supplemental - Informational data table.
-}
type alias Informational =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , product : Product
    , marketValue : MarketValue
    , collateralClass : Maybe CollateralClass
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    , businessLine : BusinessLine
    }


{-| Represents all Supplemental - Informational products:

  - S.I.1: Long Market Value Client Assets (as `LongMarketValueClientAssets`)
  - S.I.2: Short Market Value Client Assets (as `ShortMarketValueClientAssets`)
  - S.I.3: Gross Client Wires Received (as `GrossClientWiresReceived`)
  - S.I.4: Gross Client Wires Paid (as `GrossClientWiresPaid`)
  - S.I.5: FRB 23A Capacity (as `FRB23ACapacity`)
  - S.I.6: Subsidiary Liquidity Not Transferrable (as `SubsidiaryLiquidityNotTransferrable`)

-}
type Product
    = LongMarketValueClientAssets
    | ShortMarketValueClientAssets
    | GrossClientWiresReceived
    | GrossClientWiresPaid
    | FRB23ACapacity
    | SubsidiaryLiquidityNotTransferrable


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just LongMarketValueClientAssets

        2 ->
            Just ShortMarketValueClientAssets

        3 ->
            Just GrossClientWiresReceived

        4 ->
            Just GrossClientWiresPaid

        5 ->
            Just FRB23ACapacity

        6 ->
            Just SubsidiaryLiquidityNotTransferrable

        _ ->
            Nothing


{-| S.I.1: Supplemental - Informational - Long Market Value Client Assets
-}
s_I_1 : Product
s_I_1 =
    LongMarketValueClientAssets


{-| S.I.2: Supplemental - Informational - Short Market Value Client Assets
-}
s_I_2 : Product
s_I_2 =
    ShortMarketValueClientAssets


{-| S.I.3: Supplemental - Informational - Gross Client Wires Received
-}
s_I_3 : Product
s_I_3 =
    GrossClientWiresReceived


{-| S.I.4: Supplemental - Informational - Gross Client Wires Paid
-}
s_I_4 : Product
s_I_4 =
    GrossClientWiresPaid


{-| S.I.5: Supplemental - Informational - FRB 23A Capacity
-}
s_I_5 : Product
s_I_5 =
    FRB23ACapacity


{-| S.I.6: Supplemental - Informational - Subsidiary Liquidity Not Transferrable
-}
s_I_6 : Product
s_I_6 =
    SubsidiaryLiquidityNotTransferrable