module Regulation.US.FR2052A.Fields.CollateralClass exposing (..)

{-| Asset categories as described in FR 2025a Appendix III.
-}


type CollateralClass
    = CollateralClass AssetCategory Int Bool


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
toString (CollateralClass assetCategory index hqla) =
    if hqla then
        String.join "-" [ assetCategoryToString assetCategory, String.fromInt index, "Q" ]

    else
        String.join "-" [ assetCategoryToString assetCategory, String.fromInt index ]


fromString : String -> Maybe CollateralClass
fromString string =
    case String.split "-" string of
        [ assetString, indexString, "Q" ] ->
            Maybe.map2 (\a i -> CollateralClass a i True)
                (assetCategoryFromString assetString)
                (String.toInt indexString)

        [ assetString, indexString ] ->
            Maybe.map2 (\a i -> CollateralClass a i False)
                (assetCategoryFromString assetString)
                (String.toInt indexString)

        _ ->
            Nothing


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


isOther : CollateralClass -> Bool
isOther (CollateralClass assetCategory _ _) =
    assetCategory == Other


{-| Cash
-}
a_0_Q : CollateralClass
a_0_Q =
    CollateralClass Agency 0 True


{-| Debt issued by the U.S. Treasury
-}
a_1_Q : CollateralClass
a_1_Q =
    CollateralClass Agency 1 True


{-| U.S. Government Agency-issued debt (excluding the US Treasury) with a US Government guarantee
-}
a_2_Q : CollateralClass
a_2_Q =
    CollateralClass Agency 2 True


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_3_Q : CollateralClass
a_3_Q =
    CollateralClass Agency 3 True


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_4_Q : CollateralClass
a_4_Q =
    CollateralClass Agency 4 True


{-| Other debt with a U.S. Government guarantee
-}
a_5_Q : CollateralClass
a_5_Q =
    CollateralClass Agency 5 True


{-| Debt issued by non-U.S. Sovereigns (excluding central banks) with a 0% RW
-}
s_1_Q : CollateralClass
s_1_Q =
    CollateralClass Sovereigns 1 True


{-| Debt issued by multilateral development banks or other supranationals with a 0% RW
-}
s_2_Q : CollateralClass
s_2_Q =
    CollateralClass Sovereigns 2 True


{-| Debt with a non-U.S. sovereign (excluding central banks) or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 0% RW
-}
s_3_Q : CollateralClass
s_3_Q =
    CollateralClass Sovereigns 3 True


{-| Debt issued or guaranteed by a non-U.S. Sovereign (excluding central banks) that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the sovereign and are denominated in the home currency of the sovereign
-}
s_4_Q : CollateralClass
s_4_Q =
    CollateralClass Sovereigns 4 True


{-| Debt issued by non-U.S. Sovereigns (excluding central banks) with a 20% RW, not otherwise included
-}
s_5_Q : CollateralClass
s_5_Q =
    CollateralClass Sovereigns 5 True


{-| Debt issued by multilateral development banks or other supranationals with a 20% RW, not otherwise included
-}
s_6_Q : CollateralClass
s_6_Q =
    CollateralClass Sovereigns 6 True


{-| Debt with a non-U.S. sovereign (excluding central banks) or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 20% RW, not otherwise included
-}
s_7_Q : CollateralClass
s_7_Q =
    CollateralClass Sovereigns 7 True


{-| Securities issued or guaranteed by a central bank with a 0% RW
-}
cB_1_Q : CollateralClass
cB_1_Q =
    CollateralClass CentralBank 1 True


{-| Securities issued or guaranteed by a non-U.S. central bank that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the central bank and are denominated in the home currrency of the central bank
-}
cB_2_Q : CollateralClass
cB_2_Q =
    CollateralClass CentralBank 2 True


{-| Securities issued or guaranteed by a non-U.S. central bank with a 20% RW, not otherwise included
-}
cB_3_Q : CollateralClass
cB_3_Q =
    CollateralClass CentralBank 3 True


