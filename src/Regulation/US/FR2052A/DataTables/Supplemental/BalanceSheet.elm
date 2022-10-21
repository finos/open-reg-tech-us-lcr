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

module Regulation.US.FR2052A.DataTables.Supplemental.BalanceSheet exposing (..)


import Regulation.US.FR2052A.Fields.CollateralClass exposing (CollateralClass)
import Regulation.US.FR2052A.Fields.CollateralValue exposing (CollateralValue)
import Regulation.US.FR2052A.Fields.CollectionReference exposing (CollectionReference)
import Regulation.US.FR2052A.Fields.Converted exposing (Converted)
import Regulation.US.FR2052A.Fields.Counterparty exposing (Counterparty)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency)
import Regulation.US.FR2052A.Fields.EffectiveMaturityBucket exposing (EffectiveMaturityBucket)
import Regulation.US.FR2052A.Fields.EncumbranceType exposing (EncumbranceType)
import Regulation.US.FR2052A.Fields.GSIB exposing (GSIB)
import Regulation.US.FR2052A.Fields.Internal exposing (Internal)
import Regulation.US.FR2052A.Fields.InternalCounterparty exposing (InternalCounterparty)
import Regulation.US.FR2052A.Fields.MarketValue exposing (MarketValue)
import Regulation.US.FR2052A.Fields.MaturityAmount exposing (MaturityAmount)
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket)
import Regulation.US.FR2052A.Fields.ProductReference exposing (ProductReference)
import Regulation.US.FR2052A.Fields.ReportingEntity exposing (ReportingEntity)
import Regulation.US.FR2052A.Fields.RiskWeight exposing (RiskWeight)
import Regulation.US.FR2052A.Fields.SubProductReference exposing (SubProductReference)


{-| Represents a record in the Supplemental - Balance Sheet data table.
-}
type alias BalanceSheet =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , collectionReference : Maybe CollectionReference
    , product : Product
    , productReference : Maybe ProductReference
    , subProductReference : Maybe SubProductReference
    , collateralClass : Maybe CollateralClass
    , maturityBucket : MaturityBucket
    , effectiveMaturityBucket : Maybe EffectiveMaturityBucket
    , encumbranceType : Maybe EncumbranceType
    , marketValue : Maybe MarketValue
    , maturityAmount : Maybe MaturityAmount
    , collateralValue : Maybe CollateralValue
    , counterparty : Maybe Counterparty
    , gSIB : Maybe GSIB
    , riskWeight : Maybe RiskWeight
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    }


{-| Represents all Supplemental - Balance Sheet products:

  - S.B.1: Regulatory Capital Element (as `RegulatoryCapitalElement`)
  - S.B.2: Other Liabilities (as `OtherLiabilities`)
  - S.B.3: Non-Performing Assets (as `NonPerformingAssets`)
  - S.B.4: Other Assets (as `OtherAssets`)
  - S.B.5: Counterparty Netting (as `CounterpartyNetting`)
  - S.B.6: Carrying Value Adjustment (as `CarryingValueAdjustment`)

-}
type Product
    = RegulatoryCapitalElement
    | OtherLiabilities
    | NonPerformingAssets
    | OtherAssets
    | CounterpartyNetting
    | CarryingValueAdjustment


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just RegulatoryCapitalElement

        2 ->
            Just OtherLiabilities

        3 ->
            Just NonPerformingAssets

        4 ->
            Just OtherAssets

        5 ->
            Just CounterpartyNetting

        6 ->
            Just CarryingValueAdjustment

        _ ->
            Nothing


{-| S.B.1: Supplemental - Balance Sheet - Regulatory Capital Element
-}
s_B_1 : Product
s_B_1 =
    RegulatoryCapitalElement


{-| S.B.2: Supplemental - Balance Sheet - Other Liabilities
-}
s_B_2 : Product
s_B_2 =
    OtherLiabilities


{-| S.B.3: Supplemental - Balance Sheet - Non-Performing Assets
-}
s_B_3 : Product
s_B_3 =
    NonPerformingAssets


{-| S.B.4: Supplemental - Balance Sheet - Other Assets
-}
s_B_4 : Product
s_B_4 =
    OtherAssets


{-| S.B.5: Supplemental - Balance Sheet - Counterparty Netting
-}
s_B_5 : Product
s_B_5 =
    CounterpartyNetting


{-| S.B.6: Supplemental - Balance Sheet - Carrying Value Adjustment
-}
s_B_6 : Product
s_B_6 =
    CarryingValueAdjustment