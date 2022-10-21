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
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.FR2052A.Fields.Insured as Insured
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct
import Regulation.US.LCR.AmountCalculations exposing (..)
import Regulation.US.LCR.Rule exposing (applyRule)


applyRules : Other -> List ( String, Float )
applyRules flow =
    List.concat
        [ applyRule (match_rule_15_section_32_a_5 flow) "32(a)(5)" flow.maturityAmount
        , applyRule (match_rule_18_section_32_b flow) "32(b)" flow.maturityAmount
        , applyRule (match_rule_19_section_32_c flow) "32(c)" flow.maturityAmount
        , applyRule (match_rule_20_section_32_d flow) "32(d)" flow.maturityAmount
        , applyRule (match_rule_21_section_32_e_1_i flow) "32(e)(1)(i)" (note_4 flow.collateralClass flow.collateralValue flow.maturityAmount)
        , applyRule (match_rule_22_section_32_e_1_ii flow) "32(e)(1)(ii)" (note_4 flow.collateralClass flow.collateralValue flow.maturityAmount)
        , applyRule (match_rule_23_section_32_e_1_iii flow) "32(e)(1)(iii)" (note_4 flow.collateralClass flow.collateralValue flow.maturityAmount)
        , applyRule (match_rule_24_section_32_e_1_iv flow) "32(e)(1)(iv)" (note_4 flow.collateralClass flow.collateralValue flow.maturityAmount)
        , applyRule (match_rule_25_section_32_e_1_v flow) "32(e)(1)(v)" (note_4 flow.collateralClass flow.collateralValue flow.maturityAmount)
        , applyRule (match_rule_26_section_32_e_1_v flow) "32(e)(1)(v)" (note_4 flow.collateralClass flow.collateralValue flow.maturityAmount)
        , applyRule (match_rule_27_section_32_e_1_vi flow) "32(e)(1)(vi)" (note_4 flow.collateralClass flow.collateralValue flow.maturityAmount)
        , applyRule (match_rule_28_section_32_e_1_vii flow) "32(e)(1)(vii)" (note_4 flow.collateralClass flow.collateralValue flow.maturityAmount)
        , applyRule (match_rule_29_section_32_e_1_viii flow) "32(e)(1)(viii)" (note_4 flow.collateralClass flow.collateralValue flow.maturityAmount)
        , applyRule (match_rule_30_section_32_e_1_ix flow) "32(e)(1)(ix)" (note_4 flow.collateralClass flow.collateralValue flow.maturityAmount)
        , applyRule (match_rule_31_section_32_f_1 flow) "32(f)(1)" flow.maturityAmount
        , applyRule (match_rule_32_section_32_f_1 flow) "32(f)(1)" flow.maturityAmount
        , applyRule (match_rule_34_section_32_f_3 flow) "32(f)(3)" flow.maturityAmount
        , applyRule (match_rule_101_section_32_l flow) "32(l)" flow.maturityAmount
        , applyRule (match_rule_102_section_32_l flow) "32(l)" flow.maturityAmount
        ]


{-| (15) Other Retail Funding (§.32(a)(5))
-}
match_rule_15_section_32_a_5 : Other -> Bool
match_rule_15_section_32_a_5 flow =
    List.member flow.product [ o_O_22 ]
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (18) Structured Transaction Outflow Amount (§.32(b))
-}
match_rule_18_section_32_b : Other -> Bool
match_rule_18_section_32_b flow =
    List.member flow.product [ o_O_21 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (19) Net Derivatives Cash Outflow Amount (§.32(c))
-}
match_rule_19_section_32_c : Other -> Bool
match_rule_19_section_32_c flow =
    List.member flow.product [ o_O_20 ]


