module Regulation.US.LCR.AmountCalculations exposing (..)

import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass exposing (CollateralClass)
import Regulation.US.FR2052A.Fields.CollateralValue exposing (CollateralValue)
import Regulation.US.FR2052A.Fields.MarketValue exposing (MarketValue)


{-| For the purpose of all tables mapped to commitment outflow amounts in section .32(e), the Collateral Value field
should be used to identify the amount of Level 1 or Level 2A HQLA securing the commitment exposure in accordance with
sections .32(e)(2) and (3).
-}
note_4 : Maybe CollateralClass -> Maybe CollateralValue -> Float -> Float
note_4 maybeCollateralClass maybeCollateralValue amount =
    case ( maybeCollateralClass, maybeCollateralValue ) of
        ( Just collateralClass, Just collateralValue ) ->
            if collateralClass == CollateralClass.g_2_Q then
                amount - (collateralValue * 0.85)

            else if collateralClass == CollateralClass.s_1_Q then
                amount - collateralValue

            else
                amount

        _ ->
            amount


{-| To the extent the Collateral Value is less than the Maturity Amount, treat the Maturity Amount less the Collateral
Value amount as unsecured wholesale lending under .33(d)
-}
excludeUnsecuredWholesaleLending : Float -> CollateralValue -> Float
excludeUnsecuredWholesaleLending amount collateralValue =
    min amount collateralValue


{-| To the extent the Collateral Value is less than the Maturity Amount, treat the Maturity Amount less the Collateral
Value amount as unsecured wholesale lending under .33(d)
-}
unsecuredWholesaleLending : Float -> CollateralValue -> Float
unsecuredWholesaleLending amount collateralValue =
    if amount > collateralValue then
        amount - collateralValue

    else
        0
