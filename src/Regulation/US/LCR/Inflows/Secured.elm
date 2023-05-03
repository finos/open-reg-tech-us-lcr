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


module Regulation.US.LCR.Inflows.Secured exposing (..)

import Regulation.US.FR2052A.DataTables.Inflows.Secured exposing (..)
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket exposing (FromDate)
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct
import Regulation.US.LCR.Rule exposing (applyRule)
import Regulation.US.LCR.Rules exposing (RuleBalance, orElse)


{-| Given a list of Secured, applies the applicable rule for each assets along with the relevant amount
-}
toRuleBalances : FromDate -> List Secured -> List RuleBalance
toRuleBalances fromDate list =
    list
        |> List.filterMap
            (\flow ->
                rule_2_section_20_a_1 flow
                    |> orElse (rule_2_section_20_b_1 flow)
                    |> orElse (rule_2_section_20_c_1 flow)
                    |> orElse (rule_7_section_21_a_todo fromDate flow)
                    |> orElse (rule_9_section_21_c_todo fromDate flow)
                    |> orElse (rule_85_section_32_j_3_i fromDate flow)
                    |> orElse (rule_86_section_32_j_3_ii fromDate flow)
                    |> orElse (rule_87_section_32_j_3_iii fromDate flow)
                    |> orElse (rule_88_section_32_j_3_iv fromDate flow)
                    |> orElse (rule_89_section_32_j_3_v fromDate flow)
                    |> orElse (rule_90_section_32_j_3_vi fromDate flow)
                    |> orElse (rule_91_section_32_j_3_vii fromDate flow)
                    |> orElse (rule_92_section_32_j_3_viii fromDate flow)
                    |> orElse (rule_93_section_32_j_3_ix fromDate flow)
                    |> orElse (rule_94_section_32_j_3_x fromDate flow)
                    |> orElse (rule_95_section_32_j_3_xi fromDate flow)
                    |> orElse (rule_96_section_32_j_3_xii fromDate flow)
                    |> orElse (rule_97_section_32_j_3_xiii fromDate flow)
                    |> orElse (rule_105_section_33_c fromDate flow)
                    |> orElse (rule_108_section_33_d_1 fromDate flow)
                    |> orElse (rule_110_section_33_d_2 fromDate flow)
                    |> orElse (rule_113_section_33_f_1_i fromDate flow)
                    |> orElse (rule_114_section_33_f_1_ii fromDate flow)
                    |> orElse (rule_115_section_33_f_1_ii fromDate flow)
                    |> orElse (rule_116_section_33_f_1_ii fromDate flow)
                    |> orElse (rule_117_section_33_f_1_iii fromDate flow)
                    |> orElse (rule_118_section_33_f_1_iii fromDate flow)
                    |> orElse (rule_119_section_33_f_1_iv fromDate flow)
                    |> orElse (rule_120_section_33_f_1_iv fromDate flow)
                    |> orElse (rule_121_section_33_f_1_v fromDate flow)
                    |> orElse (rule_122_section_33_f_1_v fromDate flow)
                    |> orElse (rule_123_section_33_f_1_vi fromDate flow)
                    |> orElse (rule_124_section_33_f_1_vii fromDate flow)
                    |> orElse (rule_125_section_33_f_2_i fromDate flow)
                    |> orElse (rule_126_section_33_f_2_ii fromDate flow)
                    |> orElse (rule_127_section_33_f_2_iii fromDate flow)
                    |> orElse (rule_128_section_33_f_2_iv fromDate flow)
                    |> orElse (rule_129_section_33_f_2_v fromDate flow)
                    |> orElse (rule_130_section_33_f_2_vi fromDate flow)
                    |> orElse (rule_131_section_33_f_2_vii fromDate flow)
                    |> orElse (rule_132_section_33_f_2_viii fromDate flow)
                    |> orElse (rule_133_section_33_f_2_ix fromDate flow)
                    |> orElse (rule_134_section_33_f_2_x fromDate flow)
            )


