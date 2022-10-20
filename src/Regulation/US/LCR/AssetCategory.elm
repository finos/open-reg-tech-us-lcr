module Regulation.US.LCR.AssetCategory exposing (..)

{-| Asset categories as described in FR 2025a Appendix III.
-}


type AssetCategory
    = AssetCategory Category Int Bool


type Category
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


memberOf : List AssetCategory -> AssetCategory -> Bool
memberOf list item =
    List.member item list


hQLALevel1 : List AssetCategory
hQLALevel1 =
    [ a_0_Q, a_1_Q, a_2_Q, a_3_Q, a_4_Q, a_5_Q, s_1_Q, s_2_Q, s_3_Q, s_4_Q, cB_1_Q, cB_2_Q ]


hQLALevel1ExcludingCash : List AssetCategory
hQLALevel1ExcludingCash =
    hQLALevel1 |> List.filter (\assetCategory -> assetCategory /= a_0_Q)


hQLALevel2A : List AssetCategory
hQLALevel2A =
    [ g_1_Q, g_2_Q, g_3_Q, s_5_Q, s_6_Q, s_7_Q, cB_3_Q ]


hQLALevel2B : List AssetCategory
hQLALevel2B =
    [ e_1_Q, e_2_Q, iG_1_Q, iG_2_Q ]


hQLAUnwindTransactions : List AssetCategory
hQLAUnwindTransactions =
    List.concat [ hQLALevel1, hQLALevel2A, hQLALevel2B ]


{-| Cash
-}
a_0_Q : AssetCategory
a_0_Q =
    AssetCategory Agency 0 True


{-| Debt issued by the U.S. Treasury
-}
a_1_Q : AssetCategory
a_1_Q =
    AssetCategory Agency 1 True


{-| U.S. Government Agency-issued debt (excluding the US Treasury) with a US Government guarantee
-}
a_2_Q : AssetCategory
a_2_Q =
    AssetCategory Agency 2 True


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_3_Q : AssetCategory
a_3_Q =
    AssetCategory Agency 3 True


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_4_Q : AssetCategory
a_4_Q =
    AssetCategory Agency 4 True


{-| Other debt with a U.S. Government guarantee
-}
a_5_Q : AssetCategory
a_5_Q =
    AssetCategory Agency 5 True


{-| Debt issued by non-U.S. Sovereigns (excluding central banks) with a 0% RW
-}
s_1_Q : AssetCategory
s_1_Q =
    AssetCategory Sovereigns 1 True


{-| Debt issued by multilateral development banks or other supranationals with a 0% RW
-}
s_2_Q : AssetCategory
s_2_Q =
    AssetCategory Sovereigns 2 True


{-| Debt with a non-U.S. sovereign (excluding central banks) or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 0% RW
-}
s_3_Q : AssetCategory
s_3_Q =
    AssetCategory Sovereigns 3 True


{-| Debt issued or guaranteed by a non-U.S. Sovereign (excluding central banks) that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the sovereign and are denominated in the home currency of the sovereign
-}
s_4_Q : AssetCategory
s_4_Q =
    AssetCategory Sovereigns 4 True


{-| Debt issued by non-U.S. Sovereigns (excluding central banks) with a 20% RW, not otherwise included
-}
s_5_Q : AssetCategory
s_5_Q =
    AssetCategory Sovereigns 5 True


{-| Debt issued by multilateral development banks or other supranationals with a 20% RW, not otherwise included
-}
s_6_Q : AssetCategory
s_6_Q =
    AssetCategory Sovereigns 6 True


{-| Debt with a non-U.S. sovereign (excluding central banks) or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 20% RW, not otherwise included
-}
s_7_Q : AssetCategory
s_7_Q =
    AssetCategory Sovereigns 7 True


{-| Securities issued or guaranteed by a central bank with a 0% RW
-}
cB_1_Q : AssetCategory
cB_1_Q =
    AssetCategory CentralBank 1 True


{-| Securities issued or guaranteed by a non-U.S. central bank that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the central bank and are denominated in the home currrency of the central bank
-}
cB_2_Q : AssetCategory
cB_2_Q =
    AssetCategory CentralBank 2 True


