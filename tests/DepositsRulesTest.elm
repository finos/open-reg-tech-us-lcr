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


module DepositsRulesTest exposing (..)

import Expect
import Regulation.US.FR2052A.DataTables.Outflows.Deposits exposing (Deposits, o_D_1)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency(..))
import Regulation.US.FR2052A.Fields.Insured exposing (Insured(..))
import Regulation.US.LCR.Outflows.Deposits exposing (toRuleBalances)
import Regulation.US.LCR.Rules exposing (RuleBalance)
import Test exposing (Test, test)


deposits : List Deposits
deposits =
    [ Deposits USD True "Bank1" o_D_1 "OtherBank1" Nothing 100 1 Nothing Nothing Nothing FDIC "trig1" Nothing "bl" "in" Nothing
    ]


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
            getAmount (toRuleBalances deposits)
                |> Expect.equal 100
