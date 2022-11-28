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


module Regulation.US.FR2052A.Fields.CollateralClass exposing (..)

{-| Asset categories as described in FR 2025a Appendix III.
-}


type alias CollateralClass =
    String


type AssetCategory
    = Agency
    | Sovereigns
    | CentralBank
    | GovernmentSponsoredEntity
    | Equity
    | InvestmentGrade
    | NonInvestmentGrade
    | Loan
    | Debt
    | Commodities
    | Property
    | LetterOfCredit
    | Other


assetCategoryFromString : String -> Maybe AssetCategory
assetCategoryFromString assetString =
    case assetString of
        "A" ->
            Just Agency

        "S" ->
            Just Sovereigns

        "CB" ->
            Just CentralBank

        "G" ->
            Just GovernmentSponsoredEntity

        "E" ->
            Just Equity

        "IG" ->
            Just InvestmentGrade

        "N" ->
            Just NonInvestmentGrade

        "L" ->
            Just Loan

        "D" ->
            Just Debt

        "C" ->
            Just Commodities

        "P" ->
            Just Property

        "LC" ->
            Just LetterOfCredit

        "Z" ->
            Just Other

        _ ->
            Nothing


assetCategoryToString : AssetCategory -> String
assetCategoryToString assetCategory =
    case assetCategory of
        Agency ->
            "A"

        Sovereigns ->
            "S"

        CentralBank ->
            "CB"

        GovernmentSponsoredEntity ->
            "G"

        Equity ->
            "E"

        InvestmentGrade ->
            "IG"

        NonInvestmentGrade ->
            "N"

        Loan ->
            "L"

        Debt ->
            "D"

        Commodities ->
            "C"

        Property ->
            "P"

        LetterOfCredit ->
            "LC"

        Other ->
            "Z"


toString : CollateralClass -> String
toString collateralClass =
    --if hqla then
    --    String.join "-" [ assetCategoryToString assetCategory, String.fromInt index, "Q" ]
    --
    --else
    --    String.join "-" [ assetCategoryToString assetCategory, String.fromInt index ]
    collateralClass


fromString : String -> Maybe CollateralClass
fromString string =
    --case String.split "-" string of
    --    [ assetString, indexString, "Q" ] ->
    --        Maybe.map2 (\a i -> CollateralClass a i True)
    --            (assetCategoryFromString assetString)
    --            (String.toInt indexString)
    --
    --    [ assetString, indexString ] ->
    --        Maybe.map2 (\a i -> CollateralClass a i False)
    --            (assetCategoryFromString assetString)
    --            (String.toInt indexString)
    --
    --    _ ->
    --        Nothing
    Just string


isCash : CollateralClass -> Bool
isCash class =
    class == a_0_Q


isHQLALevel1 : CollateralClass -> Bool
isHQLALevel1 class =
    List.member class [ a_0_Q, a_1_Q, a_2_Q, a_3_Q, a_4_Q, a_5_Q, s_1_Q, s_2_Q, s_3_Q, s_4_Q, cB_1_Q, cB_2_Q ]


isHQLALevel2A : CollateralClass -> Bool
isHQLALevel2A class =
    List.member class [ g_1_Q, g_2_Q, g_3_Q, s_5_Q, s_6_Q, s_7_Q, cB_3_Q ]


isHQLALevel2B : CollateralClass -> Bool
isHQLALevel2B class =
    List.member class [ e_1_Q, e_2_Q, iG_1_Q, iG_2_Q ]


isHQLA : CollateralClass -> Bool
isHQLA class =
    isHQLALevel1 class || isHQLALevel2A class || isHQLALevel2B class


