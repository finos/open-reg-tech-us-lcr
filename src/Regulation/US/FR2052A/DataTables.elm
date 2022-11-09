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


module Regulation.US.FR2052A.DataTables exposing (..)

{-| TODO: extract documentation from FED document
-}

import Regulation.US.FR2052A.DataTables.Inflows.Assets as Inflows
import Regulation.US.FR2052A.DataTables.Inflows.Other as Inflows
import Regulation.US.FR2052A.DataTables.Inflows.Secured as Inflows
import Regulation.US.FR2052A.DataTables.Inflows.Unsecured as Inflows
import Regulation.US.FR2052A.DataTables.Outflows.Deposits as Outflows
import Regulation.US.FR2052A.DataTables.Outflows.Other as Outflows
import Regulation.US.FR2052A.DataTables.Outflows.Secured as Outflows
import Regulation.US.FR2052A.DataTables.Outflows.Wholesale as Outflows
import Regulation.US.FR2052A.DataTables.Supplemental.BalanceSheet as Supplemental
import Regulation.US.FR2052A.DataTables.Supplemental.DerivativesCollateral as Supplemental
import Regulation.US.FR2052A.DataTables.Supplemental.ForeignExchange as Supplemental
import Regulation.US.FR2052A.DataTables.Supplemental.Informational as Supplemental
import Regulation.US.FR2052A.DataTables.Supplemental.LiquidityRiskMeasurement as Supplemental


type alias DataTables =
    { inflows : Inflows
    , outflows : Outflows
    , supplemental : Supplemental
    }


type alias Inflows =
    { assets : List Inflows.Assets
    , unsecured : List Inflows.Unsecured
    , secured : List Inflows.Secured
    , other : List Inflows.Other
    }


type alias Outflows =
    { deposits : List Outflows.Deposits
    , wholesale : List Outflows.Wholesale
    , secured : List Outflows.Secured
    , other : List Outflows.Other
    }


type alias Supplemental =
    { informational : List Supplemental.Informational
    , derivativesCollateral : List Supplemental.DerivativesCollateral
    , liquidityRiskMeasurement : List Supplemental.LiquidityRiskMeasurement
    , balanceSheet : List Supplemental.BalanceSheet
    , foreignExchange : List Supplemental.ForeignExchange
    }


type Flow
    = Asset Inflows.Assets
    | Unsecured Inflows.Unsecured
    | InfSecured Inflows.Secured
    | InfOther Inflows.Other
    | Deposit Outflows.Deposits
    | OutSecured Outflows.Secured
    | Wholesale Outflows.Wholesale
    | OutOther Outflows.Other
    | Informational Supplemental.Informational
    | DerivativesCollateral Supplemental.DerivativesCollateral
    | LiquidityRiskMeasurement Supplemental.LiquidityRiskMeasurement
    | BalanceSheet Supplemental.BalanceSheet
    | ForeignExchange Supplemental.ForeignExchange
