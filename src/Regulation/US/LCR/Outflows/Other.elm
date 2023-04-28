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
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket exposing (FromDate)
import Regulation.US.LCR.AmountCalculations exposing (..)
import Regulation.US.LCR.Rule exposing (applyRule)
import Regulation.US.LCR.Rules exposing (RuleBalance, orElse)


{-| Given a list, applies the applicable rule for each assets along with the relevant amount
-}
toRuleBalances : FromDate -> List Other -> List RuleBalance
toRuleBalances fromDate list =
    list
        |> List.filterMap
            (\other ->
                rule_15_section_32_a_5 other
                    |> orElse (rule_18_section_32_b fromDate other)
                    |> orElse (rule_19_section_32_c other)
                    |> orElse (rule_20_section_32_d fromDate other)
                    |> orElse (rule_21_section_32_e_1_i fromDate other)
                    |> orElse (rule_22_section_32_e_1_ii fromDate other)
                    |> orElse (rule_23_section_32_e_1_iii fromDate other)
                    |> orElse (rule_24_section_32_e_1_iv fromDate other)
                    |> orElse (rule_25_section_32_e_1_v fromDate other)
                    |> orElse (rule_26_section_32_e_1_v fromDate other)
                    |> orElse (rule_27_section_32_e_1_vi fromDate other)
                    |> orElse (rule_28_section_32_e_1_vii fromDate other)
                    |> orElse (rule_29_section_32_e_1_viii fromDate other)
                    |> orElse (rule_30_section_32_e_1_ix fromDate other)
                    |> orElse (rule_31_section_32_f_1 other)
                    |> orElse (rule_32_section_32_f_1 other)
                    |> orElse (rule_34_section_32_f_3 other)
                    |> orElse (rule_101_section_32_l fromDate other)
                    |> orElse (rule_102_section_32_l fromDate other)
            )