allClasses : List CollateralClass
allClasses =
    [ a_0_Q
    , a_1_Q
    , a_2_Q
    , a_3_Q
    , a_4_Q
    , a_5_Q
    , s_1_Q
    , s_2_Q
    , s_3_Q
    , s_4_Q
    , s_5_Q
    , s_6_Q
    , s_7_Q
    , cB_1_Q
    , cB_2_Q
    , cB_3_Q
    , g_1_Q
    , g_2_Q
    , g_3_Q
    , e_1_Q
    , e_2_Q
    , iG_1_Q
    , iG_2_Q
    , a_2
    , a_3
    , a_4
    , a_5
    , s_1
    , s_2
    , s_3
    , s_4
    , cB_1
    , cB_2
    , g_1
    , g_2
    , g_3
    , s_5
    , s_6
    , s_7
    , cB_3
    , e_1
    , e_2
    , iG_1
    , iG_2
    , s_8
    , g_4
    , e_3
    , e_4
    , e_5
    , e_6
    , e_7
    , e_8
    , e_9
    , e_10
    , n_1
    , n_2
    , n_3
    , n_4
    , n_5
    , n_6
    , n_7
    , n_8
    , l_1
    , l_2
    , l_3
    , l_4
    , l_5
    , l_6
    , l_7
    , l_8
    , l_9
    , l_10
    , l_11
    , l_12
    , y_1
    , y_2
    , y_3
    , y_4
    , c_1
    , p_1
    , p_2
    , z_1
    , iG_3
    , iG_4
    , iG_5
    , iG_6
    , iG_7
    , iG_8
    , lC_1
    , lC_2
    , cB_4
    ]


isOther : CollateralClass -> Bool
isOther collateralClass =
    List.member collateralClass allClasses
        |> not


{-| Cash
-}
a_0_Q : CollateralClass
a_0_Q =
    "A-0-Q"


{-| Debt issued by the U.S. Treasury
-}
a_1_Q : CollateralClass
a_1_Q =
    "A-1-Q"


{-| U.S. Government Agency-issued debt (excluding the US Treasury) with a US Government guarantee
-}
a_2_Q : CollateralClass
a_2_Q =
    "A-2-Q"


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_3_Q : CollateralClass
a_3_Q =
    "A-3-Q"


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_4_Q : CollateralClass
a_4_Q =
    "A-4-Q"


{-| Other debt with a U.S. Government guarantee
-}
a_5_Q : CollateralClass
a_5_Q =
    "A-5-Q"


{-| Debt issued by non-U.S. Sovereigns (excluding central banks) with a 0% RW
-}
s_1_Q : CollateralClass
s_1_Q =
    "S-1-Q"


{-| Debt issued by multilateral development banks or other supranationals with a 0% RW
-}
s_2_Q : CollateralClass
s_2_Q =
    "S-2-Q"


{-| Debt with a non-U.S. sovereign (excluding central banks) or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 0% RW
-}
s_3_Q : CollateralClass
s_3_Q =
    "S-3-Q"


{-| Debt issued or guaranteed by a non-U.S. Sovereign (excluding central banks) that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the sovereign and are denominated in the home currency of the sovereign
-}
s_4_Q : CollateralClass
s_4_Q =
    "S-4-Q"


{-| Debt issued by non-U.S. Sovereigns (excluding central banks) with a 20% RW, not otherwise included
-}
s_5_Q : CollateralClass
s_5_Q =
    "S-5-Q"


{-| Debt issued by multilateral development banks or other supranationals with a 20% RW, not otherwise included
-}
s_6_Q : CollateralClass
s_6_Q =
    "S-6-Q"


{-| Debt with a non-U.S. sovereign (excluding central banks) or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 20% RW, not otherwise included
-}
s_7_Q : CollateralClass
s_7_Q =
    "S-7-Q"


{-| Securities issued or guaranteed by a central bank with a 0% RW
-}
cB_1_Q : CollateralClass
cB_1_Q =
    "CB-1-Q"


{-| Securities issued or guaranteed by a non-U.S. central bank that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the central bank and are denominated in the home currrency of the central bank
-}
cB_2_Q : CollateralClass
cB_2_Q =
    "CB-2-Q"


{-| Securities issued or guaranteed by a non-U.S. central bank with a 20% RW, not otherwise included
-}
cB_3_Q : CollateralClass
cB_3_Q =
    "CB-3-Q"


{-| Senior to preferred debt issued by a U.S. Government Sponsored Entity (GSE)
-}
g_1_Q : CollateralClass
g_1_Q =
    "G-1-Q"


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. GSE
-}
g_2_Q : CollateralClass
g_2_Q =
    "G-2-Q"


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. GSE
-}
g_3_Q : CollateralClass
g_3_Q =
    "G-3-Q"


{-| U.S. equities - Russell 1000
-}
e_1_Q : CollateralClass
e_1_Q =
    "E-1-Q"


{-| Non-U.S. Equities listed on a foreign index designated to by the local supervisor as qualifying for the LCR, and denominated in USD or the currency of outflows that the foreign entity is supporting
-}
e_2_Q : CollateralClass
e_2_Q =
    "E-2-Q"


{-| Investment grade corporate debt
-}
iG_1_Q : CollateralClass
iG_1_Q =
    "IG-1-Q"


