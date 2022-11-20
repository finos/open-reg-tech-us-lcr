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


module Regulation.US.LCR.Calculations exposing (..)

import Basics
import Regulation.US.FR2052A.DataTables as DataTables exposing (DataTables, Inflows)
import Regulation.US.LCR.Basics exposing (Balance, Ratio)
import Regulation.US.LCR.Flows as Flows exposing (..)
import Regulation.US.LCR.HQLAAmountValues as HQLAAmountValues exposing (..)
import Regulation.US.LCR.Rules as Rules



{-
   Formulas from: https://www.federalreserve.gov/reportforms/formsreview/Appendix%20VI%20and%20VII.pdf
-}


lcr : BankCategory -> DataTables -> Ratio
lcr bankCategory data =
    let
        hqla_amount : Balance
        hqla_amount =
            (level_1_HQLA_additive_values - level_1_HQLA_subtractive_values)
                + (0.85 * (level_2A_HQLA_additive_values - level_2A_HQLA_subtractive_values))
                + (0.5 * (level_2B_HQLA_additive_values - level_2A_HQLA_additive_values))
                + max unadjusted_excess_HQLA adjusted_excess_HQLA

        unadjusted_excess_HQLA : Balance
        unadjusted_excess_HQLA =
            level_2_cap_excess_amount + level_2B_cap_excess_amount

        level_2_cap_excess_amount : Balance
        level_2_cap_excess_amount =
            max 0
                (0.85 * (level_2A_HQLA_additive_values - level_2A_HQLA_subtractive_values))
                + (0.5 * (level_2B_HQLA_additive_values - level_2B_HQLA_subtractive_values))
                - (0.6667 * (level_1_HQLA_additive_values - level_1_HQLA_subtractive_values))

        level_2B_cap_excess_amount : Balance
        level_2B_cap_excess_amount =
            max 0
                (0.5 * (level_2B_HQLA_additive_values - level_2B_HQLA_subtractive_values))
                - level_2_cap_excess_amount
                + (0.1765 * (level_1_HQLA_additive_values - level_1_HQLA_subtractive_values))
                - (0.85 * (level_2A_HQLA_additive_values - level_2A_HQLA_subtractive_values))

        adjusted_level_1_HQLA_additive_values : Balance
        adjusted_level_1_HQLA_additive_values =
            level_1_HQLA_additive_values
                + secured_lending_unwind_maturity_amounts
                - secured_lending_unwind_collateral_values_with_level_1_collateral_class
                - secured_funding_unwind_maturity_amounts
                + secured_funding_unwind_collateral_values_with_level_1_collateral_class
                + asset_exchange_unwind_maturity_amounts_with_level_1_subProduct
                - asset_exchange_unwind_collateral_values_with_level_1_collateral_class

        adjusted_Level2A_HQLA_additive_Values : Balance
        adjusted_Level2A_HQLA_additive_Values =
            level_2A_HQLA_additive_values
                - secured_lending_unwind_collateral_values_with_level_2A_collateral_class
                + secured_funding_unwind_collateral_values_with_level_2A_collateral_class
                + asset_exchange_unwind_maturity_amounts_with_level_2A_subProduct
                - asset_exchange_unwind_collateral_values_with_level_2A_collateral_class

        adjusted_Level2B_HQLA_additive_Values : Balance
        adjusted_Level2B_HQLA_additive_Values =
            level_2B_HQLA_additive_values
                - secured_lending_unwind_collateral_values_with_level_2B_collateral_class
                + secured_funding_unwind_collateral_values_with_level_2B_collateral_class
                + asset_exchange_unwind_maturity_amounts_with_level_2B_subProduct
                - asset_exchange_unwind_collateral_values_with_level_2B_collateral_class

        adjusted_excess_HQLA : Balance
        adjusted_excess_HQLA =
            adjusted_level2_cap_excess_amount + adjusted_level2B_cap_excess_amount

        adjusted_level2_cap_excess_amount : Balance
        adjusted_level2_cap_excess_amount =
            Basics.max 0
                (0.85 * (adjusted_Level2A_HQLA_additive_Values - level_2A_HQLA_subtractive_values))
                + (0.5 * (adjusted_Level2B_HQLA_additive_Values - level_2B_HQLA_subtractive_values))
                - (0.6667 * (adjusted_level_1_HQLA_additive_values - level_1_HQLA_subtractive_values))

        adjusted_level2B_cap_excess_amount : Balance
        adjusted_level2B_cap_excess_amount =
            Basics.max 0
                (0.5 * (adjusted_Level2B_HQLA_additive_Values - level_2B_HQLA_subtractive_values))
                - adjusted_level2_cap_excess_amount
                - (0.1765
                    * (adjusted_level_1_HQLA_additive_values - level_1_HQLA_subtractive_values)
                    + (0.85 * (adjusted_Level2A_HQLA_additive_Values - level_2A_HQLA_subtractive_values))
                  )

        total_net_cash_outflows : Balance
        total_net_cash_outflows =
            --let
            --outflows_summed : Float
            --outflows_summed =
            --    List.map (\o -> second o) (Flows.outflowRules data.outflows)
            --        |> List.sum
            --
            --inflows_summed : Float
            --inflows_summed =
            --    List.map (\o -> second o) (Flows.inflowRules data.inflows)
            --        |> List.sum
            --in
            outflow_adjustment_percentage bankCategory
                * (outflow_values
                    - min (inflow_values * respective_inflow_rates)
                        (0.75 * (outflow_values * respective_outflow_rates))
                    + maturity_mismatch_add_on
                  )

        maturity_mismatch_add_on : Balance
        maturity_mismatch_add_on =
            max 0 (largest_net_cumulative_maturity_outflow_amount data)
                - max 0 (net_day30_cumulative_maturity_outflow_amount data)

        --let
        --    cum_outflow : Balance
        --    cum_outflow =
        --        max 0 (net_day30_cumulative_maturity_outflow_amount out inf)
        --
        --    largest_outflow : Balance
        --    largest_outflow =
        --        max 0 (largest_net_cumulative_maturity_outflow_amount out inf)
        --in
        --largest_outflow - cum_outflow
        ---- Missing Functions
        level_1_HQLA_additive_values : Balance
        level_1_HQLA_additive_values =
            HQLAAmountValues.level_1_HQLA_additive_values data

        level_2A_HQLA_additive_values : Balance
        level_2A_HQLA_additive_values =
            HQLAAmountValues.level_2A_HQLA_additive_values data

        level_2B_HQLA_additive_values : Balance
        level_2B_HQLA_additive_values =
            HQLAAmountValues.level_2B_HQLA_additive_values data

        level_1_HQLA_subtractive_values : Balance
        level_1_HQLA_subtractive_values =
            HQLAAmountValues.level_1_HQLA_additive_values data

        level_2A_HQLA_subtractive_values : Balance
        level_2A_HQLA_subtractive_values =
            HQLAAmountValues.level_2A_HQLA_additive_values data

        level_2B_HQLA_subtractive_values : Balance
        level_2B_HQLA_subtractive_values =
            HQLAAmountValues.level_2B_HQLA_additive_values data

        secured_lending_unwind_maturity_amounts : Balance
        secured_lending_unwind_maturity_amounts =
            HQLAAmountValues.secured_lending_unwind_maturity_amounts data

        secured_lending_unwind_collateral_values_with_level_1_collateral_class : Balance
        secured_lending_unwind_collateral_values_with_level_1_collateral_class =
            HQLAAmountValues.secured_lending_unwind_collateral_values_with_level_1_collateral_class data

        secured_funding_unwind_maturity_amounts : Balance
        secured_funding_unwind_maturity_amounts =
            HQLAAmountValues.secured_funding_unwind_maturity_amounts data

        secured_funding_unwind_collateral_values_with_level_1_collateral_class : Balance
        secured_funding_unwind_collateral_values_with_level_1_collateral_class =
            HQLAAmountValues.secured_funding_unwind_collateral_values_with_level_1_collateral_class data

        asset_exchange_unwind_maturity_amounts_with_level_1_subProduct : Balance
        asset_exchange_unwind_maturity_amounts_with_level_1_subProduct =
            HQLAAmountValues.asset_exchange_unwind_maturity_amounts_with_level_1_subProduct data

        asset_exchange_unwind_collateral_values_with_level_1_collateral_class : Balance
        asset_exchange_unwind_collateral_values_with_level_1_collateral_class =
            HQLAAmountValues.asset_exchange_unwind_collateral_values_with_level_1_collateral_class data

        secured_lending_unwind_collateral_values_with_level_2A_collateral_class : Balance
        secured_lending_unwind_collateral_values_with_level_2A_collateral_class =
            HQLAAmountValues.secured_lending_unwind_collateral_values_with_level_2A_collateral_class data

        secured_funding_unwind_collateral_values_with_level_2A_collateral_class : Balance
        secured_funding_unwind_collateral_values_with_level_2A_collateral_class =
            HQLAAmountValues.secured_funding_unwind_collateral_values_with_level_2A_collateral_class data

        asset_exchange_unwind_maturity_amounts_with_level_2A_subProduct : Balance
        asset_exchange_unwind_maturity_amounts_with_level_2A_subProduct =
            HQLAAmountValues.asset_exchange_unwind_maturity_amounts_with_level_2A_subProduct data

        asset_exchange_unwind_collateral_values_with_level_2A_collateral_class : Balance
        asset_exchange_unwind_collateral_values_with_level_2A_collateral_class =
            HQLAAmountValues.asset_exchange_unwind_collateral_values_with_level_2A_collateral_class data

        secured_lending_unwind_collateral_values_with_level_2B_collateral_class : Balance
        secured_lending_unwind_collateral_values_with_level_2B_collateral_class =
            HQLAAmountValues.secured_lending_unwind_collateral_values_with_level_2B_collateral_class data

        secured_funding_unwind_collateral_values_with_level_2B_collateral_class : Balance
        secured_funding_unwind_collateral_values_with_level_2B_collateral_class =
            HQLAAmountValues.secured_funding_unwind_collateral_values_with_level_2B_collateral_class data

        asset_exchange_unwind_maturity_amounts_with_level_2B_subProduct : Balance
        asset_exchange_unwind_maturity_amounts_with_level_2B_subProduct =
            HQLAAmountValues.asset_exchange_unwind_maturity_amounts_with_level_2B_subProduct data

        asset_exchange_unwind_collateral_values_with_level_2B_collateral_class : Balance
        asset_exchange_unwind_collateral_values_with_level_2B_collateral_class =
            HQLAAmountValues.asset_exchange_unwind_collateral_values_with_level_2B_collateral_class data

        inflow_values : Balance
        inflow_values =
            1

        respective_inflow_rates : Balance
        respective_inflow_rates =
            1

        outflow_values : Balance
        outflow_values =
            1

        respective_outflow_rates : Balance
        respective_outflow_rates =
            1
    in
    hqla_amount / total_net_cash_outflows


