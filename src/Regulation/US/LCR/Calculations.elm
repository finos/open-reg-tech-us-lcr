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

import Morphir.SDK.Dict as Dict exposing (Dict)
import Regulation.US.FR2052A.DataTables as DataTables exposing (Inflows)
import Regulation.US.FR2052A.DataTables.Outflows as Outflows exposing (Outflows)
import Regulation.US.FR2052A.DataTables.Outflows.Deposits exposing (Deposits)
import Regulation.US.FR2052A.DataTables.Outflows.Other exposing (Other)
import Regulation.US.FR2052A.DataTables.Outflows.Secured exposing (Secured)
import Regulation.US.FR2052A.DataTables.Outflows.Wholesale exposing (Wholesale)
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket(..))
import Regulation.US.LCR.Basics exposing (Balance)
import Regulation.US.LCR.Flows as Flows exposing (..)
import Regulation.US.LCR.Rule exposing (Rule)
import Regulation.US.LCR.Rules as Rules
import Tuple exposing (second)



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
adjusted_Level2A_HQLA_Additive_Values :  Float -> Inflows -> DataTables.Outflows -> Inflows -> Inflows -> Float
adjusted_Level2A_HQLA_Additive_Values float securedLending securedFunding assetExchangeUnwind assetExunwindcollateral =
    let
        securedFunds: List Flow
        securedFunds =
                Flows.outflowRules securedFunding
                    |> Rules.findAll
                        ["21(b)(todo)"]
        securedFundings : Float
        securedFundings = List.map(\(u,v) -> v) securedFunds
                          |> List.sum
        securedLen : List Flow
        securedLen =
                          Flows.inflowRules securedLending
                              |> Rules.findAll
                                  [ "33(f)(1)(iv)"]
        securedlendings : Float
        securedlendings = List.map(\(v,u) -> u) securedLen
                        |> List.sum

        assetExchangeMat : List Flow
        assetExchangeMat =
            Flows.inflowRules assetExchangeUnwind
              |> Rules.findAll
                      [ "21(c)(todo)"]
        assetExchange : Float
        assetExchange = List.map(\(v,u) -> u) assetExchangeMat
                         |> List.sum
        assetCollateral : List Flow
        assetCollateral =
           Flows.inflowRules assetExunwindcollateral
             |> Rules.findAll
                   [ "33(f)(2)(i)"]
        assetExcahngeUnwindColl : Float
        assetExcahngeUnwindColl = List.map(\(v,u) -> u) assetCollateral
              |> List.sum
    in
        float  - securedlendings + securedFundings + assetExchange - assetExcahngeUnwindColl




        --securedFundings = List.filter(\flow -> flow.assetType == L2Assets)
        --                     |> List.map(\(v,u) -> u) securedFunds




    -- securedFunding L2A : 32(j)(1)(ii)
    --securedLending
    --Asset Exchange

-- output : lvl 2A HQLA - SecuredLending unwind + se
--

--adjusted_Level2B_HQLA_Additive_Values : Int -> DataTables.Outflows -> DataTables.Inflows -> Balance
--adjusted_Level2B_HQLA_Additive_Values int outflows inflows =
--  let
--      securedLen : List Flow
--      securedLen =
--       Flows.inflowRules Inflows
--           |> Rules.findAll
--              [ "33(f)(1)(v)"]

adjusted_Level2B_HQLA_Additive_Values : Float -> DataTables.Inflows -> DataTables.Outflows -> Inflows -> Inflows -> Float
adjusted_Level2B_HQLA_Additive_Values float securedLending securedFunding assetExchangeUnwind assetExunwindcollateral =

  let
          securedLen : List Flow
          securedLen =
                 Flows.inflowRules securedLending
                      |> Rules.findAll
                          [ "33(f)(1)(v)"]
          securedlendings : Float
          securedlendings = List.map(\(v,u) -> u) securedLen
                |> List.sum
          assetExchangeMat : List Flow
          assetExchangeMat =
                            Flows.inflowRules assetExchangeUnwind
                                |> Rules.findAll
                                    [ "21(c)(todo)"]
          assetExchange : Float
          assetExchange = List.map(\(v,u) -> u) assetExchangeMat
                          |> List.sum
          assetCollateral : List Flow
          assetCollateral =
                   Flows.inflowRules assetExunwindcollateral
                        |> Rules.findAll
                             [ "33(f)(2)(i)"]
          assetExcahngeUnwindColl : Float
          assetExcahngeUnwindColl = List.map(\(v,u) -> u) assetCollateral
                   |> List.sum
          securedFund : List Flow
          securedFund =
              Flows.outflowRules securedFunding
               |> Rules.findAll
                        ["21(b)(todo)"]
          securedFundings : Float
          securedFundings = List.map(\(u,v) -> v) securedFund
                   |> List.sum
  in
          float  - securedlendings + securedFundings + assetExchange - assetExcahngeUnwindColl






--fn_name Adjusted_Excess_HQLA = ""
--
--fn_name Adjusted_Level2_Cap_Excess_Amount = ""
--
--fn_name Adjusted_Level2B_Cap_Excess_Amount = ""
--


