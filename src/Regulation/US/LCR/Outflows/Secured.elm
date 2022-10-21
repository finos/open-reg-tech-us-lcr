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

module Regulation.US.LCR.Outflows.Secured exposing (..)


import Regulation.US.FR2052A.DataTables.Outflows.Secured exposing (..)
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.FR2052A.Fields.Insured as Insured
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct
import Regulation.US.LCR.AmountCalculations exposing (..)
import Regulation.US.LCR.Rule exposing (applyRule)


applyRules : Secured -> List ( String, Float )
applyRules flow =
    List.concat
        [ applyRule (match_rule_8_section_21_b_todo flow) "21(b)(todo)" flow.maturityAmount
        , applyRule (match_rule_16_section_32_a_5 flow) "32(a)(5)" flow.maturityAmount
        , applyRule (match_rule_51_section_32_h_1_ii_A flow) "32(h)(1)(ii)(A)" flow.maturityAmount
        , applyRule (match_rule_55_section_32_h_2 flow) "32(h)(2)" flow.maturityAmount
        , applyRule (match_rule_65_section_32_j_1_i flow) "32(j)(1)(i)" flow.maturityAmount
        , applyRule (match_rule_68_section_32_j_1_ii flow) "32(j)(1)(ii)" flow.maturityAmount
        , applyRule (match_rule_71_section_32_j_1_iii flow) "32(j)(1)(iii)" flow.maturityAmount
        , applyRule (match_rule_74_section_32_j_1_iv flow) "32(j)(1)(iv)" flow.maturityAmount
        , applyRule (match_rule_76_section_32_j_1_v flow) "32(j)(1)(v)" flow.maturityAmount
        , applyRule (match_rule_79_section_32_j_1_vi flow) "32(j)(1)(vi)" flow.maturityAmount
        , applyRule (match_rule_82_section_32_j_2 flow) "32(j)(2)" flow.maturityAmount
        , applyRule (match_rule_99_section_32_k flow) "32(k)" flow.maturityAmount
        , applyRule (match_rule_100_section_32_k flow) "32(k)" flow.maturityAmount
        ]


