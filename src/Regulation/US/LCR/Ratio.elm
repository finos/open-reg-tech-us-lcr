module Regulation.US.LCR.Ratio exposing (..)


type Ratio
    = Ratio Int Int


unit : Ratio
unit =
    Ratio 1 1


percent : Int -> Ratio
percent n =
    Ratio n 100


applyTo : Float -> Ratio -> Float
applyTo value (Ratio numerator denominator) =
    (value * toFloat numerator) / toFloat denominator
