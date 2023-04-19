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
import Regulation.US.LCR.MaturityBucket exposing (FromDate)
import Regulation.US.LCR.Rule exposing (applyRule)
import Regulation.US.LCR.Rules exposing (RuleBalance, orElse)


{-| Given a list of Others, applies the applicable rule for each assets along with the relevant amount
-}
toRuleBalances : FromDate -> List Wholesale -> List RuleBalance
toRuleBalances fromDate list =
    list
        |> List.filterMap
            (\flow ->
                rule_17_section_32_a_5 fromDate flow
                    |> orElse (rule_50_section_32_h_1_ii_A fromDate flow)
                    |> orElse (rule_54_section_32_h_2 fromDate flow)
                    |> orElse (rule_56_section_32_h_2 fromDate flow)
                    |> orElse (rule_61_section_32_h_5 fromDate flow)
                    |> orElse (rule_66_section_32_j_1_i fromDate flow)
                    |> orElse (rule_69_section_32_j_1_ii fromDate flow)
                    |> orElse (rule_75_section_32_j_1_iv fromDate flow)
                    |> orElse (rule_80_section_32_j_1_vi fromDate flow)
            )


{-| (17) Other Retail Funding (§.32(a)(5))
-}
rule_17_section_32_a_5 : FromDate -> Wholesale -> Maybe RuleBalance
rule_17_section_32_a_5 fromDate wholesale =
    if
        List.member wholesale.product [ o_W_18 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate wholesale.maturityBucket
            -- Forward Start Amount: NULL
            && (wholesale.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (wholesale.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(a)(5)" wholesale.maturityAmount)

    else
        Nothing


{-| (50) Not Fully Insured Unsecured Wholesale Non-Operational Non-Financial (§.32(h)(1)(ii)(A))
-}
rule_50_section_32_h_1_ii_A : FromDate -> Wholesale -> Maybe RuleBalance
rule_50_section_32_h_1_ii_A fromDate wholesale =
    if
        List.member wholesale.product [ o_W_9, o_W_10, o_W_17, o_W_18 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate wholesale.maturityBucket
            -- Forward Start Amount: NULL
            && (wholesale.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (wholesale.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(h)(1)(ii)(A)" wholesale.maturityAmount)

    else
        Nothing



--{-| (51) Not Fully Insured Unsecured Wholesale Non-Operational Non-Financial (§.32(h)(1)(ii)(A))
---}
--rule_51_section_32_h_1_ii_B : FromDate -> Wholesale -> Maybe RuleBalance
--rule_51_section_32_h_1_ii_B fromDate wholesale =
--    if
--        List.member wholesale.product [ o_D_8, o_D_9, o_D_10, o_D_11, o_D_13 ]
--            -- Maturity Bucket: <= 30 calendar days
--            && MaturityBucket.isLessThanOrEqual30Days fromDate wholesale.maturityBucket
--            -- Forward Start Amount: NULL
--            && (wholesale.forwardStartAmount == Nothing)
--            -- Forward Start Bucket: NULL
--            && (wholesale.forwardStartBucket == Nothing)
--    then
--        Just (RuleBalance "" wholesale.maturityAmount)
--
--    else
--        Nothing


{-| (54) Financial Non-Operational (§.32(h)(2))
-}
rule_54_section_32_h_2 : FromDate -> Wholesale -> Maybe RuleBalance
rule_54_section_32_h_2 fromDate wholesale =
    if
        List.member wholesale.product [ o_W_9, o_W_10, o_W_17, o_W_18 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate wholesale.maturityBucket
            -- Forward Start Amount: NULL
            && (wholesale.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (wholesale.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(h)(2)" wholesale.maturityAmount)

    else
        Nothing


{-| (56) Issued Debt Securities Maturing within 30 Days (§.32(h)(2))
-}
rule_56_section_32_h_2 : FromDate -> Wholesale -> Maybe RuleBalance
rule_56_section_32_h_2 fromDate wholesale =
    if
        List.member wholesale.product [ o_W_8, o_W_11, o_W_12, o_W_13, o_W_14, o_W_15, o_W_16 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate wholesale.maturityBucket
            -- Forward Start Amount: NULL
            && (wholesale.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (wholesale.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(h)(2)" wholesale.maturityAmount)

    else
        Nothing


{-| (61) Other Unsecured Wholesale (§.32(h)(5))
-}
rule_61_section_32_h_5 : FromDate -> Wholesale -> Maybe RuleBalance
rule_61_section_32_h_5 fromDate wholesale =
    if
        List.member wholesale.product [ o_W_19 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate wholesale.maturityBucket
            -- Forward Start Amount: NULL
            && (wholesale.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (wholesale.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(h)(5)" wholesale.maturityAmount)

    else
        Nothing


{-| (66) Secured Funding L1 (§.32(j)(1)(i))
-}
rule_66_section_32_j_1_i : FromDate -> Wholesale -> Maybe RuleBalance
rule_66_section_32_j_1_i fromDate wholesale =
    if
        List.member wholesale.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate wholesale.maturityBucket
            -- Collateral Class: Level 1 HQLA
            && (wholesale.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel1 class) |> Maybe.withDefault False)
            -- Forward Start Amount: NULL
            && (wholesale.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (wholesale.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(1)(i)" wholesale.maturityAmount)

    else
        Nothing


{-| (69) Secured Funding L2A (§.32(j)(1)(ii))
-}
rule_69_section_32_j_1_ii : FromDate -> Wholesale -> Maybe RuleBalance
rule_69_section_32_j_1_ii fromDate wholesale =
    if
        List.member wholesale.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate wholesale.maturityBucket
            -- Collateral Class: Level 2A HQLA
            && (wholesale.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2A class) |> Maybe.withDefault False)
            -- Forward Start Amount: NULL
            && (wholesale.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (wholesale.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(1)(ii)" wholesale.maturityAmount)

    else
        Nothing


{-| (75) Secured Funding L2B (§.32(j)(1)(iv))
-}
rule_75_section_32_j_1_iv : FromDate -> Wholesale -> Maybe RuleBalance
rule_75_section_32_j_1_iv fromDate wholesale =
    if
        List.member wholesale.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate wholesale.maturityBucket
            -- Collateral Class: Level 2B HQLA
            && (wholesale.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class) |> Maybe.withDefault False)
            -- Forward Start Amount: NULL
            && (wholesale.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (wholesale.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(1)(iv)" wholesale.maturityAmount)

    else
        Nothing


{-| (80) Secured Funding Non-HQLA (§.32(j)(1)(vi))
-}
rule_80_section_32_j_1_vi : FromDate -> Wholesale -> Maybe RuleBalance
rule_80_section_32_j_1_vi fromDate wholesale =
    if
        List.member wholesale.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate wholesale.maturityBucket
            -- Collateral Class: Non-HQLA
            && (wholesale.collateralClass |> Maybe.map (\class -> not (CollateralClass.isHQLA class)) |> Maybe.withDefault False)
            -- Forward Start Amount: NULL
            && (wholesale.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (wholesale.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "32(j)(1)(vi)" wholesale.maturityAmount)

    else
        Nothing
