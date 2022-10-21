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

module Regulation.US.FR2052A.Fields.SubProduct exposing (..)


type alias SubProduct =
    String


isCurrencyAndCoin : SubProduct -> Bool
isCurrencyAndCoin subProduct =
    subProduct == "Currency and Coin"


isHQLA : SubProduct -> Bool
isHQLA subProduct =
    isHQLALevel1 subProduct || isHQLALevel2A subProduct || isHQLALevel2B subProduct


isHQLALevel1 : SubProduct -> Bool
isHQLALevel1 subProduct =
    subProduct == "Level 1"


isHQLALevel2A : SubProduct -> Bool
isHQLALevel2A subProduct =
    subProduct == "Level 2a"


isHQLALevel2B : SubProduct -> Bool
isHQLALevel2B subProduct =
    subProduct == "Level 2b"


isNonHQLA : SubProduct -> Bool
isNonHQLA subProduct =
    subProduct == "Non-HQLA"


isNoCollateralPledged : SubProduct -> Bool
isNoCollateralPledged subProduct =
    subProduct == "No Collateral Pledged"


isRehypothecateableCollateralUnencumbered : SubProduct -> Bool
isRehypothecateableCollateralUnencumbered subProduct =
    subProduct == "Rehypothecateable Collateral Unencumbered"


isUnsettledRegularWay : SubProduct -> Bool
isUnsettledRegularWay subProduct =
    subProduct == "Unsettled (Regular Way)"


isUnsettledForward : SubProduct -> Bool
isUnsettledForward subProduct =
    subProduct == "Unsettled (Forward)"


isFirmLong : SubProduct -> Bool
isFirmLong subProduct =
    subProduct == "firm long"


isCustomerLong : SubProduct -> Bool
isCustomerLong subProduct =
    subProduct == "Customer long"


isSpecificCentralBank : SubProduct -> Bool
isSpecificCentralBank subProduct =
    subProduct == "Specific central bank"
