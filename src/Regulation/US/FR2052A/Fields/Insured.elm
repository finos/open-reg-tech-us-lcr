module Regulation.US.FR2052A.Fields.Insured exposing (..)

{-| The enums are based on the "FR 2052a Instructions" document and the LIQUIDITYRISK2.AGG\_5G\_CASHFLOWS
table (nyqd\_liquidityrisk\_ate).
-}


type Insured
    = FDIC
    | Other
    | Uninsured


isFDICInsured : Insured -> Bool
isFDICInsured insured =
    insured == FDIC