{-| Senior to preferred debt issued by a U.S. Government Sponsored Entity (GSE)
-}
g_1_Q : CollateralClass
g_1_Q =
    CollateralClass GovernmentSponsoredEntity 1 True


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. GSE
-}
g_2_Q : CollateralClass
g_2_Q =
    CollateralClass GovernmentSponsoredEntity 2 True


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. GSE
-}
g_3_Q : CollateralClass
g_3_Q =
    CollateralClass GovernmentSponsoredEntity 3 True


{-| U.S. equities - Russell 1000
-}
e_1_Q : CollateralClass
e_1_Q =
    CollateralClass Equity 1 True


{-| Non-U.S. Equities listed on a foreign index designated to by the local supervisor as qualifying for the LCR, and denominated in USD or the currency of outflows that the foreign entity is supporting
-}
e_2_Q : CollateralClass
e_2_Q =
    CollateralClass Equity 2 True


{-| Investment grade corporate debt
-}
iG_1_Q : CollateralClass
iG_1_Q =
    CollateralClass InvestmentGrade 1 True


{-| Investment grade municipal obligations
-}
iG_2_Q : CollateralClass
iG_2_Q =
    CollateralClass InvestmentGrade 2 True


{-| U.S. Government Agency-issued debt (excluding the US Treasury) with a US Government guarantee
-}
a_2 : CollateralClass
a_2 =
    CollateralClass Agency 2 False


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_3 : CollateralClass
a_3 =
    CollateralClass Agency 3 False


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_4 : CollateralClass
a_4 =
    CollateralClass Agency 4 False


{-| Other debt with a U.S. Government guarantee
-}
a_5 : CollateralClass
a_5 =
    CollateralClass Agency 5 False


{-| Debt issued by non-U.S. Sovereigns (excluding central banks) with a 0% RW
-}
s_1 : CollateralClass
s_1 =
    CollateralClass Sovereigns 1 False


{-| Debt issued by multilateral development banks or other supranationals with a 0% RW
-}
s_2 : CollateralClass
s_2 =
    CollateralClass Sovereigns 2 False


{-| Debt with a non-U.S. sovereign (excluding central banks) or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 0% RW
-}
s_3 : CollateralClass
s_3 =
    CollateralClass Sovereigns 3 False


{-| Debt issued or guaranteed by a non-U.S. Sovereign (excluding central banks) that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the sovereign and are denominated in the home currency of the sovereign
-}
s_4 : CollateralClass
s_4 =
    CollateralClass Sovereigns 4 False


{-| Securities issued or guaranteed by a central bank with a 0% RW
-}
cB_1 : CollateralClass
cB_1 =
    CollateralClass CentralBank 1 False


{-| Securities issued or guaranteed by a non-U.S. central bank that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the central bank and are denominated in the home currrency of the central bank
-}
cB_2 : CollateralClass
cB_2 =
    CollateralClass CentralBank 2 False


{-| Senior to preferred debt issued by a U.S. Government Sponsored Entity (GSE)
-}
g_1 : CollateralClass
g_1 =
    CollateralClass GovernmentSponsoredEntity 1 False


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. GSE
-}
g_2 : CollateralClass
g_2 =
    CollateralClass GovernmentSponsoredEntity 2 False


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. GSE
-}
g_3 : CollateralClass
g_3 =
    CollateralClass GovernmentSponsoredEntity 3 False


{-| Debt issued by Non-U.S. Sovereigns with a 20% RW, not otherwise included
-}
s_5 : CollateralClass
s_5 =
    CollateralClass Sovereigns 5 False


{-| Debt issued by multilateral development banks or other supranationals with a 20% RW, not otherwise included
-}
s_6 : CollateralClass
s_6 =
    CollateralClass Sovereigns 6 False


