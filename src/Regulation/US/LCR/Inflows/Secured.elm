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
import Regulation.US.FR2052A.Fields.Insured as Insured
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct
import Regulation.US.LCR.AmountCalculations exposing (..)
import Regulation.US.LCR.Rule exposing (applyRule)


applyRules : Secured -> List ( String, Float )
applyRules flow =
    List.concat
        [ applyRule (match_rule_2_section_20_a_1 flow) "20(a)(1)" flow.collateralValue
        , applyRule (match_rule_2_section_20_b_1 flow) "20(b)(1)" flow.collateralValue
        , applyRule (match_rule_2_section_20_c_1 flow) "20(c)(1)" flow.collateralValue
        , applyRule (match_rule_7_section_21_a_todo flow) "21(a)(todo)" flow.maturityAmount
        , applyRule (match_rule_9_section_21_c_todo flow) "21(c)(todo)" flow.maturityAmount
        , applyRule (match_rule_85_section_32_j_3_i flow) "32(j)(3)(i)" flow.collateralValue
        , applyRule (match_rule_86_section_32_j_3_ii flow) "32(j)(3)(ii)" flow.collateralValue
        , applyRule (match_rule_87_section_32_j_3_iii flow) "32(j)(3)(iii)" flow.collateralValue
        , applyRule (match_rule_88_section_32_j_3_iv flow) "32(j)(3)(iv)" flow.collateralValue
        , applyRule (match_rule_89_section_32_j_3_v flow) "32(j)(3)(v)" flow.collateralValue
        , applyRule (match_rule_90_section_32_j_3_vi flow) "32(j)(3)(vi)" flow.collateralValue
        , applyRule (match_rule_91_section_32_j_3_vii flow) "32(j)(3)(vii)" flow.collateralValue
        , applyRule (match_rule_92_section_32_j_3_viii flow) "32(j)(3)(viii)" flow.collateralValue
        , applyRule (match_rule_93_section_32_j_3_ix flow) "32(j)(3)(ix)" flow.collateralValue
        , applyRule (match_rule_94_section_32_j_3_x flow) "32(j)(3)(x)" flow.maturityAmount
        , applyRule (match_rule_95_section_32_j_3_xi flow) "32(j)(3)(xi)" flow.maturityAmount
        , applyRule (match_rule_96_section_32_j_3_xii flow) "32(j)(3)(xii)" flow.maturityAmount
        , applyRule (match_rule_97_section_32_j_3_xiii flow) "32(j)(3)(xiii)" flow.maturityAmount
        , applyRule (match_rule_105_section_33_c flow) "33(c)" flow.maturityAmount
        , applyRule (match_rule_108_section_33_d_1 flow) "33(d)(1)" flow.maturityAmount
        , applyRule (match_rule_110_section_33_d_2 flow) "33(d)(2)" flow.maturityAmount
        , applyRule (match_rule_113_section_33_f_1_i flow) "33(f)(1)(i)" flow.maturityAmount
        , applyRule (match_rule_114_section_33_f_1_ii flow) "33(f)(1)(ii)" flow.maturityAmount
        , applyRule (match_rule_115_section_33_f_1_ii flow) "33(f)(1)(ii)" flow.maturityAmount
        , applyRule (match_rule_116_section_33_f_1_ii flow) "33(f)(1)(ii)" flow.maturityAmount
        , applyRule (match_rule_117_section_33_f_1_iii flow) "33(f)(1)(iii)" flow.maturityAmount
        , applyRule (match_rule_118_section_33_f_1_iii flow) "33(f)(1)(iii)" flow.maturityAmount
        , applyRule (match_rule_119_section_33_f_1_iv flow) "33(f)(1)(iv)" flow.maturityAmount
        , applyRule (match_rule_120_section_33_f_1_iv flow) "33(f)(1)(iv)" flow.maturityAmount
        , applyRule (match_rule_121_section_33_f_1_v flow) "33(f)(1)(v)" flow.maturityAmount
        , applyRule (match_rule_122_section_33_f_1_v flow) "33(f)(1)(v)" flow.maturityAmount
        , applyRule (match_rule_123_section_33_f_1_vi flow) "33(f)(1)(vi)" flow.maturityAmount
        , applyRule (match_rule_124_section_33_f_1_vii flow) "33(f)(1)(vii)" flow.maturityAmount
        , applyRule (match_rule_125_section_33_f_2_i flow) "33(f)(2)(i)" flow.maturityAmount
        , applyRule (match_rule_126_section_33_f_2_ii flow) "33(f)(2)(ii)" flow.maturityAmount
        , applyRule (match_rule_127_section_33_f_2_iii flow) "33(f)(2)(iii)" flow.maturityAmount
        , applyRule (match_rule_128_section_33_f_2_iv flow) "33(f)(2)(iv)" flow.maturityAmount
        , applyRule (match_rule_129_section_33_f_2_v flow) "33(f)(2)(v)" flow.maturityAmount
        , applyRule (match_rule_130_section_33_f_2_vi flow) "33(f)(2)(vi)" flow.maturityAmount
        , applyRule (match_rule_131_section_33_f_2_vii flow) "33(f)(2)(vii)" flow.maturityAmount
        , applyRule (match_rule_132_section_33_f_2_viii flow) "33(f)(2)(viii)" flow.maturityAmount
        , applyRule (match_rule_133_section_33_f_2_ix flow) "33(f)(2)(ix)" flow.maturityAmount
        , applyRule (match_rule_134_section_33_f_2_x flow) "33(f)(2)(x)" flow.maturityAmount
        ]


