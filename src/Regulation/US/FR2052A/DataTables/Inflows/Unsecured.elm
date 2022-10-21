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

module Regulation.US.FR2052A.DataTables.Inflows.Unsecured exposing (..)


import Regulation.US.FR2052A.Fields.BusinessLine exposing (BusinessLine)
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


{-| Represents a record in the Inflows - Unsecured data table.
-}
type alias Unsecured =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , product : Product
    , counterparty : Maybe Counterparty
    , gSIB : Maybe GSIB
    , maturityAmount : MaturityAmount
    , maturityBucket : MaturityBucket
    , maturityOptionality : Maybe MaturityOptionality
    , effectiveMaturityBucket : Maybe EffectiveMaturityBucket
    , encumbranceType : Maybe EncumbranceType
    , forwardStartAmount : Maybe ForwardStartAmount
    , forwardStartBucket : Maybe ForwardStartBucket
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    , riskWeight : Maybe RiskWeight
    , businessLine : BusinessLine
    }


{-| Represents all Inflows - Unsecured products:

  - I.U.1: Onshore Placements (as `OnshorePlacements`)
  - I.U.2: Offshore Placements (as `OffshorePlacements`)
  - I.U.3: Required Operational Balances (as `RequiredOperationalBalances`)
  - I.U.4: Excess Operational Balances (as `ExcessOperationalBalances`)
  - I.U.5: Outstanding Draws on Unsecured Revolving Facilities (as `OutstandingDrawsOnUnsecuredRevolvingFacilities`)
  - I.U.6: Other Loans (as `OtherLoans`)
  - I.U.7: Cash Items in the Process of Collection (as `CashItemsInTheProcessOfCollection`)
  - I.U.8: Short-Term Investments (as `ShortTermInvestments`)

-}
type Product
    = OnshorePlacements
    | OffshorePlacements
    | RequiredOperationalBalances
    | ExcessOperationalBalances
    | OutstandingDrawsOnUnsecuredRevolvingFacilities
    | OtherLoans
    | CashItemsInTheProcessOfCollection
    | ShortTermInvestments


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just OnshorePlacements

        2 ->
            Just OffshorePlacements

        3 ->
            Just RequiredOperationalBalances

        4 ->
            Just ExcessOperationalBalances

        5 ->
            Just OutstandingDrawsOnUnsecuredRevolvingFacilities

        6 ->
            Just OtherLoans

        7 ->
            Just CashItemsInTheProcessOfCollection

        8 ->
            Just ShortTermInvestments

        _ ->
            Nothing


{-| I.U.1: Inflows - Unsecured - Onshore Placements
-}
i_U_1 : Product
i_U_1 =
    OnshorePlacements


{-| I.U.2: Inflows - Unsecured - Offshore Placements
-}
i_U_2 : Product
i_U_2 =
    OffshorePlacements


{-| I.U.3: Inflows - Unsecured - Required Operational Balances
-}
i_U_3 : Product
i_U_3 =
    RequiredOperationalBalances


{-| I.U.4: Inflows - Unsecured - Excess Operational Balances
-}
i_U_4 : Product
i_U_4 =
    ExcessOperationalBalances


{-| I.U.5: Inflows - Unsecured - Outstanding Draws on Unsecured Revolving Facilities
-}
i_U_5 : Product
i_U_5 =
    OutstandingDrawsOnUnsecuredRevolvingFacilities


{-| I.U.6: Inflows - Unsecured - Other Loans
-}
i_U_6 : Product
i_U_6 =
    OtherLoans


{-| I.U.7: Inflows - Unsecured - Cash Items in the Process of Collection
-}
i_U_7 : Product
i_U_7 =
    CashItemsInTheProcessOfCollection


{-| I.U.8: Inflows - Unsecured - Short-Term Investments
-}
i_U_8 : Product
i_U_8 =
    ShortTermInvestments