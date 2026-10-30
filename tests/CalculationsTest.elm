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

import Expect as Float exposing (FloatingPointTolerance(..))
import Regulation.US.FR2052A.DataTables as DataTables exposing (DataTables)
import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (Assets, Product(..))
import Regulation.US.FR2052A.DataTables.Outflows exposing (Outflows)
import Regulation.US.FR2052A.DataTables.Outflows.Deposits as Deposits exposing (o_D_1)
import Regulation.US.FR2052A.Fields.CollateralClass exposing (a_1_Q, e_1_Q, g_1_Q)
import Regulation.US.FR2052A.Fields.Counterparty as Counterparty
import Regulation.US.FR2052A.Fields.Currency exposing (Currency(..))
import Regulation.US.FR2052A.Fields.Insured exposing (Insured(..))
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket(..))
import Regulation.US.FR2052A.Fields.SubProduct exposing (level_1, level_2A, level_2B)
import Regulation.US.LCR.Calculations as Calculations exposing (..)
import Test exposing (Test, test)


assets : List Assets
assets =
    [ Assets USD True "LCR" UnencumberedAssets (Just level_1) 1000 "Valuable" Open Nothing Nothing a_1_Q True "None" Nothing Nothing Nothing "Trade"
    , Assets USD True "LCR" UnencumberedAssets (Just level_2A) 200 "Valuable" Open Nothing Nothing g_1_Q True "None" Nothing Nothing Nothing "Trade"
    , Assets USD True "LCR" UnencumberedAssets (Just level_2B) 100 "Valuable" Open Nothing Nothing e_1_Q True "None" Nothing Nothing Nothing "Trade"
    ]


inflows : DataTables.Inflows
inflows =
    DataTables.Inflows assets [] [] []


deposits : List Deposits.Deposits
deposits =
    [ Deposits.Deposits USD True "Bank1" o_D_1 Counterparty.Retail Nothing 100 (Day 1) Nothing Nothing Nothing FDIC "N" Nothing "bl" "N" Nothing
    ]


outflows : Outflows
outflows =
    DataTables.Outflows deposits [] [] []


supplemental : DataTables.Supplemental
supplemental =
    DataTables.Supplemental [] [] [] [] []


dataTables : DataTables
dataTables =
    DataTables inflows outflows supplemental


testLevel2CapExcessAmountBelowCap : Test
testLevel2CapExcessAmountBelowCap =
    test "level_2_cap_excess_amount is clamped at 0 when below 40% cap" <|
        \_ ->
            Calculations.level_2_cap_excess_amount dataTables
                |> Float.within (Absolute 0.000000001) 0


testLevel2BCapExcessAmountBelowCap : Test
testLevel2BCapExcessAmountBelowCap =
    test "level_2B_cap_excess_amount is clamped at 0 when below 15% cap" <|
        \_ ->
            Calculations.level_2B_cap_excess_amount dataTables
                |> Float.within (Absolute 0.000000001) 0


testHqlaAmount : Test
testHqlaAmount =
    test "hqla_amount sums Level 1, 0.85 * Level 2A, and 0.50 * Level 2B minus excess" <|
        \_ ->
            Calculations.hqla_amount dataTables
                |> Float.within (Absolute 0.000000001) 1220