{-| Securities issued or guaranteed by a non-U.S. central bank with a 20% RW, not otherwise included
-}
cB_3_Q : AssetCategory
cB_3_Q =
    AssetCategory CentralBank 3 True


{-| Senior to preferred debt issued by a U.S. Government Sponsored Entity (GSE)
-}
g_1_Q : AssetCategory
g_1_Q =
    AssetCategory GovernmentSponsoredEntity 1 True


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. GSE
-}
g_2_Q : AssetCategory
g_2_Q =
    AssetCategory GovernmentSponsoredEntity 2 True


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. GSE
-}
g_3_Q : AssetCategory
g_3_Q =
    AssetCategory GovernmentSponsoredEntity 3 True


{-| U.S. equities - Russell 1000
-}
e_1_Q : AssetCategory
e_1_Q =
    AssetCategory Equity 1 True


{-| Non-U.S. Equities listed on a foreign index designated to by the local supervisor as qualifying for the LCR, and denominated in USD or the currency of outflows that the foreign entity is supporting
-}
e_2_Q : AssetCategory
e_2_Q =
    AssetCategory Equity 2 True


{-| Investment grade corporate debt
-}
iG_1_Q : AssetCategory
iG_1_Q =
    AssetCategory InvestmentGrade 1 True


{-| Investment grade municipal obligations
-}
iG_2_Q : AssetCategory
iG_2_Q =
    AssetCategory InvestmentGrade 2 True


{-| U.S. Government Agency-issued debt (excluding the US Treasury) with a US Government guarantee
-}
a_2 : AssetCategory
a_2 =
    AssetCategory Agency 2 False


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_3 : AssetCategory
a_3 =
    AssetCategory Agency 3 False


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. Government Agency, where the U.S. Government Agency has a full U.S. Government guarantee
-}
a_4 : AssetCategory
a_4 =
    AssetCategory Agency 4 False


{-| Other debt with a U.S. Government guarantee
-}
a_5 : AssetCategory
a_5 =
    AssetCategory Agency 5 False


{-| Debt issued by non-U.S. Sovereigns (excluding central banks) with a 0% RW
-}
s_1 : AssetCategory
s_1 =
    AssetCategory Sovereigns 1 False


{-| Debt issued by multilateral development banks or other supranationals with a 0% RW
-}
s_2 : AssetCategory
s_2 =
    AssetCategory Sovereigns 2 False


{-| Debt with a non-U.S. sovereign (excluding central banks) or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 0% RW
-}
s_3 : AssetCategory
s_3 =
    AssetCategory Sovereigns 3 False


{-| Debt issued or guaranteed by a non-U.S. Sovereign (excluding central banks) that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the sovereign and are denominated in the home currency of the sovereign
-}
s_4 : AssetCategory
s_4 =
    AssetCategory Sovereigns 4 False


{-| Securities issued or guaranteed by a central bank with a 0% RW
-}
cB_1 : AssetCategory
cB_1 =
    AssetCategory CentralBank 1 False


{-| Securities issued or guaranteed by a non-U.S. central bank that does not have a 0% RW, but supports outflows that are in the same jurisdiction of the central bank and are denominated in the home currrency of the central bank
-}
cB_2 : AssetCategory
cB_2 =
    AssetCategory CentralBank 2 False


{-| Senior to preferred debt issued by a U.S. Government Sponsored Entity (GSE)
-}
g_1 : AssetCategory
g_1 =
    AssetCategory GovernmentSponsoredEntity 1 False


{-| Vanilla debt (including pass-through MBS) guaranteed by a U.S. GSE
-}
g_2 : AssetCategory
g_2 =
    AssetCategory GovernmentSponsoredEntity 2 False


{-| Structured debt (excluding pass-through MBS) guaranteed by a U.S. GSE
-}
g_3 : AssetCategory
g_3 =
    AssetCategory GovernmentSponsoredEntity 3 False


{-| Debt issued by Non-U.S. Sovereigns with a 20% RW, not otherwise included
-}
s_5 : AssetCategory
s_5 =
    AssetCategory Sovereigns 5 False