{-| (2) Rehypothecatable Collateral (Subpart C, §.20-.22)
-}
match_rule_2_section_20_a_1 : Secured -> Bool
match_rule_2_section_20_a_1 flow =
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


{-| (2) Rehypothecatable Collateral (Subpart C, §.20-.22)
-}
match_rule_2_section_20_b_1 : Secured -> Bool
match_rule_2_section_20_b_1 flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_4, i_S_5, i_S_6 ]
    -- Effective Maturity Bucket: NULL
    && (flow.effectiveMaturityBucket == Nothing)
    -- Collateral Class: G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q
    && (CollateralClass.isHQLALevel2A flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Unencumbered: Y
    && (flow.unencumbered == True)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (2) Rehypothecatable Collateral (Subpart C, §.20-.22)
-}
match_rule_2_section_20_c_1 : Secured -> Bool
match_rule_2_section_20_c_1 flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_4, i_S_5, i_S_6 ]
    -- Effective Maturity Bucket: NULL
    && (flow.effectiveMaturityBucket == Nothing)
    -- Collateral Class: E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
    && (CollateralClass.isHQLALevel2B flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Unencumbered: Y
    && (flow.unencumbered == True)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (7) Secured Lending Unwind (Subpart C, §.21)
-}
match_rule_7_section_21_a_todo : Secured -> Bool
match_rule_7_section_21_a_todo flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_4, i_S_5, i_S_6 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL or <= 30 calendar days, but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: A-0-Q; A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q; G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q; E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
    && (CollateralClass.isHQLA flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Unencumbered: Y if Effective Maturity Bucket is NULL, otherwise #
    && (flow.unencumbered == True || flow.effectiveMaturityBucket /= Nothing)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (9) Asset Exchange Unwind (Subpart C, §.21)
-}
match_rule_9_section_21_c_todo : Secured -> Bool
match_rule_9_section_21_c_todo flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 1 HQLA, Level 2A HQLA, and Level 2B HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLA subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL or <= 30 calendar days, but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: A-0-Q; A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q; G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q; E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
    && (CollateralClass.isHQLA flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Unencumbered: Y if Effective Maturity Bucket is NULL, otherwise #
    && (flow.unencumbered == True || flow.effectiveMaturityBucket /= Nothing)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (85) Asset Exchange Post L1 Receive L1 (§.32(j)(3)(i))
-}
match_rule_85_section_32_j_3_i : Secured -> Bool
match_rule_85_section_32_j_3_i flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 1 HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 1 HQLA
    && (CollateralClass.isHQLALevel1 flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (86) Asset Exchange Post L1 Receive L2A (§.32(j)(3)(ii))
-}
match_rule_86_section_32_j_3_ii : Secured -> Bool
match_rule_86_section_32_j_3_ii flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 2A HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2A subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 1 HQLA
    && (CollateralClass.isHQLALevel1 flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (87) Asset Exchange Post L1 Receive L2B (§.32(j)(3)(iii))
-}
match_rule_87_section_32_j_3_iii : Secured -> Bool
match_rule_87_section_32_j_3_iii flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 2B HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2B subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 1 HQLA
    && (CollateralClass.isHQLALevel1 flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (88) Asset Exchange Post L1 Receive Non-HQLA (§.32(j)(3)(iv))
-}
match_rule_88_section_32_j_3_iv : Secured -> Bool
match_rule_88_section_32_j_3_iv flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Non-HQLA or No Collateral Pledged
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isNonHQLA subProduct || SubProduct.isNoCollateralPledged subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 1 HQLA
    && (CollateralClass.isHQLALevel1 flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (89) Asset Exchange Post L2A Receive L1 or L2A (§.32(j)(3)(v))
-}
match_rule_89_section_32_j_3_v : Secured -> Bool
match_rule_89_section_32_j_3_v flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 1 HQLA or level 2A HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLA subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2A HQLA
    && (CollateralClass.isHQLALevel2A flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (90) Asset Exchange Post L2A Receive L2B (§.32(j)(3)(vi))
-}
match_rule_90_section_32_j_3_vi : Secured -> Bool
match_rule_90_section_32_j_3_vi flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 2B HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2B subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2A HQLA
    && (CollateralClass.isHQLALevel2A flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (91) Asset Exchange Post L2A Receive Non-HQLA (§.32(j)(3)(vii))
-}
match_rule_91_section_32_j_3_vii : Secured -> Bool
match_rule_91_section_32_j_3_vii flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Non-HQLA or No Collateral Pledged
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isNonHQLA subProduct || SubProduct.isNoCollateralPledged subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2A HQLA
    && (CollateralClass.isHQLALevel2A flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (92) Asset Exchange Post L2B Receive L1, L2A or L2B (§.32(j)(3)(viii))
-}
match_rule_92_section_32_j_3_viii : Secured -> Bool
match_rule_92_section_32_j_3_viii flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLA subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2B HQLA
    && (CollateralClass.isHQLALevel2B flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (93) Asset Exchange Post L2B Receive Non-HQLA (§.32(j)(3)(ix))
-}
match_rule_93_section_32_j_3_ix : Secured -> Bool
match_rule_93_section_32_j_3_ix flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Non-HQLA or No Collateral Pledged
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isNonHQLA subProduct || SubProduct.isNoCollateralPledged subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL or <= 30 calendar days but not open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2B HQLA
    && (CollateralClass.isHQLALevel2B flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (94) Asset Exchange Post Rehypothecated Assets >30 days Receive L1 (§.32(j)(3)(x))
-}
match_rule_94_section_32_j_3_x : Secured -> Bool
match_rule_94_section_32_j_3_x flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 1 HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: > 30 calendar days or Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                False

            Just bucket ->
                MaturityBucket.isGreaterThan30Days bucket
                || MaturityBucket.isOpen bucket
        )
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (95) Asset Exchange Post Rehypothecated Assets >30 days Receive L2A (§.32(j)(3)(xi))
-}
match_rule_95_section_32_j_3_xi : Secured -> Bool
match_rule_95_section_32_j_3_xi flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 2A HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2A subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: > 30 calendar days or Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                False

            Just bucket ->
                MaturityBucket.isGreaterThan30Days bucket
                || MaturityBucket.isOpen bucket
        )
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (96) Asset Exchange Post Rehypothecated Assets >30 days Receive L2B (§.32(j)(3)(xii))
-}
match_rule_96_section_32_j_3_xii : Secured -> Bool
match_rule_96_section_32_j_3_xii flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 2B HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2B subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: > 30 calendar days or Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                False

            Just bucket ->
                MaturityBucket.isGreaterThan30Days bucket
                || MaturityBucket.isOpen bucket
        )
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (97) Asset Exchange Post Rehypothecated Assets >30 days Receive Non-HQLA (§.32(j)(3)(xiii))
-}
match_rule_97_section_32_j_3_xiii : Secured -> Bool
match_rule_97_section_32_j_3_xiii flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Non-HQLA or No Collateral Pledged
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isNonHQLA subProduct || SubProduct.isNoCollateralPledged subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: > 30 calendar days or Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                False

            Just bucket ->
                MaturityBucket.isGreaterThan30Days bucket
                || MaturityBucket.isOpen bucket
        )
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (105) Retail Cash Inflow Amount (§.33(c))
-}
match_rule_105_section_33_c : Secured -> Bool
match_rule_105_section_33_c flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_5, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days but not Open
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket && not (MaturityBucket.isOpen flow.maturityBucket))
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (108) Financial and Central Bank Cash Inflow Amount (§.33(d)(1))
-}
match_rule_108_section_33_d_1 : Secured -> Bool
match_rule_108_section_33_d_1 flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Other
    && (CollateralClass.isOther flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (110) Non-Financial Wholesale Cash Inflow Amount (§.33(d)(2))
-}
match_rule_110_section_33_d_2 : Secured -> Bool
match_rule_110_section_33_d_2 flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Other
    && (CollateralClass.isOther flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (113) Secured Lending when Asset Rehypothecated not returned within 30 days (§.33(f)(1)(i))
-}
match_rule_113_section_33_f_1_i : Secured -> Bool
match_rule_113_section_33_f_1_i flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: > 30 calendar days or Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                False

            Just bucket ->
                MaturityBucket.isGreaterThan30Days bucket
                || MaturityBucket.isOpen bucket
        )
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Unencumbered: N
    && (flow.unencumbered == False)


