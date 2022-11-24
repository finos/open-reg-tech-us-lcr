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


module Regulation.US.LCR.Inflows.Assets exposing (applyRules)

import Morphir.SDK.Aggregate as Aggregate exposing (..)
import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (..)
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.FR2052A.Fields.Insured as Insured
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct exposing (currency_and_coin)
import Regulation.US.LCR.AmountCalculations exposing (..)
import Regulation.US.LCR.Rule exposing (applyRule)


{-| Given a list of Assets, applies the applicable rule for each assets, applies the appropriate haircut for the rule,
and sums the results.

TODO: Apply the haircuts

-}
type alias Flow =
    { label : String, value : Float }


sumToRule : List Assets -> List Flow
sumToRule assetsList =
    assetsList
        |> List.map
            (\asset ->
                { label =
                    if match_rule_1_section_20_a_1_C asset then
                        "20(a)(1)-C"

                    else if match_rule_1_section_20_a_1 asset then
                        "20(a)(1)"

                    else if match_rule_1_section_20_b_1 asset then
                        "20(b)(1)"

                    else if match_rule_1_section_20_c_1 asset then
                        "20(c)(1)"

                    else if match_rule_107_section_33_d_1 asset then
                        "33(d)(1)"

                    else
                        ""
                , value = asset.marketValue
                }
            )
        |> List.filter (\a -> a.label /= "")
        |> Aggregate.groupBy .label
        |> Aggregate.aggregate
            (\key values ->
                { label = key
                , value = values (Aggregate.sumOf .value)
                }
            )


applyRules : Assets -> List ( String, Float )
applyRules flow =
    List.concat
        [ applyRule (match_rule_1_section_20_a_1_C flow) "20(a)(1)-C" flow.marketValue
        , applyRule (match_rule_1_section_20_a_1 flow) "20(a)(1)" flow.marketValue
        , applyRule (match_rule_1_section_20_b_1 flow) "20(b)(1)" flow.marketValue
        , applyRule (match_rule_1_section_20_c_1 flow) "20(c)(1)" flow.marketValue
        , applyRule (match_rule_107_section_33_d_1 flow) "33(d)(1)" flow.marketValue
        ]


rule_1_section_20_a_1_C : List Assets -> Float
rule_1_section_20_a_1_C assets =
    assets
        |> List.filter match_rule_1_section_20_a_1_C
        |> List.map .marketValue
        |> List.sum


rule_1_section_20_a_1 : List Assets -> Float
rule_1_section_20_a_1 assets =
    assets
        |> List.filter match_rule_1_section_20_a_1
        |> List.map .marketValue
        |> List.sum


rule_1_section_20_b_1 : List Assets -> Float
rule_1_section_20_b_1 assets =
    assets
        |> List.filter match_rule_1_section_20_b_1
        |> List.map .marketValue
        |> List.sum


rule_1_section_20_c_1 : List Assets -> Float
rule_1_section_20_c_1 assets =
    assets
        |> List.filter match_rule_1_section_20_c_1
        |> List.map .marketValue
        |> List.sum


rule_107_section_33_d_1 : List Assets -> Float
rule_107_section_33_d_1 assets =
    assets
        |> List.filter match_rule_107_section_33_d_1
        |> List.map .marketValue
        |> List.sum


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
match_rule_1_section_20_a_1_C : Assets -> Bool
match_rule_1_section_20_a_1_C flow =
    List.member flow.product [ i_A_3 ]
        -- Sub-Product: Not Currency and Coin
        --&& (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
        && (flow.subProduct /= Just currency_and_coin)
        ---- Maturity Bucket: Open
        --&& MaturityBucket.isOpen flow.maturityBucket
        ---- Collateral Class: A-0-Q
        --&& CollateralClass.isCash flow.collateralClass
        -- Forward Start Amount: NULL
        && (flow.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (flow.forwardStartBucket == Nothing)
        -- Encumbrance Type: Null
        && (flow.encumbranceType == Nothing)
        -- Treasury Control: Y
        && (flow.treasuryControl == True)


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
match_rule_1_section_20_a_1 : Assets -> Bool
match_rule_1_section_20_a_1 flow =
    List.member flow.product [ i_A_1, i_A_2 ]
        -- Sub-Product: Not Currency and Coin
        --&& (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
        && (flow.subProduct /= Just currency_and_coin)
        ---- Collateral Class: A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q
        --&& (CollateralClass.isHQLALevel1 flow.collateralClass && not (CollateralClass.isCash flow.collateralClass))
        -- Forward Start Amount: NULL
        && (flow.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (flow.forwardStartBucket == Nothing)
        -- Encumbrance Type: Null
        && (flow.encumbranceType == Nothing)
        -- Treasury Control: Y
        && (flow.treasuryControl == True)


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
match_rule_1_section_20_b_1 : Assets -> Bool
match_rule_1_section_20_b_1 flow =
    List.member flow.product [ i_A_1, i_A_2 ]
        -- Sub-Product: Not Currency and Coin
        --&& (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
        && (flow.subProduct /= Just currency_and_coin)
        ---- Collateral Class: G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q
        --&& CollateralClass.isHQLALevel2A flow.collateralClass
        -- Forward Start Amount: NULL
        && (flow.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (flow.forwardStartBucket == Nothing)
        -- Encumbrance Type: Null
        && (flow.encumbranceType == Nothing)
        -- Treasury Control: Y
        && (flow.treasuryControl == True)


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
match_rule_1_section_20_c_1 : Assets -> Bool
match_rule_1_section_20_c_1 flow =
    List.member flow.product [ i_A_1, i_A_2 ]
        -- Sub-Product: Not Currency and Coin
        --&& (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
        && (flow.subProduct /= Just currency_and_coin)
        ---- Collateral Class: E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
        --&& CollateralClass.isHQLALevel2B flow.collateralClass
        -- Forward Start Amount: NULL
        && (flow.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (flow.forwardStartBucket == Nothing)
        -- Encumbrance Type: Null
        && (flow.encumbranceType == Nothing)
        -- Treasury Control: Y
        && (flow.treasuryControl == True)


{-| (107) Financial and Central Bank Cash Inflow Amount (§.33(d)(1))
-}
match_rule_107_section_33_d_1 : Assets -> Bool
match_rule_107_section_33_d_1 flow =
    List.member flow.product [ i_A_3 ]
        -- Maturity Bucket: <= 30 calendar days but not Open
        --&& (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket && not (MaturityBucket.isOpen flow.maturityBucket))
        ---- Collateral Class: A-0-Q
        --&& CollateralClass.isCash flow.collateralClass
        -- Forward Start Amount: NULL
        && (flow.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (flow.forwardStartBucket == Nothing)