cumulative_outflow_amount_from_one_to_m : Int -> DataTables -> Balance
cumulative_outflow_amount_from_one_to_m m data =
    let
        applicable_buckets : List Int
        applicable_buckets =
            List.range 1 m

        --maturity_buckets : Dict MaturityBucket (List Outflows)
        --maturity_buckets =
        --    Dict.empty
        --
        --outflows_flattened : List Outflows
        --outflows_flattened =
        --    deconstruct_outflows out
        outflow_amount : Balance
        outflow_amount =
            Flows.outflowRules data.outflows
                |> Rules.matchAndSum
                    [ "32(g)(1)"
                    , "32(g)(2)"
                    , "32(g)(3)"
                    , "32(g)(4)"
                    , "32(g)(5)"
                    , "32(g)(6)"
                    , "32(g)(7)"
                    , "32(g)(8)"
                    , "32(g)(9)"
                    , "32(h)(1)"
                    , "32(h)(2)"
                    , "32(h)(5)"
                    , "32(j)"
                    , "32(k)"
                    , "32(l)"
                    ]

        inflow_amount : Balance
        inflow_amount =
            Flows.inflowRules data.inflows
                |> Rules.matchAndSum [ "33(c)", "33(d)", "33(e)", "33(f)" ]
    in
    outflow_amount - inflow_amount