{-| (2) Rehypothecatable Collateral (Subpart C, §.20-.22)
-}
rule_2_section_20_a_1 : Secured -> Maybe RuleBalance
rule_2_section_20_a_1 flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_4, i_S_5, i_S_6 ]
            -- Effective Maturity Bucket: NULL
            && (flow.effectiveMaturityBucket == Nothing)
            -- Collateral Class: A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q
            && (CollateralClass.isHQLALevel1 flow.collateralClass && not (CollateralClass.isCash flow.collateralClass))
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Unencumbered: Y
            && (flow.unencumbered == True)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just (RuleBalance "20(a)(1)" flow.collateralValue)

    else
        Nothing


{-| (2) Rehypothecatable Collateral (Subpart C, §.20-.22)
-}
rule_2_section_20_b_1 : Secured -> Maybe RuleBalance
rule_2_section_20_b_1 flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_4, i_S_5, i_S_6 ]
            -- Effective Maturity Bucket: NULL
            && (flow.effectiveMaturityBucket == Nothing)
            -- Collateral Class: G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q
            && CollateralClass.isHQLALevel2A flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Unencumbered: Y
            && (flow.unencumbered == True)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just (RuleBalance "20(b)(1)" flow.collateralValue)

    else
        Nothing


{-| (2) Rehypothecatable Collateral (Subpart C, §.20-.22)
-}
rule_2_section_20_c_1 : Secured -> Maybe RuleBalance
rule_2_section_20_c_1 flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_4, i_S_5, i_S_6 ]
            -- Effective Maturity Bucket: NULL
            && (flow.effectiveMaturityBucket == Nothing)
            -- Collateral Class: E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
            && CollateralClass.isHQLALevel2B flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Unencumbered: Y
            && (flow.unencumbered == True)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just (RuleBalance "20(c)(1)" flow.maturityAmount)

    else
        Nothing


{-| (7) Secured Lending Unwind (Subpart C, §.21)
-}
rule_7_section_21_a_todo : FromDate -> Secured -> Maybe RuleBalance
rule_7_section_21_a_todo fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_4, i_S_5, i_S_6 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL or <= 30 calendar days, but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: A-0-Q; A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q; G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q; E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
            && CollateralClass.isHQLA flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Unencumbered: Y if Effective Maturity Bucket is NULL, otherwise #
            && (flow.unencumbered == True || flow.effectiveMaturityBucket /= Nothing)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just (RuleBalance "20(b)(todo)" flow.maturityAmount)

    else
        Nothing


{-| (9) Asset Exchange Unwind (Subpart C, §.21)
-}
rule_9_section_21_c_todo : FromDate -> Secured -> Maybe RuleBalance
rule_9_section_21_c_todo fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 1 HQLA, Level 2A HQLA, and Level 2B HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLA subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL or <= 30 calendar days, but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: A-0-Q; A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q; G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q; E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
            && CollateralClass.isHQLA flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Unencumbered: Y if Effective Maturity Bucket is NULL, otherwise #
            && (flow.unencumbered == True || flow.effectiveMaturityBucket /= Nothing)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just (RuleBalance "20(c)(todo)" flow.maturityAmount)

    else
        Nothing


{-| (85) Asset Exchange Post L1 Receive L1 (§.32(j)(3)(i))
-}
rule_85_section_32_j_3_i : FromDate -> Secured -> Maybe RuleBalance
rule_85_section_32_j_3_i fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 1 HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 1 HQLA
            && CollateralClass.isHQLALevel1 flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(i)" flow.collateralValue)

    else
        Nothing


{-| (86) Asset Exchange Post L1 Receive L2A (§.32(j)(3)(ii))
-}
rule_86_section_32_j_3_ii : FromDate -> Secured -> Maybe RuleBalance
rule_86_section_32_j_3_ii fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 2A HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2A subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 1 HQLA
            && CollateralClass.isHQLALevel1 flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(ii)" flow.collateralValue)

    else
        Nothing


{-| (87) Asset Exchange Post L1 Receive L2B (§.32(j)(3)(iii))
-}
rule_87_section_32_j_3_iii : FromDate -> Secured -> Maybe RuleBalance
rule_87_section_32_j_3_iii fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 2B HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2B subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 1 HQLA
            && CollateralClass.isHQLALevel1 flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(iii)" flow.collateralValue)

    else
        Nothing