{-| (114) Secured Lending when Asset Available for Return (§.33(f)(1)(ii))
-}
match_rule_114_section_33_f_1_ii : Secured -> Bool
match_rule_114_section_33_f_1_ii flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL
    && (flow.effectiveMaturityBucket == Nothing)
    -- Collateral Class: Non-HQLA
    && (not (CollateralClass.isHQLA flow.collateralClass))
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (115) Secured Lending when Asset Available for Return (§.33(f)(1)(ii))
-}
match_rule_115_section_33_f_1_ii : Secured -> Bool
match_rule_115_section_33_f_1_ii flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL
    && (flow.effectiveMaturityBucket == Nothing)
    -- Collateral Class: HQLA
    && (CollateralClass.isHQLA flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Unencumbered: N
    && (flow.unencumbered == False)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (116) Secured Lending when Asset Available for Return (§.33(f)(1)(ii))
-}
match_rule_116_section_33_f_1_ii : Secured -> Bool
match_rule_116_section_33_f_1_ii flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL
    && (flow.effectiveMaturityBucket == Nothing)
    -- Collateral Class: HQLA
    && (CollateralClass.isHQLA flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Treasury Control: N
    && (flow.treasuryControl == False)


{-| (117) Secured Lending with L1 HQLA (§.33(f)(1)(iii))
-}
match_rule_117_section_33_f_1_iii : Secured -> Bool
match_rule_117_section_33_f_1_iii flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                False

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 1 HQLA
    && (CollateralClass.isHQLALevel1 flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (118) Secured Lending with L1 HQLA (§.33(f)(1)(iii))
-}
match_rule_118_section_33_f_1_iii : Secured -> Bool
match_rule_118_section_33_f_1_iii flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL
    && (flow.effectiveMaturityBucket == Nothing)
    -- Collateral Class: Level 1 HQLA
    && (CollateralClass.isHQLALevel1 flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Unencumbered: Y
    && (flow.unencumbered == True)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (119) Secured Lending with L2A HQLA (§.33(f)(1)(iv))
-}
match_rule_119_section_33_f_1_iv : Secured -> Bool
match_rule_119_section_33_f_1_iv flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                False

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2A HQLA
    && (CollateralClass.isHQLALevel2A flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (120) Secured Lending with L2A HQLA (§.33(f)(1)(iv))
-}
match_rule_120_section_33_f_1_iv : Secured -> Bool
match_rule_120_section_33_f_1_iv flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL
    && (flow.effectiveMaturityBucket == Nothing)
    -- Collateral Class: Level 2A HQLA
    && (CollateralClass.isHQLALevel2A flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Unencumbered: Y
    && (flow.unencumbered == True)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (121) Secured Lending with L2B HQLA (§.33(f)(1)(v))
-}
match_rule_121_section_33_f_1_v : Secured -> Bool
match_rule_121_section_33_f_1_v flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                False

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2B HQLA
    && (CollateralClass.isHQLALevel2B flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (122) Secured Lending with L2B HQLA (§.33(f)(1)(v))
-}
match_rule_122_section_33_f_1_v : Secured -> Bool
match_rule_122_section_33_f_1_v flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_5, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: NULL
    && (flow.effectiveMaturityBucket == Nothing)
    -- Collateral Class: Level 2B HQLA
    && (CollateralClass.isHQLALevel2B flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Unencumbered: Y
    && (flow.unencumbered == True)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (123) Secured Lending with Non-HQLA (§.33(f)(1)(vi))
-}
match_rule_123_section_33_f_1_vi : Secured -> Bool
match_rule_123_section_33_f_1_vi flow =
    List.member flow.product [ i_S_1, i_S_2, i_S_3, i_S_6, i_S_7, i_S_8 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                False

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Non-HQLA
    && (not (CollateralClass.isHQLA flow.collateralClass))
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (124) Margin Loans for Non-HQLA (§.33(f)(1)(vii))
-}
match_rule_124_section_33_f_1_vii : Secured -> Bool
match_rule_124_section_33_f_1_vii flow =
    List.member flow.product [ i_S_5 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Non-HQLA
    && (not (CollateralClass.isHQLA flow.collateralClass))
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (125) Asset Exchange Collateral Rehypothecated and Not Returning within 30 days (§.33(f)(2)(i))
-}
match_rule_125_section_33_f_2_i : Secured -> Bool
match_rule_125_section_33_f_2_i flow =
    List.member flow.product [ i_S_4 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: > 30 calendar days or Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                False

            Just bucket ->
                MaturityBucket.isGreaterThan30Days bucket
                || MaturityBucket.isOpen bucket
        )
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (126) Asset Exchange Post L1 Receive L1 (§.33(f)(2)(ii))
-}
match_rule_126_section_33_f_2_ii : Secured -> Bool
match_rule_126_section_33_f_2_ii flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 1 HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 1 HQLA
    && (CollateralClass.isHQLALevel1 flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (127) Asset Exchange Post L2A Receive L1 (§.33(f)(2)(iii))
-}
match_rule_127_section_33_f_2_iii : Secured -> Bool
match_rule_127_section_33_f_2_iii flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 1 HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2A HQLA
    && (CollateralClass.isHQLALevel2A flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (128) Asset Exchange Post L2B Receive L1 (§.33(f)(2)(iv))
-}
match_rule_128_section_33_f_2_iv : Secured -> Bool
match_rule_128_section_33_f_2_iv flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 1 HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2B HQLA
    && (CollateralClass.isHQLALevel2B flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (129) Asset Exchange Post Non-HQLA Receive L1 (§.33(f)(2)(v))
-}
match_rule_129_section_33_f_2_v : Secured -> Bool
match_rule_129_section_33_f_2_v flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 1 HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel1 subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Non-HQLA or Other
    && (not (CollateralClass.isHQLA flow.collateralClass) || CollateralClass.isOther flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (130) Asset Exchange Post L2A Receive L2A (§.33(f)(2)(vi))
-}
match_rule_130_section_33_f_2_vi : Secured -> Bool
match_rule_130_section_33_f_2_vi flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 2A HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2A subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2A HQLA
    && (CollateralClass.isHQLALevel2A flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (131) Asset Exchange Post L2B Receive L2A (§.33(f)(2)(vii))
-}
match_rule_131_section_33_f_2_vii : Secured -> Bool
match_rule_131_section_33_f_2_vii flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 2A HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2A subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2B HQLA
    && (CollateralClass.isHQLALevel2B flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (132) Asset Exchange Post Non-HQLA Receive L2A (§.33(f)(2)(viii))
-}
match_rule_132_section_33_f_2_viii : Secured -> Bool
match_rule_132_section_33_f_2_viii flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 2A HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2A subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Non-HQLA or Other
    && (not (CollateralClass.isHQLA flow.collateralClass) || CollateralClass.isOther flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (133) Asset Exchange Post L2B Receive L2B (§.33(f)(2)(ix))
-}
match_rule_133_section_33_f_2_ix : Secured -> Bool
match_rule_133_section_33_f_2_ix flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 2B HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2B subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Level 2B HQLA
    && (CollateralClass.isHQLALevel2B flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (134) Asset Exchange Post Non-HQLA Receive L2B (§.33(f)(2)(x))
-}
match_rule_134_section_33_f_2_x : Secured -> Bool
match_rule_134_section_33_f_2_x flow =
    List.member flow.product [ i_S_4 ]
    -- Sub-Product: Level 2B HQLA
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isHQLALevel2B subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Effective Maturity Bucket: <= 30 calendar days or NULL but not Open
    && (case flow.effectiveMaturityBucket of
            Nothing ->
                True

            Just bucket ->
                MaturityBucket.isLessThanOrEqual30Days bucket
                && not (MaturityBucket.isOpen bucket)
        )
    -- Collateral Class: Non-HQLA or Other
    && (not (CollateralClass.isHQLA flow.collateralClass) || CollateralClass.isOther flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)