{-| Debt issued by multilateral development banks or other supranationals with a 20% RW, not otherwise included
-}
s_6 : AssetCategory
s_6 =
    AssetCategory Sovereigns 6 False


{-| Debt with a non-U.S. sovereign or multilateral development bank or other supranational guarantee, where guaranteeing entity has a 20% RW, not otherwise included
-}
s_7 : AssetCategory
s_7 =
    AssetCategory Sovereigns 7 False


{-| Securities issued or guaranteed by a non-U.S. central bank with a 20% RW, not otherwise included
-}
cB_3 : AssetCategory
cB_3 =
    AssetCategory CentralBank 3 False


{-| U.S. equities - Russell 1000
-}
e_1 : AssetCategory
e_1 =
    AssetCategory Equity 1 False


{-| Non-U.S. Equities listed on a foreign index designated to by the local supervisor as qualifying for the LCR, and denominated in USD or the currency of outflows that the foreign entity is supporting
-}
e_2 : AssetCategory
e_2 =
    AssetCategory Equity 2 False


{-| Investment grade corporate debt
-}
iG_1 : AssetCategory
iG_1 =
    AssetCategory InvestmentGrade 1 False


{-| Investment grade U.S. municipal general obligations
-}
iG_2 : AssetCategory
iG_2 =
    AssetCategory InvestmentGrade 2 False


{-| All other debt issued by sovereigns (excluding central banks) and supranational entities, not otherwise included
-}
s_8 : AssetCategory
s_8 =
    AssetCategory Sovereigns 8 False


{-| Debt, other than senior or preferred, issued by a U.S. GSE
-}
g_4 : AssetCategory
g_4 =
    AssetCategory GovernmentSponsoredEntity 4 False


{-| All other U.S.-listed common equity securities
-}
e_3 : AssetCategory
e_3 =
    AssetCategory Equity 3 False


{-| All other non-US-listed common equity securities
-}
e_4 : AssetCategory
e_4 =
    AssetCategory Equity 4 False


{-| ETFs listed on US exchanges
-}
e_5 : AssetCategory
e_5 =
    AssetCategory Equity 5 False


{-| ETFs listed on non-US exchanges
-}
e_6 : AssetCategory
e_6 =
    AssetCategory Equity 6 False


{-| US mutual fund shares
-}
e_7 : AssetCategory
e_7 =
    AssetCategory Equity 7 False


{-| Non-US mutual fund shares
-}
e_8 : AssetCategory
e_8 =
    AssetCategory Equity 8 False


{-| All other US equity investments (including preferred shares, warrants and options)
-}
e_9 : AssetCategory
e_9 =
    AssetCategory Equity 9 False


{-| All other non-US equity investments (including preferred shares, warrants and options)
-}
e_10 : AssetCategory
e_10 =
    AssetCategory Equity 10 False


{-| Non-investment grade general obligations issued by U.S. municipals/PSEs
-}
n_1 : AssetCategory
n_1 =
    AssetCategory NonInvestmentGrade 1 False


{-| Non-investment grade corporate debt
-}
n_2 : AssetCategory
n_2 =
    AssetCategory NonInvestmentGrade 2 False


{-| Non-investment grade Vanilla ABS
-}
n_3 : AssetCategory
n_3 =
    AssetCategory NonInvestmentGrade 3 False


{-| Non-investment grade structured ABS
-}
n_4 : AssetCategory
n_4 =
    AssetCategory NonInvestmentGrade 4 False


{-| Non-investment grade Private label Pass-thru CMBS/RMBS
-}
n_5 : AssetCategory
n_5 =
    AssetCategory NonInvestmentGrade 5 False


{-| Non-investment grade Private label Structured CMBS/RMBS
-}
n_6 : AssetCategory
n_6 =
    AssetCategory NonInvestmentGrade 6 False


{-| Non-investment grade covered bonds
-}
n_7 : AssetCategory
n_7 =
    AssetCategory NonInvestmentGrade 7 False


{-| Non-investment grade obligations of municipals/PSEs (excluding U.S. general obligations)
-}
n_8 : AssetCategory
n_8 =
    AssetCategory NonInvestmentGrade 8 False


