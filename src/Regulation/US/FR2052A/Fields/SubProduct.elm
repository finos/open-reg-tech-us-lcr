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


currency_and_coin : String
currency_and_coin =
    "Currency and Coin"


isCurrencyAndCoin : SubProduct -> Bool
isCurrencyAndCoin subProduct =
    subProduct == currency_and_coin


isHQLA : SubProduct -> Bool
isHQLA subProduct =
    isHQLALevel1 subProduct || isHQLALevel2A subProduct || isHQLALevel2B subProduct


level_1 : String
level_1 =
    "Level 1"


isHQLALevel1 : SubProduct -> Bool
isHQLALevel1 subProduct =
    subProduct == level_1


level_2A : String
level_2A =
    "Level 2a"


isHQLALevel2A : SubProduct -> Bool
isHQLALevel2A subProduct =
    subProduct == level_2A


level_2B : String
level_2B =
    "Level 2b"


isHQLALevel2B : SubProduct -> Bool
isHQLALevel2B subProduct =
    subProduct == level_2B


non_HQLA : String
non_HQLA =
    "Non-HQLA"


isNonHQLA : SubProduct -> Bool
isNonHQLA subProduct =
    subProduct == non_HQLA


no_collateral_pledged : String
no_collateral_pledged =
    "No Collateral Pledged"


isNoCollateralPledged : SubProduct -> Bool
isNoCollateralPledged subProduct =
    subProduct == no_collateral_pledged


rehypothecateable_collateral_unencumbered : String
rehypothecateable_collateral_unencumbered =
    "Rehypothecateable Collateral Unencumbered"


isRehypothecateableCollateralUnencumbered : SubProduct -> Bool
isRehypothecateableCollateralUnencumbered subProduct =
    subProduct == rehypothecateable_collateral_unencumbered


unsettled_regular_way : String
unsettled_regular_way =
    "Unsettled (Regular Way)"


isUnsettledRegularWay : SubProduct -> Bool
isUnsettledRegularWay subProduct =
    subProduct == unsettled_regular_way


unsettled_forward : String
unsettled_forward =
    "Unsettled (Forward)"


isUnsettledForward : SubProduct -> Bool
isUnsettledForward subProduct =
    subProduct == unsettled_forward


firm_long : String
firm_long =
    "firm long"


isFirmLong : SubProduct -> Bool
isFirmLong subProduct =
    subProduct == firm_long


customer_long : String
customer_long =
    "Customer long"


isCustomerLong : SubProduct -> Bool
isCustomerLong subProduct =
    subProduct == customer_long


specific_central_bank : String
specific_central_bank =
    "Specific central bank"


isSpecificCentralBank : SubProduct -> Bool
isSpecificCentralBank subProduct =
    subProduct == specific_central_bank


isSubProduct : Maybe SubProduct -> (SubProduct -> Bool) -> Bool
isSubProduct subProduct filter =
    case subProduct of
        Just sp ->
            filter sp

        Nothing ->
            False