{-| (20) Mortgage Commitment Outflow Amount (§.32(d))
-}
match_rule_20_section_32_d : Other -> Bool
match_rule_20_section_32_d flow =
    List.member flow.product [ o_O_6 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (21) Affiliated DI Commitments (§.32(e)(1)(i))
-}
match_rule_21_section_32_e_1_i : Other -> Bool
match_rule_21_section_32_e_1_i flow =
    List.member flow.product [ o_O_4, o_O_5 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (22) Retail Commitments (§.32(e)(1)(ii))
-}
match_rule_22_section_32_e_1_ii : Other -> Bool
match_rule_22_section_32_e_1_ii flow =
    List.member flow.product [ o_O_4, o_O_5, o_O_18 ]
    -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
    && (flow.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (23) Non-Financial Corporate Credit Facilities (§.32(e)(1)(iii))
-}
match_rule_23_section_32_e_1_iii : Other -> Bool
match_rule_23_section_32_e_1_iii flow =
    List.member flow.product [ o_O_4 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (24) Non-Financial Corporate Liquidity Facilities (§.32(e)(1)(iv))
-}
match_rule_24_section_32_e_1_iv : Other -> Bool
match_rule_24_section_32_e_1_iv flow =
    List.member flow.product [ o_O_5, o_O_18 ]
    -- Maturity Bucket: <= 30 calendar days for O.O.5; # for O.O.18
    && (flow.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (25) Bank Commitments (§.32(e)(1)(v))
-}
match_rule_25_section_32_e_1_v : Other -> Bool
match_rule_25_section_32_e_1_v flow =
    List.member flow.product [ o_O_4, o_O_5, o_O_18 ]
    -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
    && (flow.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (26) Bank Commitments (§.32(e)(1)(v))
-}
match_rule_26_section_32_e_1_v : Other -> Bool
match_rule_26_section_32_e_1_v flow =
    List.member flow.product [ o_O_4, o_O_5, o_O_18 ]
    -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
    && (flow.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (27) Non-Bank and Non-SPE Financial Sector Entity Credit Facilities (§.32(e)(1)(vi))
-}
match_rule_27_section_32_e_1_vi : Other -> Bool
match_rule_27_section_32_e_1_vi flow =
    List.member flow.product [ o_O_4 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (28) Non-Bank and Non-SPE Financial Sector Entity Liquidity Facilities (§.32(e)(1)(vii))
-}
match_rule_28_section_32_e_1_vii : Other -> Bool
match_rule_28_section_32_e_1_vii flow =
    List.member flow.product [ o_O_5, o_O_18 ]
    -- Maturity Bucket: <= 30 calendar days for O.O.5; # for O.O.18
    && (flow.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (29) Debt Issuing SPE Commitments (§.32(e)(1)(viii))
-}
match_rule_29_section_32_e_1_viii : Other -> Bool
match_rule_29_section_32_e_1_viii flow =
    List.member flow.product [ o_O_4, o_O_5, o_O_18 ]
    -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
    && (flow.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (30) Other Commitments (§.32(e)(1)(ix))
-}
match_rule_30_section_32_e_1_ix : Other -> Bool
match_rule_30_section_32_e_1_ix flow =
    List.member flow.product [ o_O_4, o_O_5, o_O_18 ]
    -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
    && (flow.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (31) Changes in Financial Condition (§.32(f)(1))
-}
match_rule_31_section_32_f_1 : Other -> Bool
match_rule_31_section_32_f_1 flow =
    List.member flow.product [ o_O_16 ]


{-| (32) Changes in Financial Condition (§.32(f)(1))
-}
match_rule_32_section_32_f_1 : Other -> Bool
match_rule_32_section_32_f_1 flow =
    List.member flow.product [ o_O_12 ]


{-| (34) Potential Derivative Valuation Changes (§.32(f)(3))
-}
match_rule_34_section_32_f_3 : Other -> Bool
match_rule_34_section_32_f_3 flow =
    List.member flow.product [ o_O_8 ]


{-| (101) Other Contractual Outflows (§.32(l))
-}
match_rule_101_section_32_l : Other -> Bool
match_rule_101_section_32_l flow =
    List.member flow.product [ o_O_19 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)


{-| (102) Other Contractual Outflows (§.32(l))
-}
match_rule_102_section_32_l : Other -> Bool
match_rule_102_section_32_l flow =
    List.member flow.product [ o_O_22 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)