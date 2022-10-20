module Regulation.US.FR2052A.DataTables.Supplemental.ForeignExchange exposing (..)


import Regulation.US.FR2052A.Fields.BusinessLine exposing (BusinessLine)
import Regulation.US.FR2052A.Fields.Converted exposing (Converted)
import Regulation.US.FR2052A.Fields.Counterparty exposing (Counterparty)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency)
import Regulation.US.FR2052A.Fields.ForeignExchangeOptionDirection exposing (ForeignExchangeOptionDirection)
import Regulation.US.FR2052A.Fields.ForwardStartAmountCurrency1 exposing (ForwardStartAmountCurrency1)
import Regulation.US.FR2052A.Fields.ForwardStartAmountCurrency2 exposing (ForwardStartAmountCurrency2)
import Regulation.US.FR2052A.Fields.ForwardStartBucket exposing (ForwardStartBucket)
import Regulation.US.FR2052A.Fields.GSIB exposing (GSIB)
import Regulation.US.FR2052A.Fields.Internal exposing (Internal)
import Regulation.US.FR2052A.Fields.InternalCounterparty exposing (InternalCounterparty)
import Regulation.US.FR2052A.Fields.MaturityAmountCurrency1 exposing (MaturityAmountCurrency1)
import Regulation.US.FR2052A.Fields.MaturityAmountCurrency2 exposing (MaturityAmountCurrency2)
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket)
import Regulation.US.FR2052A.Fields.ReportingEntity exposing (ReportingEntity)
import Regulation.US.FR2052A.Fields.Settlement exposing (Settlement)


{-| Represents a record in the Supplemental - Foreign Exchange data table.
-}
type alias ForeignExchange =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , product : Product
    , maturityAmountCurrency1 : MaturityAmountCurrency1
    , maturityAmountCurrency2 : MaturityAmountCurrency2
    , maturityBucket : MaturityBucket
    , foreignExchangeOptionDirection : Maybe ForeignExchangeOptionDirection
    , forwardStartAmountCurrency1 : Maybe ForwardStartAmountCurrency1
    , forwardStartAmountCurrency2 : Maybe ForwardStartAmountCurrency2
    , forwardStartBucket : Maybe ForwardStartBucket
    , counterparty : Counterparty
    , gSIB : Maybe GSIB
    , settlement : Settlement
    , businessLine : BusinessLine
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    }


{-| Represents all Supplemental - Foreign Exchange products:

  - S.FX.1: Spot (as `Spot`)
  - S.FX.2: Forwards and Futures (as `ForwardsAndFutures`)
  - S.FX.3: Swaps (as `Swaps`)

-}
type Product
    = Spot
    | ForwardsAndFutures
    | Swaps


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just Spot

        2 ->
            Just ForwardsAndFutures

        3 ->
            Just Swaps

        _ ->
            Nothing


{-| S.FX.1: Supplemental - Foreign Exchange - Spot
-}
s_FX_1 : Product
s_FX_1 =
    Spot


{-| S.FX.2: Supplemental - Foreign Exchange - Forwards and Futures
-}
s_FX_2 : Product
s_FX_2 =
    ForwardsAndFutures


{-| S.FX.3: Supplemental - Foreign Exchange - Swaps
-}
s_FX_3 : Product
s_FX_3 =
    Swaps