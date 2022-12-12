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


module Regulation.US.LCR.Weights exposing (..)

import Regulation.US.LCR.Ratio exposing (Ratio, percent, unit)
import Regulation.US.LCR.Rule exposing (Rule, eligibleLevel1LiquidAssets, eligibleLevel2ALiquidAssets, eligibleLevel2BLiquidAssets)


type alias Weight =
    Ratio


sectionWeight : Rule -> Weight
sectionWeight rule =
    if List.member rule eligibleLevel1LiquidAssets then
        percent 100

    else if List.member rule eligibleLevel2ALiquidAssets then
        percent 85

    else if List.member rule eligibleLevel2BLiquidAssets then
        percent 50

    else
        unit
