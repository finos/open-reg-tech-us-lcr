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

module Regulation.US.FR2052A.DataTables.Inflows.Other exposing (..)


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
import Regulation.US.FR2052A.Fields.ReportingEntity exposing (ReportingEntity)
import Regulation.US.FR2052A.Fields.TreasuryControl exposing (TreasuryControl)


{-| Represents a record in the Inflows - Other data table.
-}
type alias Other =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , product : Product
    , maturityAmount : MaturityAmount
    , maturityBucket : MaturityBucket
    , forwardStartAmount : Maybe ForwardStartAmount
    , forwardStartBucket : Maybe ForwardStartBucket
    , collateralClass : Maybe CollateralClass
    , collateralValue : Maybe CollateralValue
    , treasuryControl : TreasuryControl
    , counterparty : Maybe Counterparty
    , gSIB : Maybe GSIB
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    , businessLine : BusinessLine
    }


{-| Represents all Inflows - Other products:

  - I.O.1: Derivative Receivables (as `DerivativeReceivables`)
  - I.O.2: Collateral Called for Receipt (as `CollateralCalledForReceipt`)
  - I.O.3: TBA Sales (as `TBASales`)
  - I.O.4: Undrawn Committed Facilities Purchased (as `UndrawnCommittedFacilitiesPurchased`)
  - I.O.5: Lock-up Balance (as `LockUpBalance`)
  - I.O.6: Interest and Dividends Receivable (as `InterestAndDividendsReceivable`)
  - I.O.7: Net 30-Day Derivative Receivables (as `Net30DayDerivativeReceivables`)
  - I.O.8: Principal Payments Receivable on Unencumbered Investment Securities (as `PrincipalPaymentsReceivableOnUnencumberedInvestmentSecurities`)
  - I.O.9: Other Cash Inflows (as `OtherCashInflows`)

-}
type Product
    = DerivativeReceivables
    | CollateralCalledForReceipt
    | TBASales
    | UndrawnCommittedFacilitiesPurchased
    | LockUpBalance
    | InterestAndDividendsReceivable
    | Net30DayDerivativeReceivables
    | PrincipalPaymentsReceivableOnUnencumberedInvestmentSecurities
    | OtherCashInflows


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just DerivativeReceivables

        2 ->
            Just CollateralCalledForReceipt

        3 ->
            Just TBASales

        4 ->
            Just UndrawnCommittedFacilitiesPurchased

        5 ->
            Just LockUpBalance

        6 ->
            Just InterestAndDividendsReceivable

        7 ->
            Just Net30DayDerivativeReceivables

        8 ->
            Just PrincipalPaymentsReceivableOnUnencumberedInvestmentSecurities

        9 ->
            Just OtherCashInflows

        _ ->
            Nothing


{-| I.O.1: Inflows - Other - Derivative Receivables
-}
i_O_1 : Product
i_O_1 =
    DerivativeReceivables


{-| I.O.2: Inflows - Other - Collateral Called for Receipt
-}
i_O_2 : Product
i_O_2 =
    CollateralCalledForReceipt


{-| I.O.3: Inflows - Other - TBA Sales
-}
i_O_3 : Product
i_O_3 =
    TBASales


{-| I.O.4: Inflows - Other - Undrawn Committed Facilities Purchased
-}
i_O_4 : Product
i_O_4 =
    UndrawnCommittedFacilitiesPurchased


{-| I.O.5: Inflows - Other - Lock-up Balance
-}
i_O_5 : Product
i_O_5 =
    LockUpBalance


{-| I.O.6: Inflows - Other - Interest and Dividends Receivable
-}
i_O_6 : Product
i_O_6 =
    InterestAndDividendsReceivable


{-| I.O.7: Inflows - Other - Net 30-Day Derivative Receivables
-}
i_O_7 : Product
i_O_7 =
    Net30DayDerivativeReceivables


{-| I.O.8: Inflows - Other - Principal Payments Receivable on Unencumbered Investment Securities
-}
i_O_8 : Product
i_O_8 =
    PrincipalPaymentsReceivableOnUnencumberedInvestmentSecurities


{-| I.O.9: Inflows - Other - Other Cash Inflows
-}
i_O_9 : Product
i_O_9 =
    OtherCashInflows