{-| Investment grade municipal obligations
-}
iG_2_Q : CollateralClass
iG_2_Q =
    "IG-2-Q"


{-| U.S. Government Agency-issued debt (excluding the US Treasury) with a US Government guarantee
-}
a_2 : CollateralClass
a_2 =
    "A-2"


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_3 : CollateralClass
a_3 =
    "A-3"


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_4 : CollateralClass
a_4 =
    "A-4"


{-| Other debt with a U.S. Government guarantee
-}
a_5 : CollateralClass
a_5 =
    "A-5"


{-| Debt issued by non-U.S. Sovereigns (excluding central banks) with a 0% RW
-}
s_1 : CollateralClass
s_1 =
    "S-1"


{-| Debt issued by multilateral development banks or other supranationals with a 0% RW
-}
s_2 : CollateralClass
s_2 =
    "S-2"


{-| Debt with a non-U.S. sovereign (excluding central banks) or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 0% RW
-}
s_3 : CollateralClass
s_3 =
    "S-3"


{-| Debt issued or guaranteed by a non-U.S. Sovereign (excluding central banks) that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the sovereign and are denominated in the home currency of the sovereign
-}
s_4 : CollateralClass
s_4 =
    "S-4"


{-| Securities issued or guaranteed by a central bank with a 0% RW
-}
cB_1 : CollateralClass
cB_1 =
    "CB-1"


{-| Securities issued or guaranteed by a non-U.S. central bank that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the central bank and are denominated in the home currrency of the central bank
-}
cB_2 : CollateralClass
cB_2 =
    "CB-2"


{-| Senior to preferred debt issued by a U.S. Government Sponsored Entity (GSE)
-}
g_1 : CollateralClass
g_1 =
    "G-1"


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. GSE
-}
g_2 : CollateralClass
g_2 =
    "G-2"


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. GSE
-}
g_3 : CollateralClass
g_3 =
    "G-3"


{-| Debt issued by Non-U.S. Sovereigns with a 20% RW, not otherwise included
-}
s_5 : CollateralClass
s_5 =
    "S-5"


{-| Debt issued by multilateral development banks or other supranationals with a 20% RW, not otherwise included
-}
s_6 : CollateralClass
s_6 =
    "S-6"


{-| Debt with a non-U.S. sovereign or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 20% RW, not otherwise included
-}
s_7 : CollateralClass
s_7 =
    "S-7"


{-| Securities issued or guaranteed by a non-U.S. central bank with a 20% RW, not otherwise included
-}
cB_3 : CollateralClass
cB_3 =
    "CB-3"


{-| U.S. equities - Russell 1000
-}
e_1 : CollateralClass
e_1 =
    "E-1"


{-| Non-U.S. Equities listed on a foreign index designated to by the local supervisor as qualifying for the LCR, and denominated in USD or the currency of outflows that the foreign entity is supporting
-}
e_2 : CollateralClass
e_2 =
    "E-2"


{-| Investment grade corporate debt
-}
iG_1 : CollateralClass
iG_1 =
    "IG-1"


{-| Investment grade U.S. municipal general obligations
-}
iG_2 : CollateralClass
iG_2 =
    "IG-2"


{-| All other debt issued by sovereigns (excluding central banks) and supranational entities, not otherwise included
-}
s_8 : CollateralClass
s_8 =
    "S-8"


{-| Debt, other than senior or preferred, issued by a U.S. GSE
-}
g_4 : CollateralClass
g_4 =
    "G-4"


{-| All other U.S.-listed common equity securities
-}
e_3 : CollateralClass
e_3 =
    "E-3"


{-| All other non-US-listed common equity securities
-}
e_4 : CollateralClass
e_4 =
    "E-4"


{-| ETFs listed on US exchanges
-}
e_5 : CollateralClass
e_5 =
    "E-5"


{-| ETFs listed on non-US exchanges
-}
e_6 : CollateralClass
e_6 =
    "E-6"


{-| US mutual fund shares
-}
e_7 : CollateralClass
e_7 =
    "E-7"


{-| Non-US mutual fund shares
-}
e_8 : CollateralClass
e_8 =
    "E-8"


{-| All other US equity investments (including preferred shares, warrants and options)
-}
e_9 : CollateralClass
e_9 =
    "E-9"


{-| All other non-US equity investments (including preferred shares, warrants and options)
-}
e_10 : CollateralClass
e_10 =
    "E-10"