{-| Debt with a non-U.S. sovereign or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 20% RW, not otherwise included
-}
s_7 : CollateralClass
s_7 =
    CollateralClass Sovereigns 7 False


{-| Securities issued or guaranteed by a non-U.S. central bank with a 20% RW, not otherwise included
-}
cB_3 : CollateralClass
cB_3 =
    CollateralClass CentralBank 3 False


{-| U.S. equities - Russell 1000
-}
e_1 : CollateralClass
e_1 =
    CollateralClass Equity 1 False


{-| Non-U.S. Equities listed on a foreign index designated to by the local supervisor as qualifying for the LCR, and denominated in USD or the currency of outflows that the foreign entity is supporting
-}
e_2 : CollateralClass
e_2 =
    CollateralClass Equity 2 False


{-| Investment grade corporate debt
-}
iG_1 : CollateralClass
iG_1 =
    CollateralClass InvestmentGrade 1 False


{-| Investment grade U.S. municipal general obligations
-}
iG_2 : CollateralClass
iG_2 =
    CollateralClass InvestmentGrade 2 False


{-| All other debt issued by sovereigns (excluding central banks) and supranational entities, not otherwise included
-}
s_8 : CollateralClass
s_8 =
    CollateralClass Sovereigns 8 False


{-| Debt, other than senior or preferred, issued by a U.S. GSE
-}
g_4 : CollateralClass
g_4 =
    CollateralClass GovernmentSponsoredEntity 4 False


{-| All other U.S.-listed common equity securities
-}
e_3 : CollateralClass
e_3 =
    CollateralClass Equity 3 False


{-| All other non-US-listed common equity securities
-}
e_4 : CollateralClass
e_4 =
    CollateralClass Equity 4 False


{-| ETFs listed on US exchanges
-}
e_5 : CollateralClass
e_5 =
    CollateralClass Equity 5 False


{-| ETFs listed on non-US exchanges
-}
e_6 : CollateralClass
e_6 =
    CollateralClass Equity 6 False


{-| US mutual fund shares
-}
e_7 : CollateralClass
e_7 =
    CollateralClass Equity 7 False


{-| Non-US mutual fund shares
-}
e_8 : CollateralClass
e_8 =
    CollateralClass Equity 8 False


{-| All other US equity investments (including preferred shares, warrants and options)
-}
e_9 : CollateralClass
e_9 =
    CollateralClass Equity 9 False


{-| All other non-US equity investments (including preferred shares, warrants and options)
-}
e_10 : CollateralClass
e_10 =
    CollateralClass Equity 10 False


{-| Non-investment grade general obligations issued by U.S. municipals/PSEs
-}
n_1 : CollateralClass
n_1 =
    CollateralClass NonInvestmentGrade 1 False


{-| Non-investment grade corporate debt
-}
n_2 : CollateralClass
n_2 =
    CollateralClass NonInvestmentGrade 2 False


{-| Non-investment grade Vanilla ABS
-}
n_3 : CollateralClass
n_3 =
    CollateralClass NonInvestmentGrade 3 False


{-| Non-investment grade structured ABS
-}
n_4 : CollateralClass
n_4 =
    CollateralClass NonInvestmentGrade 4 False


{-| Non-investment grade Private label Pass-thru CMBS/RMBS
-}
n_5 : CollateralClass
n_5 =
    CollateralClass NonInvestmentGrade 5 False


{-| Non-investment grade Private label Structured CMBS/RMBS
-}
n_6 : CollateralClass
n_6 =
    CollateralClass NonInvestmentGrade 6 False


{-| Non-investment grade covered bonds
-}
n_7 : CollateralClass
n_7 =
    CollateralClass NonInvestmentGrade 7 False


{-| Non-investment grade obligations of municipals/PSEs (excluding U.S. general obligations)
-}
n_8 : CollateralClass
n_8 =
    CollateralClass NonInvestmentGrade 8 False


{-| GSE-eligible conforming residential mortgages
-}
l_1 : CollateralClass
l_1 =
    CollateralClass Loan 1 False


