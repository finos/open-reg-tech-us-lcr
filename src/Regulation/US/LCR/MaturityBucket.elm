module Regulation.US.LCR.MaturityBucket exposing (..)


type MaturityBucket
    = Open
    | Day Int
    | DayRange Int Int
    | YearRange Int Int
    | YearAbove Int
    | Perpetual


isLessThanOrEqual30Days : MaturityBucket -> Bool
isLessThanOrEqual30Days maturityBucket =
    case maturityBucket of
        Day n ->
            n <= 30

        _ ->
            False
