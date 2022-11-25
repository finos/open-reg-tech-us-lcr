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


module Tests exposing (..)

import Expect
import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (Assets, Product(..))
import Regulation.US.FR2052A.Fields.Currency exposing (Currency(..))
import Regulation.US.LCR.Inflows.Assets exposing (rule_1_section_20_a_1_C)
import Test exposing (Test, test)


testExpectTrue : Test
testExpectTrue =
    test "Expect.true test" <|
        \() ->
            True
                |> Expect.true "Expected true"


testExpectNotEqual : Test
testExpectNotEqual =
    test "Expect Not Equal" <|
        \() ->
            Expect.notEqual "foo" "foobar"


assets : List Assets
assets =
    [ { currency = USD
      , converted = True
      , reportingEntity = "LCR"
      , product = UnencumberedAssets
      , subProduct = Nothing
      , marketValue = 23.2
      , lendableValue = "Valuable"
      , maturityBucket = 3
      , forwardStartAmount = Nothing
      , forwardStartBucket = Nothing
      , collateralClass = "Housing"
      , treasuryControl = False
      , accountingDesignation = "None"
      , effectiveMaturityBucket = Nothing
      , encumbranceType = Nothing
      , internalCounterparty = Nothing
      , businessLine = "Trade"
      }
    , { currency = USD
      , converted = True
      , reportingEntity = "LCR"
      , product = UnrestrictedReserveBalances
      , subProduct = Nothing
      , marketValue = 3.0
      , lendableValue = "Valuable"
      , maturityBucket = 0
      , forwardStartAmount = Nothing
      , forwardStartBucket = Nothing
      , collateralClass = "a_0_Q"
      , treasuryControl = True
      , accountingDesignation = "None"
      , effectiveMaturityBucket = Nothing
      , encumbranceType = Nothing
      , internalCounterparty = Nothing
      , businessLine = "Trade"
      }
    , { currency = EUR
      , converted = True
      , reportingEntity = "LCR"
      , product = UnrestrictedReserveBalances
      , subProduct = Nothing
      , marketValue = 2.0
      , lendableValue = "Valuable"
      , maturityBucket = 0
      , forwardStartAmount = Nothing
      , forwardStartBucket = Nothing
      , collateralClass = "a_0_Q"
      , treasuryControl = True
      , accountingDesignation = "None"
      , effectiveMaturityBucket = Nothing
      , encumbranceType = Nothing
      , internalCounterparty = Nothing
      , businessLine = "Trade"
      }
    , { currency = GBP
      , converted = True
      , reportingEntity = "LCR"
      , product = UnrestrictedReserveBalances
      , subProduct = Nothing
      , marketValue = 1.0
      , lendableValue = "Valuable"
      , maturityBucket = 0
      , forwardStartAmount = Nothing
      , forwardStartBucket = Nothing
      , collateralClass = "a_0_Q"
      , treasuryControl = True
      , accountingDesignation = "None"
      , effectiveMaturityBucket = Nothing
      , encumbranceType = Nothing
      , internalCounterparty = Nothing
      , businessLine = "Trade"
      }
    ]


testRule1Section20A1C : Test
testRule1Section20A1C =
    test "testRule1Section20A1C" <|
        \_ ->
            rule_1_section_20_a_1_C assets
                |> Expect.equal 6.0
