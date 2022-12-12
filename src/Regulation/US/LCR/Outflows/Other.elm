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


module Regulation.US.LCR.Outflows.Other exposing (..)

import Regulation.US.FR2052A.DataTables.Outflows.Other exposing (..)
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket
import Regulation.US.LCR.AmountCalculations exposing (..)
import Regulation.US.LCR.Rule exposing (applyRule)
import Regulation.US.LCR.Rules exposing (RuleBalance)


applyRules : Other -> List RuleBalance
applyRules other =
    List.concat
        [ applyRule (match_rule_15_section_32_a_5 other) "32(a)(5)" other.maturityAmount
        , applyRule (match_rule_18_section_32_b other) "32(b)" other.maturityAmount
        , applyRule (match_rule_19_section_32_c other) "32(c)" other.maturityAmount
        , applyRule (match_rule_20_section_32_d other) "32(d)" other.maturityAmount
        , applyRule (match_rule_21_section_32_e_1_i other) "32(e)(1)(i)" (note_4 other.collateralClass other.collateralValue other.maturityAmount)
        , applyRule (match_rule_22_section_32_e_1_ii other) "32(e)(1)(ii)" (note_4 other.collateralClass other.collateralValue other.maturityAmount)
        , applyRule (match_rule_23_section_32_e_1_iii other) "32(e)(1)(iii)" (note_4 other.collateralClass other.collateralValue other.maturityAmount)
        , applyRule (match_rule_24_section_32_e_1_iv other) "32(e)(1)(iv)" (note_4 other.collateralClass other.collateralValue other.maturityAmount)
        , applyRule (match_rule_25_section_32_e_1_v other) "32(e)(1)(v)" (note_4 other.collateralClass other.collateralValue other.maturityAmount)
        , applyRule (match_rule_26_section_32_e_1_v other) "32(e)(1)(v)" (note_4 other.collateralClass other.collateralValue other.maturityAmount)
        , applyRule (match_rule_27_section_32_e_1_vi other) "32(e)(1)(vi)" (note_4 other.collateralClass other.collateralValue other.maturityAmount)
        , applyRule (match_rule_28_section_32_e_1_vii other) "32(e)(1)(vii)" (note_4 other.collateralClass other.collateralValue other.maturityAmount)
        , applyRule (match_rule_29_section_32_e_1_viii other) "32(e)(1)(viii)" (note_4 other.collateralClass other.collateralValue other.maturityAmount)
        , applyRule (match_rule_30_section_32_e_1_ix other) "32(e)(1)(ix)" (note_4 other.collateralClass other.collateralValue other.maturityAmount)
        , applyRule (match_rule_31_section_32_f_1 other) "32(f)(1)" other.maturityAmount
        , applyRule (match_rule_32_section_32_f_1 other) "32(f)(1)" other.maturityAmount
        , applyRule (match_rule_34_section_32_f_3 other) "32(f)(3)" other.maturityAmount
        , applyRule (match_rule_101_section_32_l other) "32(l)" other.maturityAmount
        , applyRule (match_rule_102_section_32_l other) "32(l)" other.maturityAmount
        ]