{-| (88) Asset Exchange Post L1 Receive Non-HQLA (§.32(j)(3)(iv))
-}
rule_88_section_32_j_3_iv : FromDate -> Secured -> Maybe RuleBalance
rule_88_section_32_j_3_iv fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Non-HQLA or No Collateral Pledged
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isNonHQLA subProduct || SubProduct.isNoCollateralPledged subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 1 HQLA
            && CollateralClass.isHQLALevel1 flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(iv)" flow.collateralValue)

    else
        Nothing


{-| (89) Asset Exchange Post L2A Receive L1 or L2A (§.32(j)(3)(v))
-}
rule_89_section_32_j_3_v : FromDate -> Secured -> Maybe RuleBalance
rule_89_section_32_j_3_v fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 1 HQLA or level 2A HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLA subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2A HQLA
            && CollateralClass.isHQLALevel2A flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(v)" flow.collateralValue)

    else
        Nothing


{-| (90) Asset Exchange Post L2A Receive L2B (§.32(j)(3)(vi))
-}
rule_90_section_32_j_3_vi : FromDate -> Secured -> Maybe RuleBalance
rule_90_section_32_j_3_vi fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 2B HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2B subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2A HQLA
            && CollateralClass.isHQLALevel2A flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(vi)" flow.collateralValue)

    else
        Nothing


{-| (91) Asset Exchange Post L2A Receive Non-HQLA (§.32(j)(3)(vii))
-}
rule_91_section_32_j_3_vii : FromDate -> Secured -> Maybe RuleBalance
rule_91_section_32_j_3_vii fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Non-HQLA or No Collateral Pledged
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isNonHQLA subProduct || SubProduct.isNoCollateralPledged subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2A HQLA
            && CollateralClass.isHQLALevel2A flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(vii)" flow.collateralValue)

    else
        Nothing


{-| (92) Asset Exchange Post L2B Receive L1, L2A or L2B (§.32(j)(3)(viii))
-}
rule_92_section_32_j_3_viii : FromDate -> Secured -> Maybe RuleBalance
rule_92_section_32_j_3_viii fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLA subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2B HQLA
            && CollateralClass.isHQLALevel2B flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(viii)" flow.collateralValue)

    else
        Nothing


{-| (93) Asset Exchange Post L2B Receive Non-HQLA (§.32(j)(3)(ix))
-}
rule_93_section_32_j_3_ix : FromDate -> Secured -> Maybe RuleBalance
rule_93_section_32_j_3_ix fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Non-HQLA or No Collateral Pledged
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isNonHQLA subProduct || SubProduct.isNoCollateralPledged subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2B HQLA
            && CollateralClass.isHQLALevel2B flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(ix)" flow.collateralValue)

    else
        Nothing


{-| (94) Asset Exchange Post Rehypothecated Assets >30 days Receive L1 (§.32(j)(3)(x))
-}
rule_94_section_32_j_3_x : FromDate -> Secured -> Maybe RuleBalance
rule_94_section_32_j_3_x fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 1 HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: > 30 calendar days or Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        False

                    Just bucket ->
                        MaturityBucket.isGreaterThan30Days fromDate bucket
                            || MaturityBucket.isOpen bucket
               )
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(x)" flow.maturityAmount)

    else
        Nothing


{-| (95) Asset Exchange Post Rehypothecated Assets >30 days Receive L2A (§.32(j)(3)(xi))
-}
rule_95_section_32_j_3_xi : FromDate -> Secured -> Maybe RuleBalance
rule_95_section_32_j_3_xi fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 2A HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2A subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: > 30 calendar days or Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        False

                    Just bucket ->
                        MaturityBucket.isGreaterThan30Days fromDate bucket
                            || MaturityBucket.isOpen bucket
               )
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(xi)" flow.maturityAmount)

    else
        Nothing


{-| (96) Asset Exchange Post Rehypothecated Assets >30 days Receive L2B (§.32(j)(3)(xii))
-}
rule_96_section_32_j_3_xii : FromDate -> Secured -> Maybe RuleBalance
rule_96_section_32_j_3_xii fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 2B HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2B subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: > 30 calendar days or Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        False

                    Just bucket ->
                        MaturityBucket.isGreaterThan30Days fromDate bucket
                            || MaturityBucket.isOpen bucket
               )
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(xii)" flow.maturityAmount)

    else
        Nothing


