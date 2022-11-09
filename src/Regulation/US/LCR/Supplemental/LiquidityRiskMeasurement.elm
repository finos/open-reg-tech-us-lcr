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


module Regulation.US.LCR.Supplemental.LiquidityRiskMeasurement exposing (..)

import Regulation.US.FR2052A.DataTables as Flow
import Regulation.US.FR2052A.DataTables.Supplemental.LiquidityRiskMeasurement exposing (..)
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.LCR.Rule exposing (RuleFlow, applyRule)


applyRules : LiquidityRiskMeasurement -> List RuleFlow
applyRules flow =
    List.concat
        [ applyRule (match_rule_4_section_22_b_3_L1 flow) (RuleFlow "22(b)(3)L1" flow.marketValue (Flow.LiquidityRiskMeasurement flow))
        , applyRule (match_rule_4_section_22_b_3_L2a flow) (RuleFlow "22(b)(3)L2a" flow.marketValue (Flow.LiquidityRiskMeasurement flow))
        , applyRule (match_rule_4_section_22_b_3_L2b flow) (RuleFlow "22(b)(3)L2b" flow.marketValue (Flow.LiquidityRiskMeasurement flow))
        , applyRule (match_rule_5_section_22_a_3_L1 flow) (RuleFlow "22(a)(3)L1" flow.marketValue (Flow.LiquidityRiskMeasurement flow))
        , applyRule (match_rule_5_section_22_a_3_L2a flow) (RuleFlow "22(a)(3)L2a" flow.marketValue (Flow.LiquidityRiskMeasurement flow))
        , applyRule (match_rule_5_section_22_a_3_L2b flow) (RuleFlow "22(a)(3)L2b" flow.marketValue (Flow.LiquidityRiskMeasurement flow))
        , applyRule (match_rule_62_section_32_i_1 flow) (RuleFlow "32(i)(1)" flow.marketValue (Flow.LiquidityRiskMeasurement flow))
        , applyRule (match_rule_63_section_32_i_2 flow) (RuleFlow "32(i)(2)" flow.marketValue (Flow.LiquidityRiskMeasurement flow))
        ]


{-| (4) Excluded Sub HQLA (§.22(b)(3)and(4))
-}
match_rule_4_section_22_b_3_L1 : LiquidityRiskMeasurement -> Bool
match_rule_4_section_22_b_3_L1 flow =
    flow.product
        == s_L_1
        -- Collateral Class: A-0-Q; A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel1 class) |> Maybe.withDefault False)


{-| (4) Excluded Sub HQLA (§.22(b)(3)and(4))
-}
match_rule_4_section_22_b_3_L2a : LiquidityRiskMeasurement -> Bool
match_rule_4_section_22_b_3_L2a flow =
    flow.product
        == s_L_1
        -- Collateral Class: G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2A class) |> Maybe.withDefault False)


{-| (4) Excluded Sub HQLA (§.22(b)(3)and(4))
-}
match_rule_4_section_22_b_3_L2b : LiquidityRiskMeasurement -> Bool
match_rule_4_section_22_b_3_L2b flow =
    flow.product
        == s_L_1
        -- Collateral Class: E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class) |> Maybe.withDefault False)


{-| (5) Early Hedge Termination Outflows (§.22(a)(3))
-}
match_rule_5_section_22_a_3_L1 : LiquidityRiskMeasurement -> Bool
match_rule_5_section_22_a_3_L1 flow =
    List.member flow.product [ s_L_3 ]
        -- Collateral Class: A-0-Q; A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel1 class) |> Maybe.withDefault False)


{-| (5) Early Hedge Termination Outflows (§.22(a)(3))
-}
match_rule_5_section_22_a_3_L2a : LiquidityRiskMeasurement -> Bool
match_rule_5_section_22_a_3_L2a flow =
    List.member flow.product [ s_L_3 ]
        -- Collateral Class: G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2A class) |> Maybe.withDefault False)


{-| (5) Early Hedge Termination Outflows (§.22(a)(3))
-}
match_rule_5_section_22_a_3_L2b : LiquidityRiskMeasurement -> Bool
match_rule_5_section_22_a_3_L2b flow =
    List.member flow.product [ s_L_3 ]
        -- Collateral Class: E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
        && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class) |> Maybe.withDefault False)


{-| (62) Issued Not Structured Debt Securities Maturing Outside 30 Days when Primary Market Maker (§.32(i)(1))
-}
match_rule_62_section_32_i_1 : LiquidityRiskMeasurement -> Bool
match_rule_62_section_32_i_1 flow =
    List.member flow.product [ s_L_4 ]


{-| (63) Issued Structured Debt Securities Maturing Outside 30 Days when Primary Market Maker (§.32(i)(2))
-}
match_rule_63_section_32_i_2 : LiquidityRiskMeasurement -> Bool
match_rule_63_section_32_i_2 flow =
    List.member flow.product [ s_L_5 ]
