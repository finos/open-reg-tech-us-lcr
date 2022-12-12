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

import Regulation.US.FR2052A.DataTables.Inflows.Assets
import Regulation.US.FR2052A.DataTables.Inflows.Other
import Regulation.US.FR2052A.DataTables.Inflows.Secured
import Regulation.US.FR2052A.DataTables.Inflows.Unsecured
import Regulation.US.FR2052A.DataTables.Outflows.Deposits
import Regulation.US.FR2052A.DataTables.Outflows.Other
import Regulation.US.FR2052A.DataTables.Outflows.Secured
import Regulation.US.FR2052A.DataTables.Outflows.Wholesale
import Regulation.US.FR2052A.DataTables.Supplemental.BalanceSheet
import Regulation.US.FR2052A.DataTables.Supplemental.DerivativesCollateral
import Regulation.US.FR2052A.DataTables.Supplemental.ForeignExchange
import Regulation.US.FR2052A.DataTables.Supplemental.Informational
import Regulation.US.FR2052A.DataTables.Supplemental.LiquidityRiskMeasurement


type alias DataTables =
    { inflows : Inflows
    , outflows : Outflows
    , supplemental : Supplemental
    }


type alias Inflows =
    { assets : List Regulation.US.FR2052A.DataTables.Inflows.Assets.Assets
    , unsecured : List Regulation.US.FR2052A.DataTables.Inflows.Unsecured.Unsecured
    , secured : List Regulation.US.FR2052A.DataTables.Inflows.Secured.Secured
    , other : List Regulation.US.FR2052A.DataTables.Inflows.Other.Other
    }


type alias Outflows =
    { deposits : List Regulation.US.FR2052A.DataTables.Outflows.Deposits.Deposits
    , wholesale : List Regulation.US.FR2052A.DataTables.Outflows.Wholesale.Wholesale
    , secured : List Regulation.US.FR2052A.DataTables.Outflows.Secured.Secured
    , other : List Regulation.US.FR2052A.DataTables.Outflows.Other.Other
    }


type alias Supplemental =
    { informational : List Regulation.US.FR2052A.DataTables.Supplemental.Informational.Informational
    , derivativesCollateral : List Regulation.US.FR2052A.DataTables.Supplemental.DerivativesCollateral.DerivativesCollateral
    , liquidityRiskMeasurement : List Regulation.US.FR2052A.DataTables.Supplemental.LiquidityRiskMeasurement.LiquidityRiskMeasurement
    , balanceSheet : List Regulation.US.FR2052A.DataTables.Supplemental.BalanceSheet.BalanceSheet
    , foreignExchange : List Regulation.US.FR2052A.DataTables.Supplemental.ForeignExchange.ForeignExchange
    }
