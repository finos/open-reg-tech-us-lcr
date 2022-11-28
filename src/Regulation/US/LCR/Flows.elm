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


module Regulation.US.LCR.Flows exposing (..)

import Regulation.US.FR2052A.DataTables as DataTables exposing (..)
import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (Assets)
import Regulation.US.FR2052A.DataTables.Supplemental exposing (Supplemental(..))
import Regulation.US.FR2052A.DataTables.Supplemental.DerivativesCollateral exposing (DerivativesCollateral)
import Regulation.US.LCR.Inflows.Assets as Assets
import Regulation.US.LCR.Inflows.Other as InOther
import Regulation.US.LCR.Inflows.Secured as InSecured
import Regulation.US.LCR.Inflows.Unsecured as Unsecured
import Regulation.US.LCR.Outflows.Deposits as Deposits
import Regulation.US.LCR.Outflows.Other as OutOther
import Regulation.US.LCR.Outflows.Secured as OutSecured
import Regulation.US.LCR.Outflows.Wholesale as Wholesales
import Regulation.US.LCR.Rules exposing (RuleBalance)
import Regulation.US.LCR.Supplemental.DerivativesCollateral as DerivativesCollateral
import Regulation.US.LCR.Supplemental.LiquidityRiskMeasurement as LiquidityRiskMeasurement



--type Input_20_a_1
--    = Assets (List Assets)
--    | DerivativesCollateral (List DerivativesCollateral)
--
--
--rule_20_a_1 : Input_20_a_1 -> Float
--rule_20_a_1 input =
--    case input of
--        Assets assets ->
--            assets
--                |> List.filterMap Assets.rule_20_a_1
--                |> List.sum
--
--        DerivativesCollateral derivatives ->
--            derivatives
--                |> List.filterMap DerivativesCollateral.rule_20_a_1
--                |> List.sum


type alias Flow =
    { label : String, value : Float }


{-| The list of all rules pertaining to inflows.
-}
applyInflowRules : DataTables.Inflows -> List RuleBalance
applyInflowRules inflows =
    List.concat
        [ --List.concatMap (\a -> Assets.applyRules a) inflows.assets
          --,
          List.concatMap (\u -> Unsecured.applyRules u) inflows.unsecured
        , List.concatMap (\s -> InSecured.applyRules s) inflows.secured

        --, List.concatMap (\o -> InOther.applyRules o) inflows.other
        ]


{-| The list of all rules pertaining to outflows.
-}
applyOutflowRules : DataTables.Outflows -> List RuleBalance
applyOutflowRules outflows =
    List.concat
        [ List.concatMap (\d -> Deposits.applyRules d) outflows.deposits
        , List.concatMap (\s -> OutSecured.applyRules s) outflows.secured
        , List.concatMap (\w -> Wholesales.applyRules w) outflows.wholesale
        , List.concatMap (\o -> OutOther.applyRules o) outflows.other
        ]


{-| The list of all rules pertaining to supplementals.
-}
applySupplementalRules : DataTables.Supplemental -> List RuleBalance
applySupplementalRules supplementals =
    List.concat
        [ List.concatMap (\d -> DerivativesCollateral.applyRules d) supplementals.derivativesCollateral
        , List.concatMap (\l -> LiquidityRiskMeasurement.applyRules l) supplementals.liquidityRiskMeasurement
        ]
