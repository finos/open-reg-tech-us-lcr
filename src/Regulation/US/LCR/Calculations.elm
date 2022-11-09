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

import Regulation.US.FR2052A.DataTables as DataTables exposing (..)
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket(..))
import Regulation.US.LCR.Basics exposing (Balance)
import Regulation.US.LCR.Flows as Flows exposing (..)
import Regulation.US.LCR.Rules as Rules



-- import Regulation.US.LCR.Supplemental.Rules as Rules
{-
   Formulas from: https://www.federalreserve.gov/reportforms/formsreview/Appendix%20VI%20and%20VII.pdf
-}
--fn_name LCR = ""
--
--fn_name HQLA_Amount = ""
--
--fn_name Unadjusted_Excess_HQLA = ""
--
--fn_name Level2_Cap_Excess_Amount = ""
--
--fn_name Level2B_Cap_Excess_Amount = ""
--
--fn_name Adjusted_Level1_HQLA_Additive_Values = ""
--
--fn_name Adjusted_Level2A_HQLA_Additive_Values = ""
--
--fn_name Adjusted_Level2B_HQLA_Additive_Values = ""
--
--fn_name Adjusted_Excess_HQLA = ""
--
--fn_name Adjusted_Level2_Cap_Excess_Amount = ""
--
--fn_name Adjusted_Level2B_Cap_Excess_Amount = ""
--
{-
   total_net_cash_outflows : Float -> DataTables.Outflows -> DataTables.Inflows -> Balance
   total_net_cash_outflows outflow_adjustment_percentage outflows inflows =
       let
           outflows_summed : Float
           outflows_summed = ((List.map(\o -> o.amount) (Outflows.outflowRules outflows)) |> List.sum)
           inflows_summed : Float
           inflows_summed = ((List.map(\o -> o.amount) (Inflows.inflowRules inflows)) |> List.sum)
       in
       outflow_adjustment_percentage * (outflows_summed - (min inflows_summed (0.75 * outflows_summed)) + maturity_Mismatch_Add_On outflows inflows)
-}
--
--fn_name Maturity_Mismatch_Add_On = ""


getDayFromMaturityBucket : MaturityBucket -> Int
getDayFromMaturityBucket bucket =
    case bucket of
        Day d ->
            d

        _ ->
            -1


type alias BucketRule =
    { rule : String
    , amount : Float
    , maturityBucket : MaturityBucket
    }


cumulative_outflow_amount_from_one_to_m : Int -> DataTables.Outflows -> DataTables.Inflows -> Balance
cumulative_outflow_amount_from_one_to_m m out inf =
    let
        dates : List Int
        dates =
            List.range 1 m

        outflow_rules : List Flow
        outflow_rules =
            Flows.outflowRules out
                |> Rules.findAll
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

        outflowAmount : Float
        outflowAmount =
            dates
                -- TODO : figure out how to take maturity bucket into account
                -- |> List.concatMap (\n -> List.filter (getDayFromMaturityBucket .maturityBucket == n) outflow_rules)
                |> List.concatMap (\n -> outflow_rules)
                |> List.map (\( rule, amount ) -> amount)
                |> List.sum

        inflow_rules : List Flow
        inflow_rules =
            Flows.inflowRules inf
                |> Rules.findAll [ "33(c)", "33(d)", "33(e)", "33(f)" ]

        inflowAmount : Float
        inflowAmount =
            dates
                -- TODO : figure out how to take maturity bucket into account
                -- |> List.concatMap (\n -> List.filter (getDayFromMaturityBucket .maturityBucket == n) inflow_rules)
                |> List.concatMap (\n -> inflow_rules)
                |> List.map (\( rule, amount ) -> amount)
                |> List.sum
    in
    outflowAmount - inflowAmount



{-
   net_day30_cumulative_maturity_outflow_amount : DataTables.Outflows -> DataTables.Inflows -> Balance
   net_day30_cumulative_maturity_outflow_amount out inf = cumulative_outflow_amount_from_one_to_m 30 out inf
   largest_net_cumulative_maturity_outflow_amount : DataTables.Outflows -> DataTables.Inflows -> Balance
   largest_net_cumulative_maturity_outflow_amount out inf =
           let
               maturityBuckets : List Int
               maturityBuckets = List.range 1 30
               cumulative_outflows : List Balance
               cumulative_outflows = List.map(\m -> cumulative_outflow_amount_from_one_to_m m out inf) maturityBuckets
               max_val : Maybe Balance
               max_val = List.maximum cumulative_outflows
           in
               case max_val of
                   Just v ->
                         v
                   Nothing -> -1
   maturity_Mismatch_Add_On : DataTables.Outflows -> DataTables.Inflows -> Balance
   maturity_Mismatch_Add_On out inf =
       let
           cum_outflow : Balance
           cum_outflow = max 0 (net_day30_cumulative_maturity_outflow_amount out inf)
           largest_outflow : Balance
           largest_outflow = max 0 (largest_net_cumulative_maturity_outflow_amount out inf)
       in
           largest_outflow - cum_outflow
-}


{-| Helper function to accumulated steps of a sum across a list. This is used in calculating the maturity mismatch add-on.
-}
accumulate : number -> List number -> List number
accumulate starter list =
    let
        ( sum, acc ) =
            List.foldl (\y ( x, xs ) -> ( x + y, (x + y) :: xs )) ( starter, [] ) list
    in
    List.reverse acc