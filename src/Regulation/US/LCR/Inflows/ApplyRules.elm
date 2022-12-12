module Regulation.US.LCR.Inflows.ApplyRules exposing (..)

import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (Assets)
import Regulation.US.LCR.Basics exposing (Balance)
import Regulation.US.LCR.Inflows.Assets exposing (match_rule_107_section_33_d_1, match_rule_1_section_20_a_1, match_rule_1_section_20_a_1_C, match_rule_1_section_20_b_1, match_rule_1_section_20_c_1)


rule_1_section_20_a_1_C : List Assets -> Balance
rule_1_section_20_a_1_C assets =
    assets
        |> List.filter match_rule_1_section_20_a_1_C
        |> List.map .marketValue
        |> List.sum


rule_1_section_20_a_1 : List Assets -> Balance
rule_1_section_20_a_1 assets =
    assets
        |> List.filter match_rule_1_section_20_a_1
        |> List.map .marketValue
        |> List.sum


rule_1_section_20_b_1 : List Assets -> Balance
rule_1_section_20_b_1 assets =
    assets
        |> List.filter match_rule_1_section_20_b_1
        |> List.map .marketValue
        |> List.sum


rule_1_section_20_c_1 : List Assets -> Balance
rule_1_section_20_c_1 assets =
    assets
        |> List.filter match_rule_1_section_20_c_1
        |> List.map .marketValue
        |> List.sum


rule_107_section_33_d_1 : List Assets -> Balance
rule_107_section_33_d_1 assets =
    assets
        |> List.filter match_rule_107_section_33_d_1
        |> List.map .marketValue
        |> List.sum
