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

module Regulation.US.FR2052A.DataTables.Outflows.Secured exposing (..)


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
import Regulation.US.FR2052A.Fields.MaturityAmount exposing (MaturityAmount)
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket)
import Regulation.US.FR2052A.Fields.MaturityOptionality exposing (MaturityOptionality)
import Regulation.US.FR2052A.Fields.Rehypothecated exposing (Rehypothecated)
import Regulation.US.FR2052A.Fields.ReportingEntity exposing (ReportingEntity)
import Regulation.US.FR2052A.Fields.Settlement exposing (Settlement)
import Regulation.US.FR2052A.Fields.SubProduct exposing (SubProduct)
import Regulation.US.FR2052A.Fields.TreasuryControl exposing (TreasuryControl)


{-| Represents a record in the Outflows - Secured data table.
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
    , forwardStartAmount : Maybe ForwardStartAmount
    , forwardStartBucket : Maybe ForwardStartBucket
    , collateralClass : CollateralClass
    , collateralValue : CollateralValue
    , treasuryControl : TreasuryControl
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    , businessLine : BusinessLine
    , settlement : Settlement
    , rehypothecated : Rehypothecated
    , counterparty : Counterparty
    , gSIB : Maybe GSIB
    }


{-| Represents all Outflows - Secured products:

  - O.S.1: Repo (as `Repo`)
  - O.S.2: Securities Lending (as `SecuritiesLending`)
  - O.S.3: Dollar Rolls (as `DollarRolls`)
  - O.S.4: Collateral Swaps (as `CollateralSwaps`)
  - O.S.5: FHLB Advances (as `FHLBAdvances`)
  - O.S.6: Exceptional Central Bank Operations (as `ExceptionalCentralBankOperations`)
  - O.S.7: Customer Shorts (as `CustomerShorts`)
  - O.S.8: Firm Shorts (as `FirmShorts`)
  - O.S.9: Synthetic Customer Shorts (as `SyntheticCustomerShorts`)
  - O.S.10: Synthetic Firm Financing (as `SyntheticFirmFinancing`)
  - O.S.11: Other Secured Financing Transactions (as `OtherSecuredFinancingTransactions`)

-}
type Product
    = Repo
    | SecuritiesLending
    | DollarRolls
    | CollateralSwaps
    | FHLBAdvances
    | ExceptionalCentralBankOperations
    | CustomerShorts
    | FirmShorts
    | SyntheticCustomerShorts
    | SyntheticFirmFinancing
    | OtherSecuredFinancingTransactions


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just Repo

        2 ->
            Just SecuritiesLending

        3 ->
            Just DollarRolls

        4 ->
            Just CollateralSwaps

        5 ->
            Just FHLBAdvances

        6 ->
            Just ExceptionalCentralBankOperations

        7 ->
            Just CustomerShorts

        8 ->
            Just FirmShorts

        9 ->
            Just SyntheticCustomerShorts

        10 ->
            Just SyntheticFirmFinancing

        11 ->
            Just OtherSecuredFinancingTransactions

        _ ->
            Nothing


{-| O.S.1: Outflows - Secured - Repo
-}
o_S_1 : Product
o_S_1 =
    Repo


{-| O.S.2: Outflows - Secured - Securities Lending
-}
o_S_2 : Product
o_S_2 =
    SecuritiesLending


{-| O.S.3: Outflows - Secured - Dollar Rolls
-}
o_S_3 : Product
o_S_3 =
    DollarRolls


{-| O.S.4: Outflows - Secured - Collateral Swaps
-}
o_S_4 : Product
o_S_4 =
    CollateralSwaps


{-| O.S.5: Outflows - Secured - FHLB Advances
-}
o_S_5 : Product
o_S_5 =
    FHLBAdvances


{-| O.S.6: Outflows - Secured - Exceptional Central Bank Operations
-}
o_S_6 : Product
o_S_6 =
    ExceptionalCentralBankOperations


{-| O.S.7: Outflows - Secured - Customer Shorts
-}
o_S_7 : Product
o_S_7 =
    CustomerShorts


{-| O.S.8: Outflows - Secured - Firm Shorts
-}
o_S_8 : Product
o_S_8 =
    FirmShorts


{-| O.S.9: Outflows - Secured - Synthetic Customer Shorts
-}
o_S_9 : Product
o_S_9 =
    SyntheticCustomerShorts


{-| O.S.10: Outflows - Secured - Synthetic Firm Financing
-}
o_S_10 : Product
o_S_10 =
    SyntheticFirmFinancing


{-| O.S.11: Outflows - Secured - Other Secured Financing Transactions
-}
o_S_11 : Product
o_S_11 =
    OtherSecuredFinancingTransactions