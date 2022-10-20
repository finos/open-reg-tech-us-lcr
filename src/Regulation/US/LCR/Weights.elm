module Regulation.US.LCR.Weights exposing (..)

import Regulation.US.LCR.Ratio exposing (Ratio, percent, unit)
import Regulation.US.LCR.Rule exposing (Rule, eligibleLevel1LiquidAssets, eligibleLevel2ALiquidAssets, eligibleLevel2BLiquidAssets)


type alias Weight =
    Ratio


sectionWeight : Rule -> Weight
sectionWeight rule =
    if List.member rule eligibleLevel1LiquidAssets then
        percent 100

    else if List.member rule eligibleLevel2ALiquidAssets then
        percent 85

    else if List.member rule eligibleLevel2BLiquidAssets then
        percent 50

    else
        unit
