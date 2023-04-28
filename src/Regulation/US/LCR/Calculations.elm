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

import Regulation.US.FR2052A.DataTables as DataTables exposing (DataTables, Inflows)
import Regulation.US.LCR.AggregatedRuleBalances as Agg exposing (..)
import Regulation.US.LCR.Basics exposing (Balance, Ratio)
import Regulation.US.LCR.HQLAAmountValues as HQLAAmountValues exposing (..)
import Regulation.US.LCR.MaturityBucket exposing (FromDate)
import Regulation.US.LCR.Rules as Rules



{-
   Formulas from: https://www.federalreserve.gov/reportforms/formsreview/Appendix%20VI%20and%20VII.pdf
-}


{-| The lcr function is the top-most calculation for executing the Liquidity Coverage Ratio.
-}
lcr : BankCategory -> DataTables -> Float
lcr bankCategory data =
    hqla_amount data / total_net_cash_outflows data bankCategory


{-| Calculates the High Quality Liquid Assets (HQLA) to be considered for the numerator of the LCR.

see: <https://www.federalreserve.gov/reportforms/forms/FR_2052a20220429_f.pdf#APPENDIX+VI:+LCR+to+FR+2052a+Mapping>

-}
hqla_amount : DataTables -> Float
hqla_amount data =
    (level_1_HQLA_additive_values t0 data - level_1_HQLA_subtractive_values data)
        + (0.85 * (level_2A_HQLA_additive_values t0 data - level_2A_HQLA_subtractive_values data))
        + (0.5 * (level_2B_HQLA_additive_values t0 data - level_2A_HQLA_additive_values t0 data))
        + max (unadjusted_excess_HQLA data) (adjusted_excess_HQLA data)


unadjusted_excess_HQLA : DataTables -> Balance
unadjusted_excess_HQLA data =
    level_2_cap_excess_amount data + level_2B_cap_excess_amount data


level_2_cap_excess_amount : DataTables -> Balance
level_2_cap_excess_amount data =
    max 0
        (0.85 * (level_2A_HQLA_additive_values t0 data - level_2A_HQLA_subtractive_values data))
        + (0.5 * (level_2B_HQLA_additive_values t0 data - level_2B_HQLA_subtractive_values data))
        - (0.6667 * (level_1_HQLA_additive_values t0 data - level_1_HQLA_subtractive_values data))


level_2B_cap_excess_amount : DataTables -> Balance
level_2B_cap_excess_amount data =
    max 0
        (0.5 * (level_2B_HQLA_additive_values t0 data - level_2B_HQLA_subtractive_values data))
        - level_2_cap_excess_amount data
        + (0.1765 * (level_1_HQLA_additive_values t0 data - level_1_HQLA_subtractive_values data))
        - (0.85 * (level_2A_HQLA_additive_values t0 data - level_2A_HQLA_subtractive_values data))


adjusted_level_1_HQLA_additive_values : DataTables -> Balance
adjusted_level_1_HQLA_additive_values data =
    level_1_HQLA_additive_values t0 data
        + secured_lending_unwind_maturity_amounts t0 data
        - secured_lending_unwind_collateral_values_with_level_1_collateral_class t0 data
        - secured_funding_unwind_maturity_amounts t0 data
        + secured_funding_unwind_collateral_values_with_level_1_collateral_class t0 data
        + asset_exchange_unwind_maturity_amounts_with_level_1_subProduct t0 data
        - asset_exchange_unwind_collateral_values_with_level_1_collateral_class t0 data


adjusted_level_2A_HQLA_additive_values : DataTables -> Balance
adjusted_level_2A_HQLA_additive_values data =
    level_2A_HQLA_additive_values t0 data
        - secured_lending_unwind_collateral_values_with_level_2A_collateral_class t0 data
        + secured_funding_unwind_collateral_values_with_level_2A_collateral_class t0 data
        + asset_exchange_unwind_maturity_amounts_with_level_2A_subProduct t0 data
        - asset_exchange_unwind_collateral_values_with_level_2A_collateral_class t0 data


