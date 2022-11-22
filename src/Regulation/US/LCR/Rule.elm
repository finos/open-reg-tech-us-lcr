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


module Regulation.US.LCR.Rule exposing (..)


applyRule : Bool -> String -> Float -> List ( String, Float )
applyRule flag label amount =
    -- TODO add haircut
    if flag then
        [ ( label, amount ) ]

    else
        []


type Rule
    = Rule_20_a_1_C
    | Rule_20_a_1
    | Rule_22_b_3_L1
    | Rule_22_a_3_L1
    | Rule_22_b_5_L1
    | Rule_20_b_1
    | Rule_22_b_3_L2a
    | Rule_22_a_3_L2a
    | Rule_22_b_5_L2a
    | Rule_20_c_1
    | Rule_22_b_3_L2b
    | Rule_22_a_3_L2b
    | Rule_22_b_5_L2b
    | Rule_21_c
    | Rule_21_d
    | Rule_21_e
    | Rule_21_f
    | Rule_21_g
    | Rule_21_h
    | Rule_21_i


rule : List Rule
rule =
    List.concat
        [ eligibleLevel1LiquidAssets
        , eligibleLevel2ALiquidAssets
        , eligibleLevel2BLiquidAssets
        , excessHQLAAdjustment
        ]


eligibleLevel1LiquidAssets : List Rule
eligibleLevel1LiquidAssets =
    [ Rule_20_a_1_C
    , Rule_20_a_1
    , Rule_22_b_3_L1
    , Rule_22_a_3_L1
    , Rule_22_b_5_L1
    ]


eligibleLevel2ALiquidAssets : List Rule
eligibleLevel2ALiquidAssets =
    [ Rule_20_b_1
    , Rule_22_b_3_L2a
    , Rule_22_a_3_L2a
    , Rule_22_b_5_L2a
    ]


eligibleLevel2BLiquidAssets : List Rule
eligibleLevel2BLiquidAssets =
    [ Rule_20_c_1
    , Rule_22_b_3_L2b
    , Rule_22_a_3_L2b
    , Rule_22_b_5_L2b
    ]


excessHQLAAdjustment : List Rule
excessHQLAAdjustment =
    List.concat
        [ unadjustedExcess
        , adjustedExcess
        ]


unadjustedExcess : List Rule
unadjustedExcess =
    [ Rule_21_c
    , Rule_21_d
    , Rule_21_e
    ]


adjustedExcess : List Rule
adjustedExcess =
    [ Rule_21_f
    , Rule_21_g
    , Rule_21_h
    , Rule_21_i
    ]