{-| (15) Other Retail Funding (§.32(a)(5))
-}
rule_15_section_32_a_5 : Other -> Maybe RuleBalance
rule_15_section_32_a_5 other =
    if
        List.member other.product [ o_O_22 ]
            -- Forward Start Amount: NULL
            && (other.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (other.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(a)(5)" other.maturityAmount)

    else
        Nothing


{-| (18) Structured Transaction Outother Amount (§.32(b))
-}
rule_18_section_32_b : FromDate -> Other -> Maybe RuleBalance
rule_18_section_32_b fromDate other =
    if
        List.member other.product [ o_O_21 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket
            -- Forward Start Amount: NULL
            && (other.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (other.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(b)" other.maturityAmount)

    else
        Nothing


{-| (19) Net Derivatives Cash Outother Amount (§.32(c))
-}
rule_19_section_32_c : Other -> Maybe RuleBalance
rule_19_section_32_c other =
    if List.member other.product [ o_O_20 ] then
        Just (RuleBalance "32(c)" other.maturityAmount)

    else
        Nothing


{-| (20) Mortgage Commitment Outother Amount (§.32(d))
-}
rule_20_section_32_d : FromDate -> Other -> Maybe RuleBalance
rule_20_section_32_d fromDate other =
    if
        List.member other.product [ o_O_6 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket
    then
        Just (RuleBalance "32(d)" other.maturityAmount)

    else
        Nothing


{-| (21) Affiliated DI Commitments (§.32(e)(1)(i))
-}
rule_21_section_32_e_1_i : FromDate -> Other -> Maybe RuleBalance
rule_21_section_32_e_1_i fromDate other =
    if
        List.member other.product [ o_O_4, o_O_5 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket
    then
        Just (RuleBalance "32(e)(1)(i)" (note_4 other.collateralClass other.collateralValue other.maturityAmount))

    else
        Nothing


{-| (22) Retail Commitments (§.32(e)(1)(ii))
-}
rule_22_section_32_e_1_ii : FromDate -> Other -> Maybe RuleBalance
rule_22_section_32_e_1_ii fromDate other =
    if
        List.member other.product [ o_O_4, o_O_5, o_O_18 ]
            -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
            && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket)
    then
        Just (RuleBalance "32(e)(1)(ii)" (note_4 other.collateralClass other.collateralValue other.maturityAmount))

    else
        Nothing


{-| (23) Non-Financial Corporate Credit Facilities (§.32(e)(1)(iii))
-}
rule_23_section_32_e_1_iii : FromDate -> Other -> Maybe RuleBalance
rule_23_section_32_e_1_iii fromDate other =
    if
        List.member other.product [ o_O_4 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket
    then
        Just (RuleBalance "32(e)(1)(iii)" (note_4 other.collateralClass other.collateralValue other.maturityAmount))

    else
        Nothing


{-| (24) Non-Financial Corporate Liquidity Facilities (§.32(e)(1)(iv))
-}
rule_24_section_32_e_1_iv : FromDate -> Other -> Maybe RuleBalance
rule_24_section_32_e_1_iv fromDate other =
    if
        List.member other.product [ o_O_5, o_O_18 ]
            -- Maturity Bucket: <= 30 calendar days for O.O.5; # for O.O.18
            && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket)
    then
        Just (RuleBalance "32(e)(1)(iv)" (note_4 other.collateralClass other.collateralValue other.maturityAmount))

    else
        Nothing


{-| (25) Bank Commitments (§.32(e)(1)(v))
-}
rule_25_section_32_e_1_v : FromDate -> Other -> Maybe RuleBalance
rule_25_section_32_e_1_v fromDate other =
    if
        List.member other.product [ o_O_4, o_O_5, o_O_18 ]
            -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
            && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket)
    then
        Just (RuleBalance "32(e)(1)(v)" (note_4 other.collateralClass other.collateralValue other.maturityAmount))

    else
        Nothing


{-| (26) Bank Commitments (§.32(e)(1)(v))
-}
rule_26_section_32_e_1_v : FromDate -> Other -> Maybe RuleBalance
rule_26_section_32_e_1_v fromDate other =
    if
        List.member other.product [ o_O_4, o_O_5, o_O_18 ]
            -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
            && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket)
    then
        Just (RuleBalance "32(e)(1)(v)" (note_4 other.collateralClass other.collateralValue other.maturityAmount))

    else
        Nothing


{-| (27) Non-Bank and Non-SPE Financial Sector Entity Credit Facilities (§.32(e)(1)(vi))
-}
rule_27_section_32_e_1_vi : FromDate -> Other -> Maybe RuleBalance
rule_27_section_32_e_1_vi fromDate other =
    if
        List.member other.product [ o_O_4 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket
    then
        Just (RuleBalance "32(e)(1)(vi)" (note_4 other.collateralClass other.collateralValue other.maturityAmount))

    else
        Nothing


{-| (28) Non-Bank and Non-SPE Financial Sector Entity Liquidity Facilities (§.32(e)(1)(vii))
-}
rule_28_section_32_e_1_vii : FromDate -> Other -> Maybe RuleBalance
rule_28_section_32_e_1_vii fromDate other =
    if
        List.member other.product [ o_O_5, o_O_18 ]
            -- Maturity Bucket: <= 30 calendar days for O.O.5; # for O.O.18
            && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket)
    then
        Just (RuleBalance "32(e)(1)(vii)" (note_4 other.collateralClass other.collateralValue other.maturityAmount))

    else
        Nothing


{-| (29) Debt Issuing SPE Commitments (§.32(e)(1)(viii))
-}
rule_29_section_32_e_1_viii : FromDate -> Other -> Maybe RuleBalance
rule_29_section_32_e_1_viii fromDate other =
    if
        List.member other.product [ o_O_4, o_O_5, o_O_18 ]
            -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
            && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket)
    then
        Just (RuleBalance "32(e)(1)(viii)" (note_4 other.collateralClass other.collateralValue other.maturityAmount))

    else
        Nothing


{-| (30) Other Commitments (§.32(e)(1)(ix))
-}
rule_30_section_32_e_1_ix : FromDate -> Other -> Maybe RuleBalance
rule_30_section_32_e_1_ix fromDate other =
    if
        List.member other.product [ o_O_4, o_O_5, o_O_18 ]
            -- Maturity Bucket: <= 30 calendar days for O.O.4, O.O.5; # for O.O.18
            && (other.product == o_O_18 || MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket)
    then
        Just (RuleBalance "32(e)(1)(ix)" (note_4 other.collateralClass other.collateralValue other.maturityAmount))

    else
        Nothing


{-| (31) Changes in Financial Condition (§.32(f)(1))
-}
rule_31_section_32_f_1 : Other -> Maybe RuleBalance
rule_31_section_32_f_1 other =
    if List.member other.product [ o_O_16 ] then
        Just (RuleBalance "32(f)(1)" other.maturityAmount)

    else
        Nothing


{-| (32) Changes in Financial Condition (§.32(f)(1))
-}
rule_32_section_32_f_1 : Other -> Maybe RuleBalance
rule_32_section_32_f_1 other =
    if List.member other.product [ o_O_12 ] then
        Just (RuleBalance "32(f)(1)" other.maturityAmount)

    else
        Nothing


{-| (34) Potential Derivative Valuation Changes (§.32(f)(3))
-}
rule_34_section_32_f_3 : Other -> Maybe RuleBalance
rule_34_section_32_f_3 other =
    if List.member other.product [ o_O_8 ] then
        Just (RuleBalance "32(f)(3)" other.maturityAmount)

    else
        Nothing


{-| (101) Other Contractual Outothers (§.32(l))
-}
rule_101_section_32_l : FromDate -> Other -> Maybe RuleBalance
rule_101_section_32_l fromDate other =
    if
        List.member other.product [ o_O_19 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket
    then
        Just (RuleBalance "32(l)" other.maturityAmount)

    else
        Nothing


{-| (102) Other Contractual Outothers (§.32(l))
-}
rule_102_section_32_l : FromDate -> Other -> Maybe RuleBalance
rule_102_section_32_l fromDate other =
    if
        List.member other.product [ o_O_22 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate other.maturityBucket
            -- Forward Start Amount: NULL
            && (other.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (other.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(l)" other.maturityAmount)

    else
        Nothing
