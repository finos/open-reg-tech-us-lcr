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


module Regulation.US.FR2052A.Fields.MaturityBucket exposing (..)

--type MaturityBucket
--    = Open
--    | Day Int


type MaturityBucket
    = Open
    | Day Int
    | DayRange Int Int
    | YearRange Int Int
    | YearAbove Int
    | Perpetual


isLessThanOrEqual30Days : Int -> MaturityBucket -> Bool
isLessThanOrEqual30Days fromDate maturityBucket =
    case maturityBucket of
        Day n ->
            n - fromDate <= 30

        _ ->
            False


isGreaterThan30Days : Int -> MaturityBucket -> Bool
isGreaterThan30Days fromDate maturityBucket =
    case maturityBucket of
        Day n ->
            n - fromDate > 30

        _ ->
            True


isOpen : MaturityBucket -> Bool
isOpen maturityBucket =
    maturityBucket == Open



--fromInt : Int -> MaturityBucket
--fromInt days =
--    days