{-| Other GSE-eligible loans
-}
l_2 : CollateralClass
l_2 =
    CollateralClass Loan 2 False


{-| Other 1-4 family residential mortgages
-}
l_3 : CollateralClass
l_3 =
    CollateralClass Loan 3 False


{-| Other multi family residential mortgages
-}
l_4 : CollateralClass
l_4 =
    CollateralClass Loan 4 False


{-| Home equity loans
-}
l_5 : CollateralClass
l_5 =
    CollateralClass Loan 5 False


{-| Credit card loans
-}
l_6 : CollateralClass
l_6 =
    CollateralClass Loan 6 False


{-| Auto loans and leases
-}
l_7 : CollateralClass
l_7 =
    CollateralClass Loan 7 False


{-| Other consumer loans and leases
-}
l_8 : CollateralClass
l_8 =
    CollateralClass Loan 8 False


{-| Commercial real estate loans
-}
l_9 : CollateralClass
l_9 =
    CollateralClass Loan 9 False


{-| Commercial and industrial loans
-}
l_10 : CollateralClass
l_10 =
    CollateralClass Loan 10 False


{-| All other loans, except loans guaranteed by U.S. government agencies
-}
l_11 : CollateralClass
l_11 =
    CollateralClass Loan 11 False


{-| Loans guaranteed by U.S. government agencies
-}
l_12 : CollateralClass
l_12 =
    CollateralClass Loan 12 False


{-| Debt issued by reporting firm - parent
-}
y_1 : CollateralClass
y_1 =
    CollateralClass Debt 1 False


{-| Debt issued by reporting firm - bank
-}
y_2 : CollateralClass
y_2 =
    CollateralClass Debt 2 False


{-| Debt issued by reporting firm - all other (incl. conduits)
-}
y_3 : CollateralClass
y_3 =
    CollateralClass Debt 3 False


{-| Equity investment in affiliates
-}
y_4 : CollateralClass
y_4 =
    CollateralClass Debt 4 False


{-| Commodities
-}
c_1 : CollateralClass
c_1 =
    CollateralClass Commodities 1 False


{-| Residential property
-}
p_1 : CollateralClass
p_1 =
    CollateralClass Property 1 False


{-| All other physical property
-}
p_2 : CollateralClass
p_2 =
    CollateralClass Property 2 False


{-| All other assets
-}
z_1 : CollateralClass
z_1 =
    CollateralClass Other 1 False


{-| Investment grade Vanilla ABS
-}
iG_3 : CollateralClass
iG_3 =
    CollateralClass InvestmentGrade 3 False


{-| Investment grade Structured ABS
-}
iG_4 : CollateralClass
iG_4 =
    CollateralClass InvestmentGrade 4 False


{-| Investment grade Private label Pass-thru CMBS/RMBS
-}
iG_5 : CollateralClass
iG_5 =
    CollateralClass InvestmentGrade 5 False


{-| Investment grade Private label Structured CMBS/RMBS
-}
iG_6 : CollateralClass
iG_6 =
    CollateralClass InvestmentGrade 6 False


{-| Investment grade covered bonds
-}
iG_7 : CollateralClass
iG_7 =
    CollateralClass InvestmentGrade 7 False


{-| Investment grade obligations of municipals/PSEs (excluding U.S. general obligations)
-}
iG_8 : CollateralClass
iG_8 =
    CollateralClass InvestmentGrade 8 False


{-| Letters of credit issued by a GSE
-}
lC_1 : CollateralClass
lC_1 =
    CollateralClass LetterOfCredit 1 False


{-| All other letters of credit, including bankers' acceptances
-}
lC_2 : CollateralClass
lC_2 =
    CollateralClass LetterOfCredit 2 False


{-| All other securities issued by central banks, not otherwise included
-}
cB_4 : CollateralClass
cB_4 =
    CollateralClass CentralBank 4 False
