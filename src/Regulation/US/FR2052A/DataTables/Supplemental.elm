module Regulation.US.FR2052A.DataTables.Supplemental exposing (..)


import Regulation.US.FR2052A.DataTables.Supplemental.Informational exposing (Informational)
import Regulation.US.FR2052A.DataTables.Supplemental.DerivativesCollateral exposing (DerivativesCollateral)
import Regulation.US.FR2052A.DataTables.Supplemental.LiquidityRiskMeasurement exposing (LiquidityRiskMeasurement)
import Regulation.US.FR2052A.DataTables.Supplemental.BalanceSheet exposing (BalanceSheet)
import Regulation.US.FR2052A.DataTables.Supplemental.ForeignExchange exposing (ForeignExchange)


type Supplemental
    = Informational Informational
    | DerivativesCollateral DerivativesCollateral
    | LiquidityRiskMeasurement LiquidityRiskMeasurement
    | BalanceSheet BalanceSheet
    | ForeignExchange ForeignExchange