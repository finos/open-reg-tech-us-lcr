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
import Regulation.US.FR2052A.Fields.CollateralClass exposing (..)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency(..))
import Regulation.US.LCR.Inflows.Assets as Assets exposing (..)
import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (..)
import Regulation.US.LCR.Rules exposing (RuleBalance)
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (..)
import Test exposing (Test, test)


assets : Assets
assets =
    Assets USD True "LCR" UnencumberedAssets (Just SubProduct.level_1) 60 "Valuable" Open Nothing Nothing a_1_Q True "None" Nothing Nothing Nothing "Trade"

testRule1Section20A1C : Test
testRule1Section20A1C =
    test "testRule1Section20A1" <|
        \_ ->
                [assets]
                |> List.map Assets.rule_1_section_20_a_1
                |> Expect.equal [Just 60]


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
            getAmount (Assets.toRuleBalances 15 [assets])
                |> Expect.equal 60
