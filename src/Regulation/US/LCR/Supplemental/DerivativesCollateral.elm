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


module Regulation.US.LCR.Supplemental.DerivativesCollateral exposing (..)

import Regulation.US.FR2052A.DataTables.Supplemental.DerivativesCollateral exposing (..)
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct
import Regulation.US.LCR.Rule exposing (applyRule)
import Regulation.US.LCR.Rules exposing (RuleBalance)


applyRules : DerivativesCollateral -> List RuleBalance
applyRules flow =
    List.concat
        [ applyRule (match_rule_3_section_20_a_1_C flow) "20(a)(1)C" flow.marketValue
        , applyRule (match_rule_3_section_20_a_1 flow) "20(a)(1)" flow.marketValue
        , applyRule (match_rule_3_section_20_b_1 flow) "20(b)(1)" flow.marketValue
        , applyRule (match_rule_3_section_20_c_1 flow) "20(c)(1)" flow.marketValue
        , applyRule (match_rule_6_section_22_b_5_L1 flow) "22(b)(5)L1" flow.marketValue
        , applyRule (match_rule_6_section_22_b_5_L2a flow) "22(b)(5)L2a" flow.marketValue
        , applyRule (match_rule_6_section_22_b_5_L2b flow) "22(b)(5)L2b" flow.marketValue
        , applyRule (match_rule_33_section_32_f_2 flow) "32(f)(2)" flow.marketValue
        , applyRule (match_rule_35_section_32_f_4 flow) "32(f)(4)" flow.marketValue
        , applyRule (match_rule_36_section_32_f_4 flow) "32(f)(4)" flow.marketValue
        , applyRule (match_rule_37_section_32_f_5 flow) "32(f)(5)" flow.marketValue
        , applyRule (match_rule_38_section_32_f_6 flow) "32(f)(6)" flow.marketValue
        ]


{-| (3) Rehypothecatable Collateral (Subpart C, §.20-.22)
-}
match_rule_3_section_20_a_1_C : DerivativesCollateral -> Bool
match_rule_3_section_20_a_1_C flow =
    List.member flow.product [ s_DC_7, s_DC_10 ]
        -- Sub-Product: Rehypthecatable - Unencumbered
        && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isRehypothecateableCollateralUnencumbered subProduct) |> Maybe.withDefault False)
        -- Collateral Class: A-0-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isCash class) |> Maybe.withDefault False)
        -- Treasury Control: Y
        && (flow.treasuryControl == Just True)


{-| (3) Rehypothecatable Collateral (Subpart C, §.20-.22)
-}
match_rule_3_section_20_a_1 : DerivativesCollateral -> Bool
match_rule_3_section_20_a_1 flow =
    List.member flow.product [ s_DC_7, s_DC_10 ]
        -- Sub-Product: Rehypthecatable - Unencumbered
        && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isRehypothecateableCollateralUnencumbered subProduct) |> Maybe.withDefault False)
        -- Collateral Class: A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q
        -- TODO
        --&& (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel1 class && not (CollateralClass.isCash class)) |> Maybe.withDefault False)
        -- Treasury Control: Y
        && (flow.treasuryControl == Just True)


{-| (3) Rehypothecatable Collateral (Subpart C, §.20-.22)
-}
match_rule_3_section_20_b_1 : DerivativesCollateral -> Bool
match_rule_3_section_20_b_1 flow =
    List.member flow.product [ s_DC_7, s_DC_10 ]
        -- Sub-Product: Rehypthecatable - Unencumbered
        && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isRehypothecateableCollateralUnencumbered subProduct) |> Maybe.withDefault False)
        -- Collateral Class: G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2A class) |> Maybe.withDefault False)
        -- Treasury Control: Y
        && (flow.treasuryControl == Just True)


{-| (3) Rehypothecatable Collateral (Subpart C, §.20-.22)
-}
match_rule_3_section_20_c_1 : DerivativesCollateral -> Bool
match_rule_3_section_20_c_1 flow =
    List.member flow.product [ s_DC_7, s_DC_10 ]
        -- Sub-Product: Rehypthecatable - Unencumbered
        && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isRehypothecateableCollateralUnencumbered subProduct) |> Maybe.withDefault False)
        -- Collateral Class: E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class) |> Maybe.withDefault False)
        -- Treasury Control: Y
        && (flow.treasuryControl == Just True)


{-| (6) Excess Collateral (§.22(b)(5))
-}
match_rule_6_section_22_b_5_L1 : DerivativesCollateral -> Bool
match_rule_6_section_22_b_5_L1 flow =
    List.member flow.product [ s_DC_15 ]
        -- Collateral Class: A-0-Q; A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel1 class) |> Maybe.withDefault False)
        -- Treasury Control: Y
        && (flow.treasuryControl == Just True)


{-| (6) Excess Collateral (§.22(b)(5))
-}
match_rule_6_section_22_b_5_L2a : DerivativesCollateral -> Bool
match_rule_6_section_22_b_5_L2a flow =
    List.member flow.product [ s_DC_15 ]
        -- Collateral Class: G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2A class) |> Maybe.withDefault False)
        -- Treasury Control: Y
        && (flow.treasuryControl == Just True)


{-| (6) Excess Collateral (§.22(b)(5))
-}
match_rule_6_section_22_b_5_L2b : DerivativesCollateral -> Bool
match_rule_6_section_22_b_5_L2b flow =
    List.member flow.product [ s_DC_15 ]
        -- Collateral Class: E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class) |> Maybe.withDefault False)
        -- Treasury Control: Y
        && (flow.treasuryControl == Just True)


{-| (33) Derivative Collateral Potential Valuation Changes (§.32(f)(2))
-}
match_rule_33_section_32_f_2 : DerivativesCollateral -> Bool
match_rule_33_section_32_f_2 flow =
    List.member flow.product [ s_DC_5, s_DC_6, s_DC_8, s_DC_9 ]
        -- Collateral Class: Not level 1 HQLA
        -- TODO
        && (flow.collateralClass |> Maybe.map (\class -> not (CollateralClass.isHQLALevel1 class)) |> Maybe.withDefault True)
        -- TODO
        && True


{-| (35) Collateral Deliverables (§.32(f)(4))
-}
match_rule_35_section_32_f_4 : DerivativesCollateral -> Bool
match_rule_35_section_32_f_4 flow =
    List.member flow.product [ s_DC_15 ]
        -- Collateral Class: Non-HQLA or Other
        -- TODO
        --&& (flow.collateralClass |> Maybe.map (\class -> not (CollateralClass.isHQLA class) || CollateralClass.isOther class) |> Maybe.withDefault False)
        -- TODO
        && True


{-| (36) Collateral Deliverables (§.32(f)(4))
-}
match_rule_36_section_32_f_4 : DerivativesCollateral -> Bool
match_rule_36_section_32_f_4 flow =
    List.member flow.product [ s_DC_15 ]
        -- Collateral Class: HQLA
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLA class) |> Maybe.withDefault False)
        -- Treasury Control: N
        && (flow.treasuryControl == Just False)


{-| (37) Collateral Deliverables (§.32(f)(5))
-}
match_rule_37_section_32_f_5 : DerivativesCollateral -> Bool
match_rule_37_section_32_f_5 flow =
    List.member flow.product [ s_DC_16 ]


{-| (38) Collateral Substitution (§.32(f)(6))
-}
match_rule_38_section_32_f_6 : DerivativesCollateral -> Bool
match_rule_38_section_32_f_6 flow =
    List.member flow.product [ s_DC_18, s_DC_20 ]