largest_net_cumulative_maturity_outflow_amount : DataTables -> Balance
largest_net_cumulative_maturity_outflow_amount data =
    let
        maturityBuckets : List Int
        maturityBuckets =
            List.range 1 30

        cumulative_outflows : List Balance
        cumulative_outflows =
            List.map (\m -> cumulative_outflow_amount_from_one_to_m m data) maturityBuckets

        max_val : Maybe Balance
        max_val =
            List.maximum cumulative_outflows
    in
    case max_val of
        Just v ->
            v

        Nothing ->
            -1


net_day30_cumulative_maturity_outflow_amount : DataTables -> Balance
net_day30_cumulative_maturity_outflow_amount data =
    cumulative_outflow_amount_from_one_to_m 30 data



---------- Other


{-| Helper function to accumulated steps of a sum across a list. This is used in calculating the maturity mismatch add-on.
-}
accumulate : number -> List number -> List number
accumulate starter list =
    let
        ( sum, acc ) =
            List.foldl (\y ( x, xs ) -> ( x + y, (x + y) :: xs )) ( starter, [] ) list
    in
    List.reverse acc


type BankCategory
    = Global_systemically_important_BHC_or_GSIB_depository_institution
    | Category_II_Board_regulated_institution
    | Category_III_Board_regulated_institution_75_billion_or_more
    | Category_III_Board_regulated_institution_less_than_75_billion
    | Category_IV_Board_regulated_institution


outflow_adjustment_percentage : BankCategory -> Float
outflow_adjustment_percentage bankCategory =
    case bankCategory of
        Global_systemically_important_BHC_or_GSIB_depository_institution ->
            1.0

        Category_II_Board_regulated_institution ->
            1.0

        Category_III_Board_regulated_institution_75_billion_or_more ->
            1.0

        Category_III_Board_regulated_institution_less_than_75_billion ->
            0.85

        Category_IV_Board_regulated_institution ->
            0.7
