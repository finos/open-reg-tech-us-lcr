{-
   Copyright 2022 Morgan Stanley
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at
       http://www.apache.org/licenses/LICENSE-2.0
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-}

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