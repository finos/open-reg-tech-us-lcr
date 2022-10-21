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

module Regulation.US.FR2052A.DataTables.Outflows.Other exposing (..)


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


{-| Represents a record in the Outflows - Other data table.
-}
type alias Other =
    { currency : Currency
    , converted : Converted
    , reportingEntity : ReportingEntity
    , product : Product
    , counterparty : Maybe Counterparty
    , gSIB : Maybe GSIB
    , maturityAmount : MaturityAmount
    , maturityBucket : MaturityBucket
    , forwardStartAmount : Maybe ForwardStartAmount
    , forwardStartBucket : Maybe ForwardStartBucket
    , collateralClass : Maybe CollateralClass
    , collateralValue : Maybe CollateralValue
    , internal : Internal
    , internalCounterparty : Maybe InternalCounterparty
    , businessLine : BusinessLine
    }


{-| Represents all Outflows - Other products:

  - O.O.1: Derivative Payables (as `DerivativePayables`)
  - O.O.2: Collateral Called for Delivery (as `CollateralCalledForDelivery`)
  - O.O.3: TBA Purchases (as `TBAPurchases`)
  - O.O.4: Credit Facilities (as `CreditFacilities`)
  - O.O.5: Liquidity Facilities (as `LiquidityFacilities`)
  - O.O.6: Retail Mortgage Commitments (as `RetailMortgageCommitments`)
  - O.O.7: Trade Finance Instruments (as `TradeFinanceInstruments`)
  - O.O.8: MTM Impact on Derivative Positions (as `MTMImpactOnDerivativePositions`)
  - O.O.9: Loss of Rehypothecation Rights Due to a 1 Notch Downgrade (as `LossOfRehypothecationRightsDueToA1NotchDowngrade`)
  - O.O.10: Loss of Rehypothecation Rights Due to a 2 Notch Downgrade (as `LossOfRehypothecationRightsDueToA2NotchDowngrade`)
  - O.O.11: Loss of Rehypothecation Rights Due to a 3 Notch Downgrade (as `LossOfRehypothecationRightsDueToA3NotchDowngrade`)
  - O.O.12: Loss of Rehypothecation Rights Due to a Change in Financial Condition (as `LossOfRehypothecationRightsDueToAChangeInFinancialCondition`)
  - O.O.13: Total Collateral Required Due to a 1 Notch Downgrade (as `TotalCollateralRequiredDueToA1NotchDowngrade`)
  - O.O.14: Total Collateral Required Due to a 2 Notch Downgrade (as `TotalCollateralRequiredDueToA2NotchDowngrade`)
  - O.O.15: Total Collateral Required Due to a 3 Notch Downgrade (as `TotalCollateralRequiredDueToA3NotchDowngrade`)
  - O.O.16: Total Collateral Required Due to a Change in Financial Condition (as `TotalCollateralRequiredDueToAChangeInFinancialCondition`)
  - O.O.17: Excess Margin (as `ExcessMargin`)
  - O.O.18: Unfunded Term Margin (as `UnfundedTermMargin`)
  - O.O.19: Interest & Dividends Payable (as `InterestDividendsPayable`)
  - O.O.20: Net 30-Day Derivative Payables (as `Net30DayDerivativePayables`)
  - O.O.21: Other Outflows Related to Structured Transactions (as `OtherOutflowsRelatedToStructuredTransactions`)
  - O.O.22: Other Cash Outflows (as `OtherCashOutflows`)

-}
type Product
    = DerivativePayables
    | CollateralCalledForDelivery
    | TBAPurchases
    | CreditFacilities
    | LiquidityFacilities
    | RetailMortgageCommitments
    | TradeFinanceInstruments
    | MTMImpactOnDerivativePositions
    | LossOfRehypothecationRightsDueToA1NotchDowngrade
    | LossOfRehypothecationRightsDueToA2NotchDowngrade
    | LossOfRehypothecationRightsDueToA3NotchDowngrade
    | LossOfRehypothecationRightsDueToAChangeInFinancialCondition
    | TotalCollateralRequiredDueToA1NotchDowngrade
    | TotalCollateralRequiredDueToA2NotchDowngrade
    | TotalCollateralRequiredDueToA3NotchDowngrade
    | TotalCollateralRequiredDueToAChangeInFinancialCondition
    | ExcessMargin
    | UnfundedTermMargin
    | InterestDividendsPayable
    | Net30DayDerivativePayables
    | OtherOutflowsRelatedToStructuredTransactions
    | OtherCashOutflows


