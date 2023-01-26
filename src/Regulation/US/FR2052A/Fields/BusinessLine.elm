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

module Regulation.US.FR2052A.Fields.BusinessLine exposing (..)

{-|
 This field is applicable to all tables except the Supplemental-LRM and Comments tables. U.S.
 firms that are identified as Category I banking organizations are required to report this field.
 Use this field to designate the business line responsible for or associated with all applicable
 exposures. Coordinate with the supervisory team to determine the appropriate representative
 values for this field.
 -}
type alias BusinessLine = String