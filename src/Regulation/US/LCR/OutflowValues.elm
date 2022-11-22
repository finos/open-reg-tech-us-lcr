module Regulation.US.LCR.OutflowValues exposing (..)

import Regulation.US.FR2052A.DataTables as DataTables
import Regulation.US.FR2052A.Fields.MaturityBucket exposing (MaturityBucket)
import Regulation.US.LCR.Basics exposing (Balance)
import Regulation.US.LCR.Flows exposing (applyOutflowRules)



--outflow_values_corresponding_to_32g_32h1_32h2_32h5_32j_32k_32l : MaturityBucket -> DataTables.Outflows -> Balance
--outflow_values_corresponding_to_32g_32h1_32h2_32h5_32j_32k_32l maturity data =
--    -- TODO
--    1.0
--outflow_values : DataTables.Outflows -> MaturityBucket -> Balance
--outflow_values outflows maturityBucket =


outflow_values : DataTables.Outflows -> Balance
outflow_values outflows =
    applyOutflowRules outflows
        |> List.map (\( rule, amount ) -> amount)
        |> List.sum
