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


module AssetsRulesTest exposing (..)

import Expect
import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (Assets, Product(..))
import Regulation.US.FR2052A.Fields.CollateralClass exposing (a_0_Q, a_1_Q)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency(..))
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket(..))
import Regulation.US.LCR.Inflows.Assets as Assets exposing (rule_107_section_33_d_1, rule_1_section_20_a_1, rule_1_section_20_a_1_C)
import Regulation.US.LCR.Rules exposing (RuleBalance)
import Test exposing (Test, test)


assets : List Assets
assets =
    [ Assets USD True "LCR" UnencumberedAssets (Just "not Currency and Coin") 60 "Valuable" (Day 1) Nothing Nothing a_1_Q True "None" Nothing Nothing Nothing "Trade"
    ]


reserveAssets : Assets
reserveAssets =
    Assets USD True "LCR" UnrestrictedReserveBalances (Just "not Currency and Coin") 100 "Valuable" (Day 10) Nothing Nothing a_0_Q True "None" Nothing Nothing Nothing "Trade"


testRule1Section20A1 : Test
testRule1Section20A1 =
    test "testRule1Section20A1" <|
        \_ ->
            Assets USD True "LCR" UnencumberedAssets (Just "not Currency and Coin") 60 "Valuable" (Day 1) Nothing Nothing a_1_Q True "None" Nothing Nothing Nothing "Trade"
                |> rule_1_section_20_a_1
                |> Expect.equal (Just (RuleBalance "20(a)(1)" 60))


testRule107Section33D1 : Test
testRule107Section33D1 =
    test "testRule107Section33D1" <|
        \_ ->
            rule_107_section_33_d_1 0 reserveAssets
                |> Expect.equal (Just (RuleBalance "33(d)(1)" 100))


getAmount : List RuleBalance -> Float
getAmount rbs =
    rbs
        |> List.head
        |> Maybe.map .amount
        |> Maybe.withDefault 0


testToRuleBalances : Test
testToRuleBalances =
    test "toRuleBalances" <|
        \_ ->
            getAmount (Assets.toRuleBalances 0 assets)
                |> Expect.equal 60
