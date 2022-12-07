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


module Regulation.US.LCR.Inflows.Assets exposing (..)

import Morphir.SDK.Aggregate as Aggregate
import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (..)
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket
import Regulation.US.FR2052A.Fields.SubProduct exposing (currency_and_coin)
import Regulation.US.LCR.Rules exposing (RuleBalance)



{-| Given a list of Assets, applies the applicable rule for each assets along with the relevant amount
-}
toRuleBalances : List Assets -> List RuleBalance
toRuleBalances assetsList =
    -- temp: remove after demo
    assetsList
        |> List.map
            (\asset ->
                { rule =
                    if rule_20_a_1_C asset /= Nothing then
                        "20(a)(1)-C"

                    else if rule_20_a_1 asset  /= Nothing then
                        "20(a)(1)"

                    else if rule_20_b_1 asset  /= Nothing then
                        "20(b)(1)"

                    else if rule_20_c_1 asset /= Nothing then
                        "20(c)(1)"

                    else if rule_33_d_1 asset /= Nothing then
                        "33(d)(1)"

                    else
                        ""
                , amount =
                    asset.marketValue
                }
            )
        |> List.filter (\rb -> rb.rule /= "")

apply_rules : List Assets -> Float
apply_rules list =
    list
        |> List.map
            (\asset ->
                [ rule_20_a_1_C asset
                , rule_20_a_1 asset
                , rule_20_b_1 asset
                , rule_20_c_1 asset
                , rule_33_d_1 asset
                ]
                    |> List.filterMap identity
                    |> List.sum
            )
        |> List.sum


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
rule_20_a_1_C : Assets -> Maybe Float
rule_20_a_1_C flow =
    if
        List.member flow.product [ i_A_3 ]
            -- Sub-Product: Not Currency and Coin
            --&& (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
            && (flow.subProduct /= Just currency_and_coin)
            ---- Maturity Bucket: Open
            && MaturityBucket.isOpen flow.maturityBucket
            ---- Collateral Class: A-0-Q
            && CollateralClass.isCash flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Encumbrance Type: Null
            && (flow.encumbranceType == Nothing)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just flow.marketValue

    else
        Nothing


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
rule_20_a_1 : Assets -> Maybe Float
rule_20_a_1 flow =
    if
        List.member flow.product [ i_A_1, i_A_2 ]
            -- Sub-Product: Not Currency and Coin
            --&& (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
            && (flow.subProduct /= Just currency_and_coin)
            ---- Collateral Class: A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q
            && (CollateralClass.isHQLALevel1 flow.collateralClass && not (CollateralClass.isCash flow.collateralClass))
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Encumbrance Type: Null
            && (flow.encumbranceType == Nothing)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just flow.marketValue

    else
        Nothing


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
rule_20_b_1 : Assets -> Maybe Float
rule_20_b_1 flow =
    if
        List.member flow.product [ i_A_1, i_A_2 ]
            -- Sub-Product: Not Currency and Coin
            --&& (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
            && (flow.subProduct /= Just currency_and_coin)
            ---- Collateral Class: G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q
            && CollateralClass.isHQLALevel2A flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Encumbrance Type: Null
            && (flow.encumbranceType == Nothing)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just flow.marketValue

    else
        Nothing


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
rule_20_c_1 : Assets -> Maybe Float
rule_20_c_1 flow =
    if
        List.member flow.product [ i_A_1, i_A_2 ]
            -- Sub-Product: Not Currency and Coin
            --&& (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
            && (flow.subProduct /= Just currency_and_coin)
            ---- Collateral Class: E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
            && CollateralClass.isHQLALevel2B flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Encumbrance Type: Null
            && (flow.encumbranceType == Nothing)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just flow.marketValue

    else
        Nothing


{-| (107) Financial and Central Bank Cash Inflow Amount (§.33(d)(1))
-}
rule_33_d_1 : Assets -> Maybe Float
rule_33_d_1 flow =
    if
        List.member flow.product [ i_A_3 ]
            -- Maturity Bucket: <= 30 calendar days but not Open
            && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket && flow.maturityBucket /= MaturityBucket.open)
            ---- Collateral Class: A-0-Q
            && CollateralClass.isCash flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just flow.marketValue

    else
        Nothing
