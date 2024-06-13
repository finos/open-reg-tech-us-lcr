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


module CalculationsTest exposing (..)

import Regulation.US.FR2052A.DataTables as DataTables exposing (DataTables)
import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (..)
import Regulation.US.FR2052A.DataTables.Inflows.Unsecured exposing (Unsecured, Product(..))
import Regulation.US.FR2052A.DataTables.Inflows.Secured exposing (Secured, Product(..))
import Regulation.US.LCR.Inflows.Secured exposing (..)
import Regulation.US.FR2052A.Fields.Counterparty as Counterparty
import Regulation.US.FR2052A.DataTables.Outflows.Deposits as Deposits exposing (o_D_1)
import Regulation.US.FR2052A.Fields.CollateralClass exposing (a_0_Q)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency(..))
import Regulation.US.FR2052A.Fields.Insured exposing (Insured(..))
import Regulation.US.LCR.Calculations exposing (..)
import Regulation.US.FR2052A.Fields.Counterparty exposing (..)
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct
import Regulation.US.LCR.HQLAAmountValues as HQLAAmountValues
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (..)
import Regulation.US.LCR.Rules as Rules
import Regulation.US.LCR.Basics exposing (..)
import Regulation.US.LCR.AggregatedRuleBalances exposing (..)
import Regulation.US.LCR.HQLAAmountValues exposing (..)

import Test exposing (Test, test, describe)
import Expect exposing(..)


assetsMarketValue = 30
assets : Assets
assets = Assets USD True "LCR" UnrestrictedReserveBalances (Just SubProduct.level_1) assetsMarketValue "Valuable" (Day 20) Nothing Nothing a_0_Q True "None" Nothing Nothing Nothing "Trade"

unsecured : Unsecured
unsecured = Unsecured USD True "LCR" OnshorePlacements (Just Counterparty.Retail) (Just "gsib") 75 Open Nothing Nothing Nothing Nothing Nothing "internal" Nothing Nothing "Trade"
    
securedMaturityAmount = 80
secured : Secured
secured = Secured USD True "LCR" ReverseRepo (Just SubProduct.level_1) securedMaturityAmount (Day 10) Nothing Nothing Nothing Nothing Nothing "internal" 10 True True "internal" Nothing Nothing "busi" "settlement" Bank Nothing

inflows =
    DataTables.Inflows [assets] [] [secured] []


deposits =
    [ Deposits.Deposits USD True "Bank1" o_D_1 Central_Bank Nothing 100 Open Nothing Nothing Nothing FDIC "trig1" Nothing "bl" "in" Nothing
    ]


outflows =
    DataTables.Outflows deposits [] [] []


supplemental =
    DataTables.Supplemental [] [] [] [] []


dataTables : DataTables
dataTables =
    DataTables inflows outflows supplemental


testTotalNetCashOutflows : Test
testTotalNetCashOutflows =
    test "function total_net_cash_outflows" <|
        \_ ->
        total_net_cash_outflows dataTables Global_systemically_important_BHC_or_GSIB_depository_institution
        |> Expect.within (Absolute 0.000000001) 25 -- 100 - min(80, 0.75 * 100)

testIsSubProduct : Test
testIsSubProduct = 
    test "test isSubProduct function" <|
        \_ ->
            [assets]
                |> List.filter (\a -> SubProduct.isSubProduct a.subProduct SubProduct.isHQLALevel1)
                |> List.length
                |> Expect.equal 1

testInflowRules : Test
testInflowRules = 
    test "test applyInflowRules function" <|
        \_ ->
            -- toRuleBalances 1 [secured]
            
                applyInflowRules 1 inflows
                    -- |> Expect.equal [RuleBalance "33(c)" 30,  RuleBalance "33(d)(1)" 80]
                |> Rules.matchAndSum
                    [ "33(c)"
                    , "33(d)(1)" 
                    , "33(d)(2)" 
                    , "20(a)(1)"
                    , "20(b)(1)"
                    , "20(c)(1)"
                    , "33(f)(1)(ii)"
                    ]
                    |> Expect.equal (assetsMarketValue + securedMaturityAmount) -- 33(c) and 33(f)(1)(ii)
     

testLevel1 : Test
testLevel1 = 
    test "test level_1_HQLA_additive_values function" <|
        \() ->
            HQLAAmountValues.level_1_HQLA_additive_values t0 dataTables
            |> Expect.equal assetsMarketValue 

testHqlaAmount : Test
testHqlaAmount = 
    test "function hqla_amount" <|
        \_ ->
        hqla_amount dataTables
            |> Expect.within (Absolute 0.000000001) assetsMarketValue          


hqlaAmountTests : Test
hqlaAmountTests = 
    describe "test each expression in function hqla_amount"
    [
        test "1st part" <|
            \_ ->
            (level_1_HQLA_additive_values t0 dataTables - level_1_HQLA_subtractive_values dataTables)
            |> Expect.within (Absolute 0.000000001) assetsMarketValue
        , test "2nd part" <|
            \_ ->
            0.85 * (level_2A_HQLA_additive_values t0 dataTables - level_2A_HQLA_subtractive_values dataTables)
            |> Expect.within (Absolute 0.000000001) 0
        , test "3rd part" <|
            \_ ->
            0.5 * (level_2B_HQLA_additive_values t0 dataTables - level_2A_HQLA_additive_values t0 dataTables)
            |> Expect.within (Absolute 0.000000001) 0
        , test "level_2_cap_excess_amount" <|
            \_ ->
            level_2_cap_excess_amount dataTables
            |> Expect.within (Absolute 0.000000001) 0
        , test "level_2B_cap_excess_amount" <|
            \_ ->
            level_2B_cap_excess_amount dataTables
            |> Expect.within (Absolute 0.000000001) 0
        , test "adjusted_excess_HQLA" <|
            \_ ->
            adjusted_excess_HQLA dataTables
            |> Expect.within (Absolute 0.000000001) 0
    ]