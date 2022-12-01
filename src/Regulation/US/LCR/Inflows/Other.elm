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
apply_rules : List Other -> Float
apply_rules list =
    list
        |> List.map (\x -> apply_rule x)
        |> List.sum


orElse : Maybe b -> Maybe b -> Maybe b
orElse check fallback =
    case check of
        Just value ->
            Just value

        Nothing ->
            fallback


apply_rule : Other -> Float
apply_rule flow =
    rule_33_b flow
        |> orElse (rule_111_x_33_e flow)
        |> orElse (rule_112_x_33_e flow)
        |> orElse (rule_33_g flow)
        |> orElse (rule_33_h flow)
        |> Maybe.withDefault 0


{-| (103) Net Derivatives Cash Inflow Amount (§.33(b))
-}
rule_33_b : Other -> Maybe Float
rule_33_b flow =
    if List.member flow.product [ i_O_7 ] then
        Just flow.maturityAmount

    else
        Nothing


{-| (111) Securities Cash Inflow Amount (§.33(e))
-}
rule_111_x_33_e : Other -> Maybe Float
rule_111_x_33_e flow =
    if
        List.member flow.product [ i_O_6, i_O_8 ]
            -- Maturity Bucket: <= 30 calendar days but not Open
            && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket && flow.maturityBucket /= MaturityBucket.open)
            -- Collateral Class: Non-HQLA securities
            && (flow.collateralClass |> Maybe.map (\class -> not (CollateralClass.isHQLA class)) |> Maybe.withDefault False)
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just flow.maturityAmount

    else
        Nothing


{-| (112) Securities Cash Inflow Amount (§.33(e))
-}
rule_112_x_33_e : Other -> Maybe Float
rule_112_x_33_e flow =
    if
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
    then
        Just flow.maturityAmount

    else
        Nothing


{-| (135) Broker-Dealer Segregated Account Inflow Amount (§.33(g))
-}
rule_33_g : Other -> Maybe Float
rule_33_g flow =
    if
        List.member flow.product [ i_O_5 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket
    then
        Just flow.maturityAmount

    else
        Nothing


{-| (136) Other Cash Inflow Amount (§.33(h))
-}
rule_33_h : Other -> Maybe Float
rule_33_h flow =
    if
        List.member flow.product [ i_O_9 ]
            -- Maturity Bucket: <= 30 calendar days but not Open
            && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket && flow.maturityBucket /= MaturityBucket.open)
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just flow.maturityAmount

    else
        Nothing
