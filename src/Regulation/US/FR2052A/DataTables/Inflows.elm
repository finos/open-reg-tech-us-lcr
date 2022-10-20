module Regulation.US.FR2052A.DataTables.Inflows exposing (..)


import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (Assets)
import Regulation.US.FR2052A.DataTables.Inflows.Unsecured exposing (Unsecured)
import Regulation.US.FR2052A.DataTables.Inflows.Secured exposing (Secured)
import Regulation.US.FR2052A.DataTables.Inflows.Other exposing (Other)


type Inflows
    = Assets Assets
    | Unsecured Unsecured
    | Secured Secured
    | Other Other