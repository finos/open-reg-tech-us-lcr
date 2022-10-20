module Regulation.US.FR2052A.DataTables.Outflows exposing (..)


import Regulation.US.FR2052A.DataTables.Outflows.Deposits exposing (Deposits)
import Regulation.US.FR2052A.DataTables.Outflows.Wholesale exposing (Wholesale)
import Regulation.US.FR2052A.DataTables.Outflows.Secured exposing (Secured)
import Regulation.US.FR2052A.DataTables.Outflows.Other exposing (Other)


type Outflows
    = Deposits Deposits
    | Wholesale Wholesale
    | Secured Secured
    | Other Other