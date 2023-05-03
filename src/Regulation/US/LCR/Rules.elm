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


module Regulation.US.LCR.Rules exposing (..)

import Regulation.US.LCR.Basics exposing (Balance)


type alias Weight =
    Float


type alias RuleName =
    String


type alias RuleBalance =
    { rule : RuleName
    , amount : Balance
    }


findAll : List RuleName -> List RuleBalance -> List RuleBalance
findAll rules flows =
    flows
        |> List.filter (\ruleBalance -> List.member ruleBalance.rule rules)


matchAndSum : List String -> List RuleBalance -> Balance
matchAndSum rules flows =
    findAll rules flows
        |> List.map .amount
        |> List.sum


orElse : Maybe b -> Maybe b -> Maybe b
orElse check fallback =
    case check of
        Just value ->
            Just value

        Nothing ->
            fallback