{-| (97) Asset Exchange Post Rehypothecated Assets >30 days Receive Non-HQLA (§.32(j)(3)(xiii))
-}
rule_97_section_32_j_3_xiii : FromDate -> Secured -> Maybe RuleBalance
rule_97_section_32_j_3_xiii fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Non-HQLA or No Collateral Pledged
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isNonHQLA subProduct || SubProduct.isNoCollateralPledged subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: > 30 calendar days or Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        False

                    Just bucket ->
                        MaturityBucket.isGreaterThan30Days fromDate bucket
                            || MaturityBucket.isOpen bucket
               )
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(3)(iii)" flow.maturityAmount)

    else
        Nothing


{-| (105) Retail Cash Inflow Amount (§.33(c))
-}
rule_105_section_33_c : FromDate -> Secured -> Maybe RuleBalance
rule_105_section_33_c fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_5, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days but not Open
            && (MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket && flow.maturityBucket /= MaturityBucket.Open)
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(c)" flow.maturityAmount)

    else
        Nothing


{-| (108) Financial and Central Bank Cash Inflow Amount (§.33(d)(1))
-}
rule_108_section_33_d_1 : FromDate -> Secured -> Maybe RuleBalance
rule_108_section_33_d_1 fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Collateral Class: Other
            && CollateralClass.isOther flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(d)(1)" flow.maturityAmount)

    else
        Nothing


{-| (110) Non-Financial Wholesale Cash Inflow Amount (§.33(d)(2))
-}
rule_110_section_33_d_2 : FromDate -> Secured -> Maybe RuleBalance
rule_110_section_33_d_2 fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Collateral Class: Other
            && CollateralClass.isOther flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(d)(2)" flow.maturityAmount)

    else
        Nothing


{-| (113) Secured Lending when Asset Rehypothecated not returned within 30 days (§.33(f)(1)(i))
-}
rule_113_section_33_f_1_i : FromDate -> Secured -> Maybe RuleBalance
rule_113_section_33_f_1_i fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: > 30 calendar days or Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        False

                    Just bucket ->
                        MaturityBucket.isGreaterThan30Days fromDate bucket
                            || MaturityBucket.isOpen bucket
               )
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Unencumbered: N
            && (flow.unencumbered == False)
    then
        Just (RuleBalance "33(f)(1)(i)" flow.maturityAmount)

    else
        Nothing


{-| (114) Secured Lending when Asset Available for Return (§.33(f)(1)(ii))
-}
rule_114_section_33_f_1_ii : FromDate -> Secured -> Maybe RuleBalance
rule_114_section_33_f_1_ii fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL
            && (flow.effectiveMaturityBucket == Nothing)
            -- Collateral Class: Non-HQLA
            && not (CollateralClass.isHQLA flow.collateralClass)
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(1)(ii)" flow.maturityAmount)

    else
        Nothing


{-| (115) Secured Lending when Asset Available for Return (§.33(f)(1)(ii))
-}
rule_115_section_33_f_1_ii : FromDate -> Secured -> Maybe RuleBalance
rule_115_section_33_f_1_ii fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL
            && (flow.effectiveMaturityBucket == Nothing)
            -- Collateral Class: HQLA
            && CollateralClass.isHQLA flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Unencumbered: N
            && (flow.unencumbered == False)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just (RuleBalance "33(f)(1)(ii)" flow.maturityAmount)

    else
        Nothing


{-| (116) Secured Lending when Asset Available for Return (§.33(f)(1)(ii))
-}
rule_116_section_33_f_1_ii : FromDate -> Secured -> Maybe RuleBalance
rule_116_section_33_f_1_ii fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL
            && (flow.effectiveMaturityBucket == Nothing)
            -- Collateral Class: HQLA
            && CollateralClass.isHQLA flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Treasury Control: N
            && (flow.treasuryControl == False)
    then
        Just (RuleBalance "33(f)(1)(ii)" flow.maturityAmount)

    else
        Nothing


{-| (117) Secured Lending with L1 HQLA (§.33(f)(1)(iii))
-}
rule_117_section_33_f_1_iii : FromDate -> Secured -> Maybe RuleBalance
rule_117_section_33_f_1_iii fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        False

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 1 HQLA
            && CollateralClass.isHQLALevel1 flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(1)(iii)" flow.maturityAmount)

    else
        Nothing


