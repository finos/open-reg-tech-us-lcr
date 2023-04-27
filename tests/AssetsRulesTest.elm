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

import Array
import Expect
import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (Assets, Product(..))
import Regulation.US.FR2052A.Fields.CollateralClass exposing (a_0_Q)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency(..))
-- import Regulation.US.LCR.Inflows.ApplyRules exposing (rule_1_section_20_a_1)
import Regulation.US.LCR.Inflows.Assets as Assets exposing (rule_1_section_20_a_1, rule_1_section_20_a_1_C)
import Regulation.US.LCR.Rules exposing (RuleBalance)
import Test exposing (Test, test)


assets : List Assets
assets =
    [ Assets USD True "LCR" UnencumberedAssets (Just "not Currency and Coin") 60 "Valuable" 1 Nothing Nothing a_0_Q True "None" Nothing Nothing Nothing "Trade"
    ]

testRule1Section20A1C : Test
testRule1Section20A1C =
    test "testRule1Section20A1" <|
        \_ ->
            assets
                |> List.map Assets.rule_1_section_20_a_1
                |> List.filterMap identity
                |> Expect.equal [6.0]


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
            getAmount (Assets.toRuleBalances assets)
                |> Expect.equal 100
