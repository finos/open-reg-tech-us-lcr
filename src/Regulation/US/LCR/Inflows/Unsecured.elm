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


module Regulation.US.LCR.Inflows.Unsecured exposing (..)

import Regulation.US.FR2052A.DataTables.Inflows.Unsecured exposing (..)
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket exposing (FromDate)
import Regulation.US.LCR.Rule exposing (applyRule)
import Regulation.US.LCR.Rules exposing (RuleBalance, orElse)


{-| Given a list of Unsecured, applies the applicable rule for each assets along with the relevant amount
-}
toRuleBalances : FromDate -> List Unsecured -> List RuleBalance
toRuleBalances fromDate list =
    list
        |> List.filterMap
            (\flow ->
                rule_104_section_33_c fromDate flow
                    |> orElse (rule_106_section_33_d_1 fromDate flow)
                    |> orElse (rule_109_section_33_d_2 fromDate flow)
            )


{-| (104) Retail Cash Inflow Amount (§.33(c))
-}
rule_104_section_33_c : FromDate -> Unsecured -> Maybe RuleBalance
rule_104_section_33_c fromDate flow =
    if
        List.member flow.product [ i_U_5, i_U_6 ]
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


{-| (106) Financial and Central Bank Cash Inflow Amount (§.33(d)(1))
-}
rule_106_section_33_d_1 : FromDate -> Unsecured -> Maybe RuleBalance
rule_106_section_33_d_1 fromDate flow =
    if
        List.member flow.product [ i_U_1, i_U_2, i_U_4, i_U_5, i_U_6, i_U_8 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(d)(1)" flow.maturityAmount)

    else
        Nothing


{-| (109) Non-Financial Wholesale Cash Inflow Amount (§.33(d)(2))
-}
rule_109_section_33_d_2 : FromDate -> Unsecured -> Maybe RuleBalance
rule_109_section_33_d_2 fromDate flow =
    if
        List.member flow.product [ i_U_1, i_U_2, i_U_6 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just (RuleBalance "33(d)(2)" flow.maturityAmount)

    else
        Nothing
