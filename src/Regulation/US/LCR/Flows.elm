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
import Regulation.US.LCR.MaturityBucket exposing (FromDate)
import Regulation.US.LCR.Outflows.Deposits as Deposits
import Regulation.US.LCR.Outflows.Other as OutOther
import Regulation.US.LCR.Outflows.Secured as OutSecured
import Regulation.US.LCR.Outflows.Wholesale as Wholesales
import Regulation.US.LCR.Rules exposing (RuleBalance)
import Regulation.US.LCR.Supplemental.DerivativesCollateral as DerivativesCollateral
import Regulation.US.LCR.Supplemental.LiquidityRiskMeasurement as LiquidityRiskMeasurement


{-| The list of all rules pertaining to inflows.
-}
applyInflowRules : FromDate -> DataTables.Inflows -> List RuleBalance
applyInflowRules fromDate inflows =
    List.concat
        [ List.concatMap (\a -> Assets.toRuleBalances fromDate a) [ inflows.assets ]
        , List.concatMap (\u -> Unsecured.toRuleBalances fromDate u) [ inflows.unsecured ]
        , List.concatMap (\s -> InSecured.toRuleBalances fromDate s) [ inflows.secured ]
        , List.concatMap (\o -> InOther.toRuleBalances fromDate o) [ inflows.other ]
        ]


{-| The list of all rules pertaining to outflows.
-}
applyOutflowRules : FromDate -> DataTables.Outflows -> List RuleBalance
applyOutflowRules fromDate outflows =
    List.concat
        [ List.concatMap (\d -> Deposits.applyRules fromDate d) outflows.deposits
        , List.concatMap (\s -> OutSecured.applyRules fromDate s) outflows.secured
        , List.concatMap (\w -> Wholesales.toRuleBalances fromDate w) [ outflows.wholesale ]
        , List.concatMap (\o -> OutOther.applyRules fromDate o) outflows.other
        ]


{-| The list of all rules pertaining to supplementals.
-}
applySupplementalRules : DataTables.Supplemental -> List RuleBalance
applySupplementalRules supplementals =
    List.concat
        [ List.concatMap (\d -> DerivativesCollateral.applyRules d) supplementals.derivativesCollateral
        , List.concatMap (\l -> LiquidityRiskMeasurement.applyRules l) supplementals.liquidityRiskMeasurement
        ]
