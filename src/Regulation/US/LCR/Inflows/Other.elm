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


module Regulation.US.LCR.Inflows.Other exposing (..)

import Regulation.US.FR2052A.DataTables.Inflows.Other exposing (..)
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket
import Regulation.US.LCR.Rule exposing (applyRule)
import Regulation.US.LCR.Rules exposing (RuleBalance)


{-| Given a list of Others, applies the applicable rule for each assets along with the relevant amount
-}
toRuleBalances : List Other -> List RuleBalance
toRuleBalances flows =
    flows
        |> List.map
            (\flow ->
                { rule =
                    if match_rule_103_section_33_b flow then
                        "33(b)"

                    else if match_rule_111_section_33_e flow then
                        "33(e)"

                    else if match_rule_112_section_33_e flow then
                        "33(e)"

                    else if match_rule_135_section_33_g flow then
                        "33(g)"

                    else if match_rule_136_section_33_h flow then
                        "33(h)"

                    else
                        ""
                , amount = flow.maturityAmount
                }
            )
        |> List.filter (\rb -> rb.rule /= "")


applyRules : Other -> List RuleBalance
applyRules flow =
    List.concat
        [ applyRule (match_rule_103_section_33_b flow) "33(b)" flow.maturityAmount
        , applyRule (match_rule_111_section_33_e flow) "33(e)" flow.maturityAmount
        , applyRule (match_rule_112_section_33_e flow) "33(e)" flow.maturityAmount
        , applyRule (match_rule_135_section_33_g flow) "33(g)" flow.maturityAmount
        , applyRule (match_rule_136_section_33_h flow) "33(h)" flow.maturityAmount
        ]


{-| (103) Net Derivatives Cash Inflow Amount (§.33(b))
-}
match_rule_103_section_33_b : Other -> Bool
match_rule_103_section_33_b flow =
    List.member flow.product [ i_O_7 ]


{-| (111) Securities Cash Inflow Amount (§.33(e))
-}
match_rule_111_section_33_e : Other -> Bool
match_rule_111_section_33_e flow =
    List.member flow.product [ i_O_6, i_O_8 ]
        -- Maturity Bucket: <= 30 calendar days but not Open
        && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket && flow.maturityBucket /= MaturityBucket.open)
        -- Collateral Class: Non-HQLA securities
        -- TODO
        --&& (flow.collateralClass |> Maybe.map (\class -> not (CollateralClass.isHQLA class)) |> Maybe.withDefault False)
        -- Forward Start Amount: NULL
        && (flow.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (flow.forwardStartBucket == Nothing)


{-| (112) Securities Cash Inflow Amount (§.33(e))
-}
match_rule_112_section_33_e : Other -> Bool
match_rule_112_section_33_e flow =
    List.member flow.product [ i_O_6, i_O_8 ]
        -- Maturity Bucket: <= 30 calendar days but not Open
        && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket && flow.maturityBucket /= MaturityBucket.open)
        -- Collateral Class: HQLA
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLA class) |> Maybe.withDefault False)
        -- Forward Start Amount: NULL
        && (flow.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (flow.forwardStartBucket == Nothing)
        -- Treasury Control: N
        && (flow.treasuryControl == False)


{-| (135) Broker-Dealer Segregated Account Inflow Amount (§.33(g))
-}
match_rule_135_section_33_g : Other -> Bool
match_rule_135_section_33_g flow =
    List.member flow.product [ i_O_5 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket


{-| (136) Other Cash Inflow Amount (§.33(h))
-}
match_rule_136_section_33_h : Other -> Bool
match_rule_136_section_33_h flow =
    List.member flow.product [ i_O_9 ]
        -- Maturity Bucket: <= 30 calendar days but not Open
        && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket && flow.maturityBucket /= MaturityBucket.open)
        -- Forward Start Amount: NULL
        && (flow.forwardStartAmount == Nothing)
        -- Forward Start Bucket: NULL
        && (flow.forwardStartBucket == Nothing)