{-| (8) Secured Funding Unwind (Subpart C, §.21)
-}
match_rule_8_section_21_b_todo : Secured -> Bool
match_rule_8_section_21_b_todo flow =
    List.member flow.product [ o_S_1, o_S_2, o_S_3, o_S_4, o_S_5, o_S_6, o_S_7, o_S_11 ]
    -- Sub-Product: For O.S.7, cannot be Unsettled (Regular Way) or Unsettled (Forward), # otherwise
    && (flow.subProduct |> Maybe.map (\subProduct -> flow.product /= o_S_7 || not (SubProduct.isUnsettledRegularWay subProduct || SubProduct.isUnsettledForward subProduct)) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: A-0-Q; A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q; G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q; E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
    && (CollateralClass.isHQLA flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (16) Other Retail Funding (§.32(a)(5))
-}
match_rule_16_section_32_a_5 : Secured -> Bool
match_rule_16_section_32_a_5 flow =
    List.member flow.product [ o_S_1, o_S_2, o_S_7, o_S_11 ]
    -- Sub-Product: For O.S.7, cannot be Unsettled (Regular Way) or Unsettled (Forward), # otherwise
    && (flow.subProduct |> Maybe.map (\subProduct -> flow.product /= o_S_7 || not (SubProduct.isUnsettledRegularWay subProduct || SubProduct.isUnsettledForward subProduct)) |> Maybe.withDefault False)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (51) Not Fully Insured Unsecured Wholesale Non-Operational Non-Financial (§.32(h)(1)(ii)(A))
-}
match_rule_51_section_32_h_1_ii_A : Secured -> Bool
match_rule_51_section_32_h_1_ii_A flow =
    List.member flow.product [ o_S_1, o_S_2, o_S_3, o_S_5, o_S_6, o_S_7, o_S_11 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Other
    && (CollateralClass.isOther flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (55) Financial Non-Operational (§.32(h)(2))
-}
match_rule_55_section_32_h_2 : Secured -> Bool
match_rule_55_section_32_h_2 flow =
    List.member flow.product [ o_S_1, o_S_2, o_S_3, o_S_7, o_S_11 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Other
    && (CollateralClass.isOther flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (65) Secured Funding L1 (§.32(j)(1)(i))
-}
match_rule_65_section_32_j_1_i : Secured -> Bool
match_rule_65_section_32_j_1_i flow =
    List.member flow.product [ o_S_1, o_S_2, o_S_3, o_S_5, o_S_6, o_S_7, o_S_11 ]
    -- Sub-Product: For O.S.7, cannot be Unsettled (Regular Way) or Unsettled (Forward), # otherwise
    && (flow.subProduct |> Maybe.map (\subProduct -> flow.product /= o_S_7 || not (SubProduct.isUnsettledRegularWay subProduct || SubProduct.isUnsettledForward subProduct)) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Level 1 HQLA
    && (CollateralClass.isHQLALevel1 flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (68) Secured Funding L2A (§.32(j)(1)(ii))
-}
match_rule_68_section_32_j_1_ii : Secured -> Bool
match_rule_68_section_32_j_1_ii flow =
    List.member flow.product [ o_S_1, o_S_2, o_S_3, o_S_5, o_S_6, o_S_7, o_S_11 ]
    -- Sub-Product: For O.S.7, cannot be Unsettled (Regular Way) or Unsettled (Forward), # otherwise
    && (flow.subProduct |> Maybe.map (\subProduct -> flow.product /= o_S_7 || not (SubProduct.isUnsettledRegularWay subProduct || SubProduct.isUnsettledForward subProduct)) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Level 2A HQLA
    && (CollateralClass.isHQLALevel2A flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (71) Secured Funding from Governmental Entities not L1 or L2A (§.32(j)(1)(iii))
-}
match_rule_71_section_32_j_1_iii : Secured -> Bool
match_rule_71_section_32_j_1_iii flow =
    List.member flow.product [ o_S_1, o_S_2, o_S_3, o_S_5, o_S_6, o_S_7, o_S_11 ]
    -- Sub-Product: For O.S.7, cannot be Unsettled (Regular Way) or Unsettled (Forward), # otherwise
    && (flow.subProduct |> Maybe.map (\subProduct -> flow.product /= o_S_7 || not (SubProduct.isUnsettledRegularWay subProduct || SubProduct.isUnsettledForward subProduct)) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Level 2B HQLA or Non-HQLA
    && (CollateralClass.isHQLALevel2B flow.collateralClass || not (CollateralClass.isHQLA flow.collateralClass))
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (74) Secured Funding L2B (§.32(j)(1)(iv))
-}
match_rule_74_section_32_j_1_iv : Secured -> Bool
match_rule_74_section_32_j_1_iv flow =
    List.member flow.product [ o_S_1, o_S_2, o_S_3, o_S_7, o_S_11 ]
    -- Sub-Product: For O.S.7, cannot be Unsettled (Regular Way) or Unsettled (Forward), # otherwise
    && (flow.subProduct |> Maybe.map (\subProduct -> flow.product /= o_S_7 || not (SubProduct.isUnsettledRegularWay subProduct || SubProduct.isUnsettledForward subProduct)) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Level 2B HQLA
    && (CollateralClass.isHQLALevel2B flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (76) Customer Shorts Funded by Non-HQLA Customer Longs (§.32(j)(1)(v))
-}
match_rule_76_section_32_j_1_v : Secured -> Bool
match_rule_76_section_32_j_1_v flow =
    List.member flow.product [ o_S_7 ]
    -- Sub-Product: Customer Long
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isCustomerLong subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Non-HQLA
    && (not (CollateralClass.isHQLA flow.collateralClass))
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (79) Secured Funding Non-HQLA (§.32(j)(1)(vi))
-}
match_rule_79_section_32_j_1_vi : Secured -> Bool
match_rule_79_section_32_j_1_vi flow =
    List.member flow.product [ o_S_1, o_S_2, o_S_3, o_S_7, o_S_11 ]
    -- Sub-Product: For O.S.7, cannot be Customer Long, Unsettled (Regular Way) or Unsettled (Forward); #otherwise
    && (flow.subProduct |> Maybe.map (\subProduct -> flow.product /= o_S_7 || not (SubProduct.isCustomerLong subProduct || SubProduct.isUnsettledRegularWay subProduct || SubProduct.isUnsettledForward subProduct)) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Non-HQLA
    && (not (CollateralClass.isHQLA flow.collateralClass))
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (82) Secured but Lower Unsecured Rate (§.32(j)(2))
-}
match_rule_82_section_32_j_2 : Secured -> Bool
match_rule_82_section_32_j_2 flow =
    List.member flow.product [ o_S_1, o_S_2, o_S_3, o_S_5, o_S_7, o_S_11 ]
    -- Sub-Product: For O.S.7 must be firm long, otherwise #
    && (flow.subProduct |> Maybe.map (\subProduct -> flow.product /= o_S_7 || SubProduct.isFirmLong subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Level 2B HQLA or Non-HQLA
    && (CollateralClass.isHQLALevel2B flow.collateralClass || not (CollateralClass.isHQLA flow.collateralClass))
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (99) Foreign Central Banking Borrowing (§.32(k))
-}
match_rule_99_section_32_k : Secured -> Bool
match_rule_99_section_32_k flow =
    List.member flow.product [ o_S_1, o_S_2, o_S_3 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (100) Foreign Central Banking Borrowing (§.32(k))
-}
match_rule_100_section_32_k : Secured -> Bool
match_rule_100_section_32_k flow =
    List.member flow.product [ o_S_6 ]
    -- Sub-Product: Specific central bank
    && (flow.subProduct |> Maybe.map (\subProduct -> SubProduct.isSpecificCentralBank subProduct) |> Maybe.withDefault False)
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)