adjusted_level_2B_HQLA_additive_values : DataTables -> Balance
adjusted_level_2B_HQLA_additive_values data =
    level_2B_HQLA_additive_values t0 data
        - secured_lending_unwind_collateral_values_with_level_2B_collateral_class t0 data
        + secured_funding_unwind_collateral_values_with_level_2B_collateral_class t0 data
        + asset_exchange_unwind_maturity_amounts_with_level_2B_subProduct t0 data
        - asset_exchange_unwind_collateral_values_with_level_2B_collateral_class t0 data


adjusted_excess_HQLA : DataTables -> Balance
adjusted_excess_HQLA data =
    adjusted_level_2_cap_excess_amount data + adjusted_level_2B_cap_excess_amount data


adjusted_level_2_cap_excess_amount : DataTables -> Balance
adjusted_level_2_cap_excess_amount data =
    max 0
        (0.85 * (adjusted_level_2A_HQLA_additive_values data - level_2A_HQLA_subtractive_values data))
        + (0.5 * (adjusted_level_2B_HQLA_additive_values data - level_2B_HQLA_subtractive_values data))
        - (0.6667 * (adjusted_level_1_HQLA_additive_values data - level_1_HQLA_subtractive_values data))


adjusted_level_2B_cap_excess_amount : DataTables -> Balance
adjusted_level_2B_cap_excess_amount data =
    max 0
        (0.5 * (adjusted_level_2B_HQLA_additive_values data - level_2B_HQLA_subtractive_values data))
        - adjusted_level_2_cap_excess_amount data
        - (0.1765
            * (adjusted_level_1_HQLA_additive_values data - level_1_HQLA_subtractive_values data)
            + (0.85 * (adjusted_level_2A_HQLA_additive_values data - level_2A_HQLA_subtractive_values data))
          )


{-| Calculates the Total Net Cash Outflows to be considered for the denominator of the LCR.

see: <https://www.federalreserve.gov/reportforms/forms/FR_2052a20220429_f.pdf#APPENDIX+VI:+LCR+to+FR+2052a+Mapping>

-}
total_net_cash_outflows : DataTables -> BankCategory -> Float
total_net_cash_outflows data bankCategory =
    outflow_adjustment_percentage bankCategory
        * (outflow_values t0 data.outflows
            - min (inflow_values t0 data.inflows) (0.75 * outflow_values t0 data.outflows)
            + maturity_mismatch_add_on data
          )


maturity_mismatch_add_on : DataTables -> Balance
maturity_mismatch_add_on data =
    max 0 (largest_net_cumulative_maturity_outflow_amount data)
        - max 0 (net_day30_cumulative_maturity_outflow_amount data)


cumulative_outflow_amount_from_one_to_m : Int -> DataTables -> Balance
cumulative_outflow_amount_from_one_to_m m data =
    let
        applicable_buckets : List Int
        applicable_buckets =
            List.range 1 m

        --TODO apply accumulation over maturity buckets
        outflow_amount : FromDate -> Balance
        outflow_amount fromDate =
            Agg.applyOutflowRules fromDate data.outflows
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

        inflow_amount : FromDate -> Balance
        inflow_amount fromDate =
            Agg.applyInflowRules fromDate data.inflows
                |> Rules.matchAndSum
                    [ "33(c)"
                    , "33(d)"
                    , "33(e)"
                    , "33(f)"
                    ]
    in
    -- todo : Fix this logic
    applicable_buckets
        |> List.map (\fromDate -> outflow_amount fromDate - inflow_amount fromDate)
        |> List.sum


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


{-| The date for which the LCR is being calculated. Part of the specification requires looking into the next
30 days of cash flows, so t0 represents day 0.
-}
t0 : FromDate
t0 =
    0
