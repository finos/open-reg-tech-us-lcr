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
import Regulation.US.LCR.Inflows.Assets as Assets
import Regulation.US.LCR.Inflows.Other as InOther
import Regulation.US.LCR.Inflows.Secured as InSecured
import Regulation.US.LCR.Inflows.Unsecured as Unsecured
import Regulation.US.LCR.Outflows.Deposits as Deposits
import Regulation.US.LCR.Outflows.Other as OutOther
import Regulation.US.LCR.Outflows.Secured as OutSecured
import Regulation.US.LCR.Outflows.Wholesale as Wholesales


type alias Flow =
    ( String, Float )


{-| The list of all rules pertaining to inflows.
-}
inflowRules : DataTables.Inflows -> List Flow
inflowRules inflows =
    List.concat
        [ List.concatMap (\a -> Assets.applyRules a) inflows.assets
        , List.concatMap (\u -> Unsecured.applyRules u) inflows.unsecured
        , List.concatMap (\s -> InSecured.applyRules s) inflows.secured
        , List.concatMap (\o -> InOther.applyRules o) inflows.other
        ]


{-| The list of all rules pertaining to outflows.
-}
outflowRules : DataTables.Outflows -> List Flow
outflowRules outflows =
    List.concat
        [ List.concatMap (\d -> Deposits.applyRules d) outflows.deposits
        , List.concatMap (\s -> OutSecured.applyRules s) outflows.secured
        , List.concatMap (\w -> Wholesales.applyRules w) outflows.wholesale
        , List.concatMap (\o -> OutOther.applyRules o) outflows.other
        ]