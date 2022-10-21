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

module Regulation.US.FR2052A.DataTables.Supplemental exposing (..)


import Regulation.US.FR2052A.DataTables.Supplemental.Informational exposing (Informational)
import Regulation.US.FR2052A.DataTables.Supplemental.DerivativesCollateral exposing (DerivativesCollateral)
import Regulation.US.FR2052A.DataTables.Supplemental.LiquidityRiskMeasurement exposing (LiquidityRiskMeasurement)
import Regulation.US.FR2052A.DataTables.Supplemental.BalanceSheet exposing (BalanceSheet)
import Regulation.US.FR2052A.DataTables.Supplemental.ForeignExchange exposing (ForeignExchange)


type Supplemental
    = Informational Informational
    | DerivativesCollateral DerivativesCollateral
    | LiquidityRiskMeasurement LiquidityRiskMeasurement
    | BalanceSheet BalanceSheet
    | ForeignExchange ForeignExchange