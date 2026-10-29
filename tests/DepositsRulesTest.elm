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
import Regulation.US.FR2052A.DataTables.Outflows.Deposits exposing (Deposits, o_D_1, o_D_10)
import Regulation.US.FR2052A.Fields.CollateralClass exposing (e_1_Q)
import Regulation.US.FR2052A.Fields.Counterparty as Counterparty
import Regulation.US.FR2052A.Fields.Currency exposing (Currency(..))
import Regulation.US.FR2052A.Fields.Insured exposing (Insured(..))
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket(..))
import Regulation.US.LCR.Outflows.Deposits exposing (rule_72_section_32_j_1_iv_amount, toRuleBalances)
import Regulation.US.LCR.Rules exposing (RuleBalance)
import Test exposing (Test, test)


deposits : List Deposits
deposits =
    [ Deposits USD True "Bank1" o_D_1 Counterparty.Retail Nothing 100 (Day 1) Nothing Nothing Nothing FDIC "N" Nothing "bl" "N" Nothing
    ]


collateralizedDeposit : Deposits
collateralizedDeposit =
    Deposits USD True "Bank1" o_D_10 Counterparty.Retail Nothing 10000 (Day 15) Nothing (Just e_1_Q) (Just 8000) Other "N" (Just True) "bl" "N" Nothing


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
            getAmount (toRuleBalances 0 deposits)
                |> Expect.equal 100


testRule72Section32J1IvAmount : Test
testRule72Section32J1IvAmount =
    test "rule72Section32J1IvAmount emits 32(j)(1)(iv)" <|
        \_ ->
            rule_72_section_32_j_1_iv_amount collateralizedDeposit
                |> Expect.equal
                    [ RuleBalance "32(h)" 2000
                    , RuleBalance "32(j)(1)(iv)" 10000
                    ]