{-| GSE-eligible conforming residential mortgages
-}
l_1 : AssetCategory
l_1 =
    AssetCategory Loan 1 False


{-| Other GSE-eligible loans
-}
l_2 : AssetCategory
l_2 =
    AssetCategory Loan 2 False


{-| Other 1-4 family residential mortgages
-}
l_3 : AssetCategory
l_3 =
    AssetCategory Loan 3 False


{-| Other multi family residential mortgages
-}
l_4 : AssetCategory
l_4 =
    AssetCategory Loan 4 False


{-| Home equity loans
-}
l_5 : AssetCategory
l_5 =
    AssetCategory Loan 5 False


{-| Credit card loans
-}
l_6 : AssetCategory
l_6 =
    AssetCategory Loan 6 False


{-| Auto loans and leases
-}
l_7 : AssetCategory
l_7 =
    AssetCategory Loan 7 False


{-| Other consumer loans and leases
-}
l_8 : AssetCategory
l_8 =
    AssetCategory Loan 8 False


{-| Commercial real estate loans
-}
l_9 : AssetCategory
l_9 =
    AssetCategory Loan 9 False


{-| Commercial and industrial loans
-}
l_10 : AssetCategory
l_10 =
    AssetCategory Loan 10 False


{-| All other loans, except loans guaranteed by U.S. government agencies
-}
l_11 : AssetCategory
l_11 =
    AssetCategory Loan 11 False


{-| Loans guaranteed by U.S. government agencies
-}
l_12 : AssetCategory
l_12 =
    AssetCategory Loan 12 False


{-| Debt issued by reporting firm - parent
-}
y_1 : AssetCategory
y_1 =
    AssetCategory Debt 1 False


{-| Debt issued by reporting firm - bank
-}
y_2 : AssetCategory
y_2 =
    AssetCategory Debt 2 False


{-| Debt issued by reporting firm - all other (incl. conduits)
-}
y_3 : AssetCategory
y_3 =
    AssetCategory Debt 3 False


{-| Equity investment in affiliates
-}
y_4 : AssetCategory
y_4 =
    AssetCategory Debt 4 False


{-| Commodities
-}
c_1 : AssetCategory
c_1 =
    AssetCategory Commodities 1 False


{-| Residential property
-}
p_1 : AssetCategory
p_1 =
    AssetCategory Property 1 False


{-| All other physical property
-}
p_2 : AssetCategory
p_2 =
    AssetCategory Property 2 False


{-| All other assets
-}
z_1 : AssetCategory
z_1 =
    AssetCategory Other 1 False


{-| Investment grade Vanilla ABS
-}
iG_3 : AssetCategory
iG_3 =
    AssetCategory InvestmentGrade 3 False


{-| Investment grade Structured ABS
-}
iG_4 : AssetCategory
iG_4 =
    AssetCategory InvestmentGrade 4 False


{-| Investment grade Private label Pass-thru CMBS/RMBS
-}
iG_5 : AssetCategory
iG_5 =
    AssetCategory InvestmentGrade 5 False


{-| Investment grade Private label Structured CMBS/RMBS
-}
iG_6 : AssetCategory
iG_6 =
    AssetCategory InvestmentGrade 6 False


{-| Investment grade covered bonds
-}
iG_7 : AssetCategory
iG_7 =
    AssetCategory InvestmentGrade 7 False


{-| Investment grade obligations of municipals/PSEs (excluding U.S. general obligations)
-}
iG_8 : AssetCategory
iG_8 =
    AssetCategory InvestmentGrade 8 False


{-| Letters of credit issued by a GSE
-}
lC_1 : AssetCategory
lC_1 =
    AssetCategory LetterOfCredit 1 False


{-| All other letters of credit, including bankers' acceptances
-}
lC_2 : AssetCategory
lC_2 =
    AssetCategory LetterOfCredit 2 False


{-| All other securities issued by central banks, not otherwise included
-}
cB_4 : AssetCategory
cB_4 =
    AssetCategory CentralBank 4 False
