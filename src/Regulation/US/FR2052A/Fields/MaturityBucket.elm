module Regulation.US.FR2052A.Fields.MaturityBucket exposing (..)


type MaturityBucket
    = Open
    | Day Int


isOpen : MaturityBucket -> Bool
isOpen maturityBucket =
    case maturityBucket of
        Open ->
            True

        _ ->
            False


isGreaterThan30Days : MaturityBucket -> Bool
isGreaterThan30Days maturityBucket =
    case maturityBucket of
        Day n ->
            n > 30

        _ ->
            False


isLessThanOrEqual30Days : MaturityBucket -> Bool
isLessThanOrEqual30Days maturityBucket =
    case maturityBucket of
        Day n ->
            n <= 30

        _ ->
            False


fromInt : Int -> MaturityBucket
fromInt days =
    case days of
        0 ->
            Open

        _ ->
            Day days
