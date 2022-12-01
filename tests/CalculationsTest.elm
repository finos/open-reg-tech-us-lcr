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
import Regulation.US.FR2052A.DataTables.Outflows exposing (Outflows(..))
import Regulation.US.FR2052A.DataTables.Outflows.Deposits as Deposits exposing (o_D_1)
import Regulation.US.FR2052A.Fields.CollateralClass exposing (a_0_Q)
import Regulation.US.FR2052A.Fields.Currency exposing (Currency(..))
import Regulation.US.FR2052A.Fields.Insured exposing (Insured(..))
import Regulation.US.LCR.Calculations as Calculations exposing (..)
import Test exposing (Test, test)


assets : List Assets
assets =
    [ Assets USD True "LCR" UnencumberedAssets (Just "not Currency and Coin") 60 "Valuable" 1 Nothing Nothing a_0_Q True "None" Nothing Nothing Nothing "Trade"
    ]


inflows =
    DataTables.Inflows assets [] [] []


deposits =
    [ Deposits.Deposits USD True "Bank1" o_D_1 "OtherBank1" Nothing 100 1 Nothing Nothing Nothing FDIC "trig1" Nothing "bl" "in" Nothing
    ]


outflows =
    DataTables.Outflows deposits [] [] []


supplemental =
    DataTables.Supplemental [] [] [] [] []


dataTables : DataTables
dataTables =
    DataTables inflows outflows supplemental


endpoint : Test
endpoint =
    test "endpoint" <|
        \_ ->
            Calculations.endpoint Global_systemically_important_BHC_or_GSIB_depository_institution dataTables
                |> Float.within (Absolute 0.000000001) 0.6
