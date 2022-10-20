module Regulation.US.LCR.Rule exposing (..)


applyRule : Bool -> String -> Float -> List ( String, Float )
applyRule flag label amount =
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