total_net_cash_outflows : Float -> DataTables.Outflows -> DataTables.Inflows -> Balance
total_net_cash_outflows outflow_adjustment_percentage outflows inflows =
    let
        outflows_summed : Float
        outflows_summed =
            List.map (\o -> second o) (Flows.outflowRules outflows) |> List.sum

        inflows_summed : Float
        inflows_summed =
            List.map (\o -> second o) (Flows.inflowRules inflows) |> List.sum
    in
    outflow_adjustment_percentage * (outflows_summed - min inflows_summed (0.75 * outflows_summed) + maturity_Mismatch_Add_On outflows inflows)


maturity_Mismatch_Add_On : DataTables.Outflows -> DataTables.Inflows -> Balance
maturity_Mismatch_Add_On out inf =
    let
        cum_outflow : Balance
        cum_outflow =
            max 0 (net_day30_cumulative_maturity_outflow_amount out inf)

        largest_outflow : Balance
        largest_outflow =
            max 0 (largest_net_cumulative_maturity_outflow_amount out inf)
    in
    largest_outflow - cum_outflow


cumulative_outflow_amount_from_one_to_m : Int -> DataTables.Outflows -> DataTables.Inflows -> Balance
cumulative_outflow_amount_from_one_to_m m out inf =
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
            applicable_buckets
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
            applicable_buckets
                -- TODO : figure out how to take maturity bucket into account
                -- |> List.concatMap (\n -> List.filter (getDayFromMaturityBucket .maturityBucket == n) inflow_rules)
                |> List.concatMap (\n -> inflow_rules)
                |> List.map (\( rule, amount ) -> amount)
                |> List.sum
    in
    outflowAmount - inflowAmount


largest_net_cumulative_maturity_outflow_amount : DataTables.Outflows -> DataTables.Inflows -> Balance
largest_net_cumulative_maturity_outflow_amount out inf =
    let
        maturityBuckets : List Int
        maturityBuckets =
            List.range 1 30

        cumulative_outflows : List Balance
        cumulative_outflows =
            List.map (\m -> cumulative_outflow_amount_from_one_to_m m out inf) maturityBuckets

        max_val : Maybe Balance
        max_val =
            List.maximum cumulative_outflows
    in
    case max_val of
        Just v ->
            v

        Nothing ->
            -1


net_day30_cumulative_maturity_outflow_amount : DataTables.Outflows -> DataTables.Inflows -> Balance
net_day30_cumulative_maturity_outflow_amount out inf =
    cumulative_outflow_amount_from_one_to_m 30 out inf



--deconstruct_outflows : DataTables.Outflows -> List Outflows
--deconstruct_outflows out =
--    let
--        deposits : List Deposits
--        deposits =
--            out.deposits
--
--        other : List Other
--        other =
--            out.other
--
--        secured : List Secured
--        secured =
--            out.secured
--
--        wholesale : List Wholesale
--        wholesale =
--            out.wholesale
--    in
--    List.concat
--        [ List.map (\d -> Outflows.Deposits d) deposits
--        , List.map (\o -> Outflows.Other o) other
--        , List.map (\s -> Outflows.Secured s) secured
--        , List.map (\w -> Outflows.Wholesale w) wholesale
--        ]
--maturity_buckets_dict_out : Dict MaturityBucket (List Outflows) -> Outflows -> Dict MaturityBucket (List Outflows)
--maturity_buckets_dict_out dict_out out =
--    let
--        maturity_bucket : MaturityBucket
--        maturity_bucket =
--            get_maturity_bucket_from_outflow out
--
--        outflows_for_bucket : List Outflows
--        outflows_for_bucket =
--            List.singleton out
--
--        outflows : Maybe (List Outflows)
--        outflows =
--            Dict.get maturity_bucket dict_out
--    in
--    case outflows of
--        Just o ->
--            Dict.insert maturity_bucket (out :: o) dict_out
--
--        Nothing ->
--            Dict.insert maturity_bucket outflows_for_bucket dict_out
--get_maturity_bucket_from_outflow : Outflows -> MaturityBucket
--get_maturity_bucket_from_outflow out =
--    case out of
--        Outflows.Deposits d ->
--            d.maturityBucket
--
--        Outflows.Other o ->
--            o.maturityBucket
--
--        Outflows.Secured s ->
--            s.maturityBucket
--
--        Outflows.Wholesale w ->
--            w.maturityBucket
--getDayFromMaturityBucket : MaturityBucket -> Int
--getDayFromMaturityBucket bucket =
--    case bucket of
--        Day d ->
--            d
--
--        _ ->
--            -1
--type alias BucketRule =
--    { rule : String
--    , amount : Float
--    , maturityBucket : MaturityBucket
--    }


{-| Helper function to accumulated steps of a sum across a list. This is used in calculating the maturity mismatch add-on.
-}
accumulate : number -> List number -> List number
accumulate starter list =
    let
        ( sum, acc ) =
            List.foldl (\y ( x, xs ) -> ( x + y, (x + y) :: xs )) ( starter, [] ) list
    in
    List.reverse acc