{-| Maps product IDs to products.
-}
productFromID : Int -> Maybe Product
productFromID id =
    case id of
        1 ->
            Just DerivativePayables

        2 ->
            Just CollateralCalledForDelivery

        3 ->
            Just TBAPurchases

        4 ->
            Just CreditFacilities

        5 ->
            Just LiquidityFacilities

        6 ->
            Just RetailMortgageCommitments

        7 ->
            Just TradeFinanceInstruments

        8 ->
            Just MTMImpactOnDerivativePositions

        9 ->
            Just LossOfRehypothecationRightsDueToA1NotchDowngrade

        10 ->
            Just LossOfRehypothecationRightsDueToA2NotchDowngrade

        11 ->
            Just LossOfRehypothecationRightsDueToA3NotchDowngrade

        12 ->
            Just LossOfRehypothecationRightsDueToAChangeInFinancialCondition

        13 ->
            Just TotalCollateralRequiredDueToA1NotchDowngrade

        14 ->
            Just TotalCollateralRequiredDueToA2NotchDowngrade

        15 ->
            Just TotalCollateralRequiredDueToA3NotchDowngrade

        16 ->
            Just TotalCollateralRequiredDueToAChangeInFinancialCondition

        17 ->
            Just ExcessMargin

        18 ->
            Just UnfundedTermMargin

        19 ->
            Just InterestDividendsPayable

        20 ->
            Just Net30DayDerivativePayables

        21 ->
            Just OtherOutflowsRelatedToStructuredTransactions

        22 ->
            Just OtherCashOutflows

        _ ->
            Nothing


{-| O.O.1: Outflows - Other - Derivative Payables
-}
o_O_1 : Product
o_O_1 =
    DerivativePayables


{-| O.O.2: Outflows - Other - Collateral Called for Delivery
-}
o_O_2 : Product
o_O_2 =
    CollateralCalledForDelivery


{-| O.O.3: Outflows - Other - TBA Purchases
-}
o_O_3 : Product
o_O_3 =
    TBAPurchases


{-| O.O.4: Outflows - Other - Credit Facilities
-}
o_O_4 : Product
o_O_4 =
    CreditFacilities


{-| O.O.5: Outflows - Other - Liquidity Facilities
-}
o_O_5 : Product
o_O_5 =
    LiquidityFacilities


{-| O.O.6: Outflows - Other - Retail Mortgage Commitments
-}
o_O_6 : Product
o_O_6 =
    RetailMortgageCommitments


{-| O.O.7: Outflows - Other - Trade Finance Instruments
-}
o_O_7 : Product
o_O_7 =
    TradeFinanceInstruments


{-| O.O.8: Outflows - Other - MTM Impact on Derivative Positions
-}
o_O_8 : Product
o_O_8 =
    MTMImpactOnDerivativePositions


{-| O.O.9: Outflows - Other - Loss of Rehypothecation Rights Due to a 1 Notch Downgrade
-}
o_O_9 : Product
o_O_9 =
    LossOfRehypothecationRightsDueToA1NotchDowngrade


{-| O.O.10: Outflows - Other - Loss of Rehypothecation Rights Due to a 2 Notch Downgrade
-}
o_O_10 : Product
o_O_10 =
    LossOfRehypothecationRightsDueToA2NotchDowngrade


{-| O.O.11: Outflows - Other - Loss of Rehypothecation Rights Due to a 3 Notch Downgrade
-}
o_O_11 : Product
o_O_11 =
    LossOfRehypothecationRightsDueToA3NotchDowngrade


{-| O.O.12: Outflows - Other - Loss of Rehypothecation Rights Due to a Change in Financial Condition
-}
o_O_12 : Product
o_O_12 =
    LossOfRehypothecationRightsDueToAChangeInFinancialCondition


{-| O.O.13: Outflows - Other - Total Collateral Required Due to a 1 Notch Downgrade
-}
o_O_13 : Product
o_O_13 =
    TotalCollateralRequiredDueToA1NotchDowngrade


{-| O.O.14: Outflows - Other - Total Collateral Required Due to a 2 Notch Downgrade
-}
o_O_14 : Product
o_O_14 =
    TotalCollateralRequiredDueToA2NotchDowngrade


{-| O.O.15: Outflows - Other - Total Collateral Required Due to a 3 Notch Downgrade
-}
o_O_15 : Product
o_O_15 =
    TotalCollateralRequiredDueToA3NotchDowngrade


{-| O.O.16: Outflows - Other - Total Collateral Required Due to a Change in Financial Condition
-}
o_O_16 : Product
o_O_16 =
    TotalCollateralRequiredDueToAChangeInFinancialCondition


{-| O.O.17: Outflows - Other - Excess Margin
-}
o_O_17 : Product
o_O_17 =
    ExcessMargin


{-| O.O.18: Outflows - Other - Unfunded Term Margin
-}
o_O_18 : Product
o_O_18 =
    UnfundedTermMargin


{-| O.O.19: Outflows - Other - Interest & Dividends Payable
-}
o_O_19 : Product
o_O_19 =
    InterestDividendsPayable


{-| O.O.20: Outflows - Other - Net 30-Day Derivative Payables
-}
o_O_20 : Product
o_O_20 =
    Net30DayDerivativePayables


{-| O.O.21: Outflows - Other - Other Outflows Related to Structured Transactions
-}
o_O_21 : Product
o_O_21 =
    OtherOutflowsRelatedToStructuredTransactions


{-| O.O.22: Outflows - Other - Other Cash Outflows
-}
o_O_22 : Product
o_O_22 =
    OtherCashOutflows