{-| (118) Secured Lending with L1 HQLA (§.33(f)(1)(iii))
-}
rule_118_section_33_f_1_iii : FromDate -> Secured -> Maybe RuleBalance
rule_118_section_33_f_1_iii fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL
            && (flow.effectiveMaturityBucket == Nothing)
            -- Collateral Class: Level 1 HQLA
            && CollateralClass.isHQLALevel1 flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Unencumbered: Y
            && (flow.unencumbered == True)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just (RuleBalance "33(f)(1)(iii)" flow.maturityAmount)

    else
        Nothing


{-| (119) Secured Lending with L2A HQLA (§.33(f)(1)(iv))
-}
rule_119_section_33_f_1_iv : FromDate -> Secured -> Maybe RuleBalance
rule_119_section_33_f_1_iv fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        False

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2A HQLA
            && CollateralClass.isHQLALevel2A flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(1)(iv)" flow.maturityAmount)

    else
        Nothing


{-| (120) Secured Lending with L2A HQLA (§.33(f)(1)(iv))
-}
rule_120_section_33_f_1_iv : FromDate -> Secured -> Maybe RuleBalance
rule_120_section_33_f_1_iv fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL
            && (flow.effectiveMaturityBucket == Nothing)
            -- Collateral Class: Level 2A HQLA
            && CollateralClass.isHQLALevel2A flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Unencumbered: Y
            && (flow.unencumbered == True)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just (RuleBalance "33(f)(1)(iv)" flow.maturityAmount)

    else
        Nothing


{-| (121) Secured Lending with L2B HQLA (§.33(f)(1)(v))
-}
rule_121_section_33_f_1_v : FromDate -> Secured -> Maybe RuleBalance
rule_121_section_33_f_1_v fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        False

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2B HQLA
            && CollateralClass.isHQLALevel2B flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(1)(v)" flow.maturityAmount)

    else
        Nothing


{-| (122) Secured Lending with L2B HQLA (§.33(f)(1)(v))
-}
rule_122_section_33_f_1_v : FromDate -> Secured -> Maybe RuleBalance
rule_122_section_33_f_1_v fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: NULL
            && (flow.effectiveMaturityBucket == Nothing)
            -- Collateral Class: Level 2B HQLA
            && CollateralClass.isHQLALevel2B flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
            -- Unencumbered: Y
            && (flow.unencumbered == True)
            -- Treasury Control: Y
            && (flow.treasuryControl == True)
    then
        Just (RuleBalance "33(f)(1)(v)" flow.maturityAmount)

    else
        Nothing


{-| (123) Secured Lending with Non-HQLA (§.33(f)(1)(vi))
-}
rule_123_section_33_f_1_vi : FromDate -> Secured -> Maybe RuleBalance
rule_123_section_33_f_1_vi fromDate flow =
    if
        List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_6, i_S_7, i_S_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        False

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Non-HQLA
            && not (CollateralClass.isHQLA flow.collateralClass)
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(1)(vi)" flow.maturityAmount)

    else
        Nothing


{-| (124) Margin Loans for Non-HQLA (§.33(f)(1)(vii))
-}
rule_124_section_33_f_1_vii : FromDate -> Secured -> Maybe RuleBalance
rule_124_section_33_f_1_vii fromDate flow =
    if
        List.member flow.product [ i_S_5 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Non-HQLA
            && not (CollateralClass.isHQLA flow.collateralClass)
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(1)(vii)" flow.maturityAmount)

    else
        Nothing


{-| (125) Asset Exchange Collateral Rehypothecated and Not Returning within 30 days (§.33(f)(2)(i))
-}
rule_125_section_33_f_2_i : FromDate -> Secured -> Maybe RuleBalance
rule_125_section_33_f_2_i fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: > 30 calendar days or Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        False

                    Just bucket ->
                        MaturityBucket.isGreaterThan30Days fromDate bucket
                            || MaturityBucket.isOpen bucket
               )
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(2)(i)" flow.maturityAmount)

    else
        Nothing


