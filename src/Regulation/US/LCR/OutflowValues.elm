module Regulation.US.LCR.OutflowValues exposing (..)

import Regulation.US.FR2052A.DataTables as Datatables
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket)
import Regulation.US.LCR.Basics exposing (Balance)


outflow_values_corresponding_to_33g_h1_h2_h5_j_k_l : Datatables.Outflows -> MaturityBucket -> Balance
outflow_values_corresponding_to_33g_h1_h2_h5_j_k_l data maturity =
    -- TODO
    1.0