{-| Non-investment grade general obligations issued by U.S. municipals/PSEs
-}
n_1 : CollateralClass
n_1 =
    "N-1"


{-| Non-investment grade corporate debt
-}
n_2 : CollateralClass
n_2 =
    "N-2"


{-| Non-investment grade Vanilla ABS
-}
n_3 : CollateralClass
n_3 =
    "N-3"


{-| Non-investment grade structured ABS
-}
n_4 : CollateralClass
n_4 =
    "N-4"


{-| Non-investment grade Private label Pass-thru CMBS/RMBS
-}
n_5 : CollateralClass
n_5 =
    "N-5"


{-| Non-investment grade Private label Structured CMBS/RMBS
-}
n_6 : CollateralClass
n_6 =
    "N-6"


{-| Non-investment grade covered bonds
-}
n_7 : CollateralClass
n_7 =
    "N-7"


{-| Non-investment grade obligations of municipals/PSEs (excluding U.S. general obligations)
-}
n_8 : CollateralClass
n_8 =
    "N-8"


{-| GSE-eligible conforming residential mortgages
-}
l_1 : CollateralClass
l_1 =
    "L-1"


{-| Other GSE-eligible loans
-}
l_2 : CollateralClass
l_2 =
    "L-2"


{-| Other 1-4 family residential mortgages
-}
l_3 : CollateralClass
l_3 =
    "L-3"


{-| Other multi family residential mortgages
-}
l_4 : CollateralClass
l_4 =
    "L-4"


{-| Home equity loans
-}
l_5 : CollateralClass
l_5 =
    "L-5"


{-| Credit card loans
-}
l_6 : CollateralClass
l_6 =
    "L-6"


{-| Auto loans and leases
-}
l_7 : CollateralClass
l_7 =
    "L-7"


{-| Other consumer loans and leases
-}
l_8 : CollateralClass
l_8 =
    "L-8"


{-| Commercial real estate loans
-}
l_9 : CollateralClass
l_9 =
    "L-9"


{-| Commercial and industrial loans
-}
l_10 : CollateralClass
l_10 =
    "L-10"


{-| All other loans, except loans guaranteed by U.S. government agencies
-}
l_11 : CollateralClass
l_11 =
    "L-11"


{-| Loans guaranteed by U.S. government agencies
-}
l_12 : CollateralClass
l_12 =
    "L-12"


{-| Debt issued by reporting firm - parent
-}
y_1 : CollateralClass
y_1 =
    "Y-1"


{-| Debt issued by reporting firm - bank
-}
y_2 : CollateralClass
y_2 =
    "Y-2"


{-| Debt issued by reporting firm - all other (incl. conduits)
-}
y_3 : CollateralClass
y_3 =
    "Y-3"


{-| Equity investment in affiliates
-}
y_4 : CollateralClass
y_4 =
    "Y-4"


{-| Commodities
-}
c_1 : CollateralClass
c_1 =
    "C-1"


{-| Residential property
-}
p_1 : CollateralClass
p_1 =
    "P-1"


{-| All other physical property
-}
p_2 : CollateralClass
p_2 =
    "P-2"


{-| All other assets
-}
z_1 : CollateralClass
z_1 =
    "Z-1"


{-| Investment grade Vanilla ABS
-}
iG_3 : CollateralClass
iG_3 =
    "IG-3"


{-| Investment grade Structured ABS
-}
iG_4 : CollateralClass
iG_4 =
    "IG-4"


{-| Investment grade Private label Pass-thru CMBS/RMBS
-}
iG_5 : CollateralClass
iG_5 =
    "IG-5"


{-| Investment grade Private label Structured CMBS/RMBS
-}
iG_6 : CollateralClass
iG_6 =
    "IG-6"


{-| Investment grade covered bonds
-}
iG_7 : CollateralClass
iG_7 =
    "IG-7"


{-| Investment grade obligations of municipals/PSEs (excluding U.S. general obligations)
-}
iG_8 : CollateralClass
iG_8 =
    "IG-8"


{-| Letters of credit issued by a GSE
-}
lC_1 : CollateralClass
lC_1 =
    "LC-1"


{-| All other letters of credit, including bankers' acceptances
-}
lC_2 : CollateralClass
lC_2 =
    "LC-2"


{-| All other securities issued by central banks, not otherwise included
-}
cB_4 : CollateralClass
cB_4 =
    "CB-4"
