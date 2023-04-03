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
import Regulation.US.LCR.MaturityBucket exposing (FromDate)
import Regulation.US.LCR.Rule exposing (applyRule)
import Regulation.US.LCR.Rules exposing (RuleBalance)


{-| Given a list of Others, applies the applicable rule for each assets along with the relevant amount
-}
apply_rules : FromDate -> List Other -> Float
apply_rules fromDate list =
    list
        |> List.map (\x -> apply_rule fromDate x)
        |> List.sum


orElse : Maybe b -> Maybe b -> Maybe b
orElse check fallback =
    case check of
        Just value ->
            Just value

        Nothing ->
            fallback


apply_rule : FromDate -> Other -> Float
apply_rule fromDate flow =
    rule_33_b flow
        |> orElse (rule_111_x_33_e fromDate flow)
        |> orElse (rule_112_x_33_e fromDate flow)
        |> orElse (rule_33_g fromDate flow)
        |> orElse (rule_33_h fromDate flow)
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
rule_111_x_33_e : FromDate -> Other -> Maybe Float
rule_111_x_33_e fromDate flow =
    if
        List.member flow.product [ i_O_6, i_O_8 ]
            -- Maturity Bucket: <= 30 calendar days but not Open
            && (MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket && flow.maturityBucket /= MaturityBucket.Open)
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
rule_112_x_33_e : FromDate -> Other -> Maybe Float
rule_112_x_33_e fromDate flow =
    if
        List.member flow.product [ i_O_6, i_O_8 ]
            -- Maturity Bucket: <= 30 calendar days but not Open
            && (MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket && flow.maturityBucket /= MaturityBucket.Open)
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
rule_33_g : FromDate -> Other -> Maybe Float
rule_33_g fromDate flow =
    if
        List.member flow.product [ i_O_5 ]
            -- Maturity Bucket: <= 30 calendar days
            && MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket
    then
        Just flow.maturityAmount

    else
        Nothing


{-| (136) Other Cash Inflow Amount (§.33(h))
-}
rule_33_h : FromDate -> Other -> Maybe Float
rule_33_h fromDate flow =
    if
        List.member flow.product [ i_O_9 ]
            -- Maturity Bucket: <= 30 calendar days but not Open
            && (MaturityBucket.isLessThanOrEqual30Days fromDate flow.maturityBucket && flow.maturityBucket /= MaturityBucket.Open)
            -- Forward Start Amount: NULL
            && (flow.forwardStartAmount == Nothing)
            -- Forward Start Bucket: NULL
            && (flow.forwardStartBucket == Nothing)
    then
        Just flow.maturityAmount

    else
        Nothing