{-| (126) Asset Exchange Post L1 Receive L1 (§.33(f)(2)(ii))
-}
rule_126_section_33_f_2_ii : FromDate -> Secured -> Maybe RuleBalance
rule_126_section_33_f_2_ii fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 1 HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 1 HQLA
            && CollateralClass.isHQLALevel1 flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(2)(ii)" flow.maturityAmount)

    else
        Nothing


{-| (127) Asset Exchange Post L2A Receive L1 (§.33(f)(2)(iii))
-}
rule_127_section_33_f_2_iii : FromDate -> Secured -> Maybe RuleBalance
rule_127_section_33_f_2_iii fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 1 HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2A HQLA
            && CollateralClass.isHQLALevel2A flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(2)(iii)" flow.maturityAmount)

    else
        Nothing


{-| (128) Asset Exchange Post L2B Receive L1 (§.33(f)(2)(iv))
-}
rule_128_section_33_f_2_iv : FromDate -> Secured -> Maybe RuleBalance
rule_128_section_33_f_2_iv fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 1 HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2B HQLA
            && CollateralClass.isHQLALevel2B flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(2)(iv)" flow.maturityAmount)

    else
        Nothing


{-| (129) Asset Exchange Post Non-HQLA Receive L1 (§.33(f)(2)(v))
-}
rule_129_section_33_f_2_v : FromDate -> Secured -> Maybe RuleBalance
rule_129_section_33_f_2_v fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 1 HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Non-HQLA or Other
            && (not (CollateralClass.isHQLA flow.collateralClass) || CollateralClass.isOther flow.collateralClass)
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(2)(v)" flow.maturityAmount)

    else
        Nothing


{-| (130) Asset Exchange Post L2A Receive L2A (§.33(f)(2)(vi))
-}
rule_130_section_33_f_2_vi : FromDate -> Secured -> Maybe RuleBalance
rule_130_section_33_f_2_vi fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 2A HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2A subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2A HQLA
            && CollateralClass.isHQLALevel2A flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(2)(vi)" flow.maturityAmount)

    else
        Nothing


{-| (131) Asset Exchange Post L2B Receive L2A (§.33(f)(2)(vii))
-}
rule_131_section_33_f_2_vii : FromDate -> Secured -> Maybe RuleBalance
rule_131_section_33_f_2_vii fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 2A HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2A subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2B HQLA
            && CollateralClass.isHQLALevel2B flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(2)(vii)" flow.maturityAmount)

    else
        Nothing


{-| (132) Asset Exchange Post Non-HQLA Receive L2A (§.33(f)(2)(viii))
-}
rule_132_section_33_f_2_viii : FromDate -> Secured -> Maybe RuleBalance
rule_132_section_33_f_2_viii fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 2A HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2A subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Non-HQLA or Other
            && (not (CollateralClass.isHQLA flow.collateralClass) || CollateralClass.isOther flow.collateralClass)
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(2)(viii)" flow.maturityAmount)

    else
        Nothing


{-| (133) Asset Exchange Post L2B Receive L2B (§.33(f)(2)(ix))
-}
rule_133_section_33_f_2_ix : FromDate -> Secured -> Maybe RuleBalance
rule_133_section_33_f_2_ix fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 2B HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2B subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Level 2B HQLA
            && CollateralClass.isHQLALevel2B flow.collateralClass
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(2)(ix)" flow.maturityAmount)

    else
        Nothing


{-| (134) Asset Exchange Post Non-HQLA Receive L2B (§.33(f)(2)(x))
-}
rule_134_section_33_f_2_x : FromDate -> Secured -> Maybe RuleBalance
rule_134_section_33_f_2_x fromDate flow =
    if
        List.member flow.product [ i_S_4 ]
            -- Sub-Product: Level 2B HQLA
            && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2B subProduct) |> Maybe.withDefault False)
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
            && (case flow.effectiveMaturityBucket of
                    Nothing ->
                        True

                    Just bucket ->
                        MaturityBucket.isLessThanOrEqual30Days fromDate bucket
                            && not (MaturityBucket.isOpen bucket)
               )
            -- Collateral Class: Non-HQLA or Other
            && (not (CollateralClass.isHQLA flow.collateralClass) || CollateralClass.isOther flow.collateralClass)
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(f)(2)(x)" flow.maturityAmount)

    else
        Nothing
