module Regulation.US.LCR.InflowValues exposing (..)

import Regulation.US.FR2052A.DataTables as DataTables
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket)
import Regulation.US.LCR.Basics exposing (Balance)


inflow_values_corresponding_to_33c_d_e_f : DataTables.Inflows -> MaturityBucket -> Balance
inflow_values_corresponding_to_33c_d_e_f data maturityBucket =
    -- TODO
    1.0