{-| (15) Other Retail Funding (§.32(a)(5))
-}
match_rule_15_section_32_a_5 : Other -> Bool
match_rule_15_section_32_a_5 other =
    List.member other.product [ o_O_22 ]
        -- Forward Start Amount: NULL
        && (other.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (other.forwardStartBucket == Nothing)


{-| (18) Structured Transaction Outother Amount (§.32(b))
-}
match_rule_18_section_32_b : Other -> Bool
match_rule_18_section_32_b other =
    List.member other.product [ o_O_21 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days other.maturityBucket
        -- Forward Start Amount: NULL
        && (other.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (other.forwardStartBucket == Nothing)


{-| (19) Net Derivatives Cash Outother Amount (§.32(c))
-}
match_rule_19_section_32_c : Other -> Bool
match_rule_19_section_32_c other =
    List.member other.product [ o_O_20 ]


{-| (20) Mortgage Commitment Outother Amount (§.32(d))
-}
match_rule_20_section_32_d : Other -> Bool
match_rule_20_section_32_d other =
    List.member other.product [ o_O_6 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days other.maturityBucket


{-| (21) Affiliated DI Commitments (§.32(e)(1)(i))
-}
match_rule_21_section_32_e_1_i : Other -> Bool
match_rule_21_section_32_e_1_i other =
    List.member other.product [ o_O_4, o_O_5 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days other.maturityBucket


{-| (22) Retail Commitments (§.32(e)(1)(ii))
-}
match_rule_22_section_32_e_1_ii : Other -> Bool
match_rule_22_section_32_e_1_ii other =
    List.member other.product [ o_O_4, o_O_5, o_O_18 ]
        -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
        && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days other.maturityBucket)


{-| (23) Non-Financial Corporate Credit Facilities (§.32(e)(1)(iii))
-}
match_rule_23_section_32_e_1_iii : Other -> Bool
match_rule_23_section_32_e_1_iii other =
    List.member other.product [ o_O_4 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days other.maturityBucket


{-| (24) Non-Financial Corporate Liquidity Facilities (§.32(e)(1)(iv))
-}
match_rule_24_section_32_e_1_iv : Other -> Bool
match_rule_24_section_32_e_1_iv other =
    List.member other.product [ o_O_5, o_O_18 ]
        -- Maturity Bucket: <= 30 calendar days for O.O.5; # for O.O.18
        && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days other.maturityBucket)


{-| (25) Bank Commitments (§.32(e)(1)(v))
-}
match_rule_25_section_32_e_1_v : Other -> Bool
match_rule_25_section_32_e_1_v other =
    List.member other.product [ o_O_4, o_O_5, o_O_18 ]
        -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
        && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days other.maturityBucket)


{-| (26) Bank Commitments (§.32(e)(1)(v))
-}
match_rule_26_section_32_e_1_v : Other -> Bool
match_rule_26_section_32_e_1_v other =
    List.member other.product [ o_O_4, o_O_5, o_O_18 ]
        -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
        && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days other.maturityBucket)


{-| (27) Non-Bank and Non-SPE Financial Sector Entity Credit Facilities (§.32(e)(1)(vi))
-}
match_rule_27_section_32_e_1_vi : Other -> Bool
match_rule_27_section_32_e_1_vi other =
    List.member other.product [ o_O_4 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days other.maturityBucket


{-| (28) Non-Bank and Non-SPE Financial Sector Entity Liquidity Facilities (§.32(e)(1)(vii))
-}
match_rule_28_section_32_e_1_vii : Other -> Bool
match_rule_28_section_32_e_1_vii other =
    List.member other.product [ o_O_5, o_O_18 ]
        -- Maturity Bucket: <= 30 calendar days for O.O.5; # for O.O.18
        && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days other.maturityBucket)


{-| (29) Debt Issuing SPE Commitments (§.32(e)(1)(viii))
-}
match_rule_29_section_32_e_1_viii : Other -> Bool
match_rule_29_section_32_e_1_viii other =
    List.member other.product [ o_O_4, o_O_5, o_O_18 ]
        -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
        && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days other.maturityBucket)


{-| (30) Other Commitments (§.32(e)(1)(ix))
-}
match_rule_30_section_32_e_1_ix : Other -> Bool
match_rule_30_section_32_e_1_ix other =
    List.member other.product [ o_O_4, o_O_5, o_O_18 ]
        -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
        && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days other.maturityBucket)


{-| (31) Changes in Financial Condition (§.32(f)(1))
-}
match_rule_31_section_32_f_1 : Other -> Bool
match_rule_31_section_32_f_1 other =
    List.member other.product [ o_O_16 ]


{-| (32) Changes in Financial Condition (§.32(f)(1))
-}
match_rule_32_section_32_f_1 : Other -> Bool
match_rule_32_section_32_f_1 other =
    List.member other.product [ o_O_12 ]


{-| (34) Potential Derivative Valuation Changes (§.32(f)(3))
-}
match_rule_34_section_32_f_3 : Other -> Bool
match_rule_34_section_32_f_3 other =
    List.member other.product [ o_O_8 ]


{-| (101) Other Contractual Outothers (§.32(l))
-}
match_rule_101_section_32_l : Other -> Bool
match_rule_101_section_32_l other =
    List.member other.product [ o_O_19 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days other.maturityBucket


{-| (102) Other Contractual Outothers (§.32(l))
-}
match_rule_102_section_32_l : Other -> Bool
match_rule_102_section_32_l other =
    List.member other.product [ o_O_22 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days other.maturityBucket
        -- Forward Start Amount: NULL
        && (other.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (other.forwardStartBucket == Nothing)
