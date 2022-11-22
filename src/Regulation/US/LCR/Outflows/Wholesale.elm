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


module Regulation.US.LCR.Outflows.Wholesale exposing (..)

import Regulation.US.FR2052A.DataTables.Outflows.Wholesale exposing (..)
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket
import Regulation.US.LCR.Rule exposing (applyRule)


applyRules : Wholesale -> List ( String, Float )
applyRules wholesale =
    List.concat
        [ applyRule (match_rule_17_section_32_a_5 wholesale) "32(a)(5)" wholesale.maturityAmount
        , applyRule (match_rule_50_section_32_h_1_ii_A wholesale) "32(h)(1)(ii)(A)" wholesale.maturityAmount

        --, applyRule (match_rule_51_section_32_h_1_ii_B wholesale) "32(h)(1)(ii)(B)" wholesale.maturityAmount
        , applyRule (match_rule_54_section_32_h_2 wholesale) "32(h)(2)" wholesale.maturityAmount
        , applyRule (match_rule_56_section_32_h_2 wholesale) "32(h)(2)" wholesale.maturityAmount
        , applyRule (match_rule_61_section_32_h_5 wholesale) "32(h)(5)" wholesale.maturityAmount
        , applyRule (match_rule_66_section_32_j_1_i wholesale) "32(j)(1)(i)" wholesale.maturityAmount
        , applyRule (match_rule_69_section_32_j_1_ii wholesale) "32(j)(1)(ii)" wholesale.maturityAmount
        , applyRule (match_rule_75_section_32_j_1_iv wholesale) "32(j)(1)(iv)" wholesale.maturityAmount
        , applyRule (match_rule_80_section_32_j_1_vi wholesale) "32(j)(1)(vi)" wholesale.maturityAmount
        ]


{-| (17) Other Retail Funding (§.32(a)(5))
-}
match_rule_17_section_32_a_5 : Wholesale -> Bool
match_rule_17_section_32_a_5 wholesale =
    List.member wholesale.product [ o_W_18 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days wholesale.maturityBucket
        -- Forward Start Amount: NULL
        && (wholesale.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (wholesale.forwardStartBucket == Nothing)


{-| (50) Not Fully Insured Unsecured Wholesale Non-Operational Non-Financial (§.32(h)(1)(ii)(A))
-}
match_rule_50_section_32_h_1_ii_A : Wholesale -> Bool
match_rule_50_section_32_h_1_ii_A wholesale =
    List.member wholesale.product [ o_W_9, o_W_10, o_W_17, o_W_18 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days wholesale.maturityBucket
        -- Forward Start Amount: NULL
        && (wholesale.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (wholesale.forwardStartBucket == Nothing)



--{-| (51) Not Fully Insured Unsecured Wholesale Non-Operational Non-Financial (§.32(h)(1)(ii)(A))
---}
--match_rule_51_section_32_h_1_ii_B : Wholesale -> Bool
--match_rule_51_section_32_h_1_ii_B wholesale =
--    List.member wholesale.product [ o_D_8, o_D_9, o_D_10, o_D_11, o_D_13 ]
--        -- Maturity Bucket: <= 30 calendar days
--        && MaturityBucket.isLessThanOrEqual30Days wholesale.maturityBucket
--        -- Forward Start Amount: NULL
--        && (wholesale.forwardStartAmount == Nothing)
--        -- Forward Start Bucket: NULL
--        && (wholesale.forwardStartBucket == Nothing)


{-| (54) Financial Non-Operational (§.32(h)(2))
-}
match_rule_54_section_32_h_2 : Wholesale -> Bool
match_rule_54_section_32_h_2 wholesale =
    List.member wholesale.product [ o_W_9, o_W_10, o_W_17, o_W_18 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days wholesale.maturityBucket
        -- Forward Start Amount: NULL
        && (wholesale.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (wholesale.forwardStartBucket == Nothing)


{-| (56) Issued Debt Securities Maturing within 30 Days (§.32(h)(2))
-}
match_rule_56_section_32_h_2 : Wholesale -> Bool
match_rule_56_section_32_h_2 wholesale =
    List.member wholesale.product [ o_W_8, o_W_11, o_W_12, o_W_13, o_W_14, o_W_15, o_W_16 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days wholesale.maturityBucket
        -- Forward Start Amount: NULL
        && (wholesale.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (wholesale.forwardStartBucket == Nothing)


{-| (61) Other Unsecured Wholesale (§.32(h)(5))
-}
match_rule_61_section_32_h_5 : Wholesale -> Bool
match_rule_61_section_32_h_5 wholesale =
    List.member wholesale.product [ o_W_19 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days wholesale.maturityBucket
        -- Forward Start Amount: NULL
        && (wholesale.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (wholesale.forwardStartBucket == Nothing)


{-| (66) Secured Funding L1 (§.32(j)(1)(i))
-}
match_rule_66_section_32_j_1_i : Wholesale -> Bool
match_rule_66_section_32_j_1_i wholesale =
    List.member wholesale.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days wholesale.maturityBucket
        -- Collateral Class: Level 1 HQLA
        && (wholesale.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel1 class) |> Maybe.withDefault False)
        -- Forward Start Amount: NULL
        && (wholesale.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (wholesale.forwardStartBucket == Nothing)


{-| (69) Secured Funding L2A (§.32(j)(1)(ii))
-}
match_rule_69_section_32_j_1_ii : Wholesale -> Bool
match_rule_69_section_32_j_1_ii wholesale =
    List.member wholesale.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days wholesale.maturityBucket
        -- Collateral Class: Level 2A HQLA
        && (wholesale.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2A class) |> Maybe.withDefault False)
        -- Forward Start Amount: NULL
        && (wholesale.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (wholesale.forwardStartBucket == Nothing)


{-| (75) Secured Funding L2B (§.32(j)(1)(iv))
-}
match_rule_75_section_32_j_1_iv : Wholesale -> Bool
match_rule_75_section_32_j_1_iv wholesale =
    List.member wholesale.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days wholesale.maturityBucket
        -- Collateral Class: Level 2B HQLA
        && (wholesale.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class) |> Maybe.withDefault False)
        -- Forward Start Amount: NULL
        && (wholesale.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (wholesale.forwardStartBucket == Nothing)


{-| (80) Secured Funding Non-HQLA (§.32(j)(1)(vi))
-}
match_rule_80_section_32_j_1_vi : Wholesale -> Bool
match_rule_80_section_32_j_1_vi wholesale =
    List.member wholesale.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days wholesale.maturityBucket
        -- Collateral Class: Non-HQLA
        && (wholesale.collateralClass |> Maybe.map (\class -> not (CollateralClass.isHQLA class)) |> Maybe.withDefault False)
        -- Forward Start Amount: NULL
        && (wholesale.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (wholesale.forwardStartBucket == Nothing)
