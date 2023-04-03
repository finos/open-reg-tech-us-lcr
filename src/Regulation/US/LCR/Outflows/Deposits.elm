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


module Regulation.US.LCR.Outflows.Deposits exposing (..)

import Regulation.US.FR2052A.DataTables.Outflows.Deposits exposing (..)
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.FR2052A.Fields.Counterparty as Counterparty
import Regulation.US.FR2052A.Fields.Insured as Insured
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket
import Regulation.US.LCR.MaturityBucket exposing (FromDate)
import Regulation.US.LCR.Rule exposing (applyRule)
import Regulation.US.LCR.Rules exposing (RuleBalance)


{-| Given a list, applies the applicable rule for each assets along with the relevant amount
-}
toRuleBalances : FromDate -> List Deposits -> List RuleBalance
toRuleBalances fromDate flows =
    flows
        |> List.map
            (\flow ->
                { rule =
                    if match_rule_10_section_32_a_1 flow then
                        "32(a)(1)"

                    else if match_rule_11_section_32_a_2 flow then
                        "32(a)(2)"

                    else if match_rule_12_section_32_a_3 flow then
                        "32(a)(3)"

                    else if match_rule_13_section_32_a_4 flow then
                        "32(a)(4)"

                    else if match_rule_14_section_32_a_5 flow then
                        "32(a)(5)"

                    else if match_rule_39_section_32_g_1 fromDate flow then
                        "32(g)(1)"

                    else if match_rule_40_section_32_g_2 fromDate flow then
                        "32(g)(2)"

                    else if match_rule_41_section_32_g_3 flow then
                        "32(g)(3)"

                    else if match_rule_42_section_32_g_4 flow then
                        "32(g)(4)"

                    else if match_rule_43_section_32_g_5 flow then
                        "32(g)(5)"

                    else if match_rule_44_section_32_g_6 flow then
                        "32(g)(6)"

                    else if match_rule_45_section_32_g_7 flow then
                        "32(g)(7)"

                    else if match_rule_46_section_32_g_8 flow then
                        "32(g)(8)"

                    else if match_rule_47_section_32_g_9 flow then
                        "32(g)(9)"

                    else if match_rule_48_section_32_h_1_i fromDate flow then
                        "32(h)(1)(i)"

                    else if match_rule_49_section_32_h_1_ii_A fromDate flow then
                        "32(h)(1)(ii)(A)"

                    else if match_rule_52_section_32_h_1_ii_B fromDate flow then
                        "32(h)(1)(ii)(B)"

                    else if match_rule_53_section_32_h_2 fromDate flow then
                        "32(h)(2)"

                    else if match_rule_57_section_32_h_3 fromDate flow then
                        "32(h)(3)"

                    else if match_rule_58_section_32_h_4 fromDate flow then
                        "32(h)(4)"

                    else if match_rule_59_section_32_h_4 fromDate flow then
                        "32(h)(4)"

                    else if match_rule_60_section_32_h_5 fromDate flow then
                        "32(h)(5)"

                    else if match_rule_64_section_32_j_1_i fromDate flow then
                        "32(j)(1)(i)"

                    else if match_rule_67_section_32_j_1_ii fromDate flow then
                        "32(j)(1)(ii)"

                    else if match_rule_70_section_32_j_1_iii fromDate flow then
                        "32(j)(1)(iii)"

                    else if match_rule_72_section_32_j_1_iv fromDate flow then
                        "32(j)(1)(iv)"
                        --TODO
                        --                    else if match_rule_73_section_32_j_1_iv flow then
                        --                        "32(j)(1)(iv)"
                        --
                        --                    else if match_rule_77_section_32_j_1_vi flow then
                        --                        "32(j)(1)(vi)"
                        --
                        --                    else if match_rule_78_section_32_j_1_vi flow then
                        --                        "32(j)(1)(vi)"
                        --
                        --                    else if match_rule_81_section_32_j_2 flow then
                        --                        "32(j)(2)"
                        --
                        --                    else if match_rule_83_section_32_j_2 flow then
                        --                        "32(j)(2)"
                        --
                        --                    else if match_rule_84_section_32_j_2 flow then
                        --                        "32(j)(2)"
                        --
                        --                    else if match_rule_98_section_32_k flow then
                        --                        "32(k)"

                    else
                        ""
                , amount = flow.maturityAmount
                }
            )
        |> List.filter (\rb -> rb.rule /= "")


applyRules : FromDate -> Deposits -> List RuleBalance
applyRules fromDate deposits =
    List.concat
        [ applyRule (match_rule_10_section_32_a_1 deposits) "32(a)(1)" deposits.maturityAmount
        , applyRule (match_rule_11_section_32_a_2 deposits) "32(a)(2)" deposits.maturityAmount
        , applyRule (match_rule_12_section_32_a_3 deposits) "32(a)(3)" deposits.maturityAmount
        , applyRule (match_rule_13_section_32_a_4 deposits) "32(a)(4)" deposits.maturityAmount
        , applyRule (match_rule_14_section_32_a_5 deposits) "32(a)(5)" deposits.maturityAmount
        , applyRule (match_rule_39_section_32_g_1 fromDate deposits) "32(g)(1)" deposits.maturityAmount
        , applyRule (match_rule_40_section_32_g_2 fromDate deposits) "32(g)(2)" deposits.maturityAmount
        , applyRule (match_rule_41_section_32_g_3 deposits) "32(g)(3)" deposits.maturityAmount
        , applyRule (match_rule_42_section_32_g_4 deposits) "32(g)(4)" deposits.maturityAmount
        , applyRule (match_rule_43_section_32_g_5 deposits) "32(g)(5)" deposits.maturityAmount
        , applyRule (match_rule_44_section_32_g_6 deposits) "32(g)(6)" deposits.maturityAmount
        , applyRule (match_rule_45_section_32_g_7 deposits) "32(g)(7)" deposits.maturityAmount
        , applyRule (match_rule_46_section_32_g_8 deposits) "32(g)(8)" deposits.maturityAmount
        , applyRule (match_rule_47_section_32_g_9 deposits) "32(g)(9)" deposits.maturityAmount
        , applyRule (match_rule_48_section_32_h_1_i fromDate deposits) "32(h)(1)(i)" deposits.maturityAmount
        , applyRule (match_rule_49_section_32_h_1_ii_A fromDate deposits) "32(h)(1)(ii)(A)" deposits.maturityAmount
        , applyRule (match_rule_52_section_32_h_1_ii_B fromDate deposits) "32(h)(1)(ii)(B)" deposits.maturityAmount
        , applyRule (match_rule_53_section_32_h_2 fromDate deposits) "32(h)(2)" deposits.maturityAmount
        , applyRule (match_rule_57_section_32_h_3 fromDate deposits) "32(h)(3)" deposits.maturityAmount
        , applyRule (match_rule_58_section_32_h_4 fromDate deposits) "32(h)(4)" deposits.maturityAmount
        , applyRule (match_rule_59_section_32_h_4 fromDate deposits) "32(h)(4)" deposits.maturityAmount
        , applyRule (match_rule_60_section_32_h_5 fromDate deposits) "32(h)(5)" deposits.maturityAmount
        , applyRule (match_rule_64_section_32_j_1_i fromDate deposits) "32(j)(1)(i)" deposits.maturityAmount
        , applyRule (match_rule_67_section_32_j_1_ii fromDate deposits) "32(j)(1)(ii)" deposits.maturityAmount
        , applyRule (match_rule_70_section_32_j_1_iii fromDate deposits) "32(j)(1)(iii)" deposits.maturityAmount

        -- , applyRule (match_rule_72_section_32_j_1_iv deposits) "32(j)(1)(iv)" deposits.maturityAmount
        , apply_rule_72_section_32_j_1_iv fromDate deposits
        , applyRule (match_rule_73_section_32_j_1_iv fromDate deposits) "32(j)(1)(iv)" deposits.maturityAmount
        , applyRule (match_rule_77_section_32_j_1_vi fromDate deposits) "32(j)(1)(vi)" deposits.maturityAmount
        , applyRule (match_rule_78_section_32_j_1_vi fromDate deposits) "32(j)(1)(vi)" deposits.maturityAmount
        , applyRule (match_rule_81_section_32_j_2 fromDate deposits) "32(j)(2)" deposits.maturityAmount
        , applyRule (match_rule_83_section_32_j_2 fromDate deposits) "32(j)(2)" deposits.maturityAmount
        , applyRule (match_rule_84_section_32_j_2 fromDate deposits) "32(j)(2)" deposits.maturityAmount
        , applyRule (match_rule_98_section_32_k fromDate deposits) "32(k)" deposits.maturityAmount
        ]


{-| (10) Stable Retail Deposits (§.32(a)(1))
-}
match_rule_10_section_32_a_1 : Deposits -> Bool
match_rule_10_section_32_a_1 deposits =
    List.member deposits.product [ o_D_1, o_D_2 ]


{-| (11) Other Retail Deposits (§.32(a)(2))
-}
match_rule_11_section_32_a_2 : Deposits -> Bool
match_rule_11_section_32_a_2 deposits =
    List.member deposits.product [ o_D_1, o_D_2, o_D_3 ]


{-| (12) Insured Placed Retail Deposits (§.32(a)(3))
-}
match_rule_12_section_32_a_3 : Deposits -> Bool
match_rule_12_section_32_a_3 deposits =
    List.member deposits.product [ o_D_14 ]


{-| (13) Non-Insured Placed Retail Deposits (§.32(a)(4))
-}
match_rule_13_section_32_a_4 : Deposits -> Bool
match_rule_13_section_32_a_4 deposits =
    List.member deposits.product [ o_D_14 ]


{-| (14) Other Retail Funding (§.32(a)(5))
-}
match_rule_14_section_32_a_5 : Deposits -> Bool
match_rule_14_section_32_a_5 deposits =
    List.member deposits.product [ o_D_15 ]


{-| (39) Other Brokered Retail Deposits Maturing within 30 days (§.32(g)(1))
-}
match_rule_39_section_32_g_1 : FromDate -> Deposits -> Bool
match_rule_39_section_32_g_1 fromDate deposits =
    List.member deposits.product [ o_D_8 ]
        -- Maturity Bucket: <= 30 calendar days (but not open)
        && (MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket && deposits.maturityBucket /= MaturityBucket.Open)


{-| (40) Other Brokered Retail Deposits Maturing later than 30 days (§.32(g)(2))
-}
match_rule_40_section_32_g_2 : FromDate -> Deposits -> Bool
match_rule_40_section_32_g_2 fromDate deposits =
    List.member deposits.product [ o_D_8 ]
        -- Maturity Bucket: > 30 calendar days
        && MaturityBucket.isGreaterThan30Days fromDate deposits.maturityBucket


{-| (41) Insured Other Brokered Retail Deposits with No Maturity (§.32(g)(3))
-}
match_rule_41_section_32_g_3 : Deposits -> Bool
match_rule_41_section_32_g_3 deposits =
    List.member deposits.product [ o_D_8 ]
        -- Maturity Bucket: Open
        && deposits.maturityBucket
        == MaturityBucket.Open


{-| (42) Not Fully Insured Other Brokered Retail Deposits with No Maturity (§.32(g)(4))
-}
match_rule_42_section_32_g_4 : Deposits -> Bool
match_rule_42_section_32_g_4 deposits =
    List.member deposits.product [ o_D_8 ]
        -- Maturity Bucket: Open
        && deposits.maturityBucket
        == MaturityBucket.Open


{-| (43) Insured Reciprocal (§.32(g)(5))
-}
match_rule_43_section_32_g_5 : Deposits -> Bool
match_rule_43_section_32_g_5 deposits =
    List.member deposits.product [ o_D_13 ]


{-| (44) Not Fully Insured Reciprocal (§.32(g)(6))
-}
match_rule_44_section_32_g_6 : Deposits -> Bool
match_rule_44_section_32_g_6 deposits =
    List.member deposits.product [ o_D_13 ]


{-| (45) Insured Affiliated Sweeps (§.32(g)(7))
-}
match_rule_45_section_32_g_7 : Deposits -> Bool
match_rule_45_section_32_g_7 deposits =
    List.member deposits.product [ o_D_9, o_D_10 ]


{-| (46) Insured Non-Affiliated Sweeps (§.32(g)(8))
-}
match_rule_46_section_32_g_8 : Deposits -> Bool
match_rule_46_section_32_g_8 deposits =
    List.member deposits.product [ o_D_11 ]


{-| (47) Sweeps that are not Fully Insured (§.32(g)(9))
-}
match_rule_47_section_32_g_9 : Deposits -> Bool
match_rule_47_section_32_g_9 deposits =
    List.member deposits.product [ o_D_9, o_D_10, o_D_11 ]


{-| (48) Insured Unsecured Wholesale Non-Operational Non-Financial (§.32(h)(1)(i))
-}
match_rule_48_section_32_h_1_i : FromDate -> Deposits -> Bool
match_rule_48_section_32_h_1_i fromDate deposits =
    List.member deposits.product [ o_D_5, o_D_6 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: NULL or Other
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isOther class) |> Maybe.withDefault True)


{-| (49) Not Fully Insured Unsecured Wholesale Non-Operational Non-Financial (§.32(h)(1)(ii)(A))
-}
match_rule_49_section_32_h_1_ii_A : FromDate -> Deposits -> Bool
match_rule_49_section_32_h_1_ii_A fromDate deposits =
    List.member deposits.product [ o_D_5, o_D_6 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: NULL or Other
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isOther class) |> Maybe.withDefault True)


{-| (52) Unsecured Wholesale Brokered Deposit Non-Operational Non-Financial (§.32(h)(1)(ii)(B))
-}
match_rule_52_section_32_h_1_ii_B : FromDate -> Deposits -> Bool
match_rule_52_section_32_h_1_ii_B fromDate deposits =
    List.member deposits.product [ o_D_8, o_D_9, o_D_10, o_D_11, o_D_13 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: NULL or Other
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isOther class) |> Maybe.withDefault True)


{-| (53) Financial Non-Operational (§.32(h)(2))
-}
match_rule_53_section_32_h_2 : FromDate -> Deposits -> Bool
match_rule_53_section_32_h_2 fromDate deposits =
    List.member deposits.product [ o_D_5, o_D_6, o_D_8, o_D_9, o_D_10, o_D_11, o_D_13 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: NULL or Other
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isOther class) |> Maybe.withDefault True)


{-| (57) Insured Operational Deposits (§.32(h)(3))
-}
match_rule_57_section_32_h_3 : FromDate -> Deposits -> Bool
match_rule_57_section_32_h_3 fromDate deposits =
    List.member deposits.product [ o_D_4 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: NULL or Other
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isOther class) |> Maybe.withDefault True)


{-| (58) Not Fully Insured Operational Deposits (§.32(h)(4))
-}
match_rule_58_section_32_h_4 : FromDate -> Deposits -> Bool
match_rule_58_section_32_h_4 fromDate deposits =
    List.member deposits.product [ o_D_4 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: NULL or Other
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isOther class) |> Maybe.withDefault True)


{-| (59) Not Fully Insured Operational Deposits (§.32(h)(4))
-}
match_rule_59_section_32_h_4 : FromDate -> Deposits -> Bool
match_rule_59_section_32_h_4 fromDate deposits =
    List.member deposits.product [ o_D_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: NULL or Other
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isOther class) |> Maybe.withDefault True)


{-| (60) Other Unsecured Wholesale (§.32(h)(5))
-}
match_rule_60_section_32_h_5 : FromDate -> Deposits -> Bool
match_rule_60_section_32_h_5 fromDate deposits =
    List.member deposits.product [ o_D_14, o_D_15 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: NULL or Other
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isOther class) |> Maybe.withDefault True)


{-| (64) Secured Funding L1 (§.32(j)(1)(i))
-}
match_rule_64_section_32_j_1_i : FromDate -> Deposits -> Bool
match_rule_64_section_32_j_1_i fromDate deposits =
    List.member deposits.product [ o_D_4, o_D_5, o_D_6, o_D_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: Level 1 HQLA
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel1 class) |> Maybe.withDefault False)


{-| (67) Secured Funding L2A (§.32(j)(1)(ii))
-}
match_rule_67_section_32_j_1_ii : FromDate -> Deposits -> Bool
match_rule_67_section_32_j_1_ii fromDate deposits =
    List.member deposits.product [ o_D_4, o_D_5, o_D_6, o_D_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: Level 2A HQLA
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2A class) |> Maybe.withDefault False)


{-| (70) Secured Funding from Governmental Entities not L1 or L2A (§.32(j)(1)(iii))
-}
match_rule_70_section_32_j_1_iii : FromDate -> Deposits -> Bool
match_rule_70_section_32_j_1_iii fromDate deposits =
    List.member deposits.product [ o_D_4, o_D_5, o_D_6, o_D_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: Level 2B HQLA or Non-HQLA
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class || not (CollateralClass.isHQLA class)) |> Maybe.withDefault False)


{-| (72) Secured Funding L2B (§.32(j)(1)(iv))
-}
match_rule_72_section_32_j_1_iv : FromDate -> Deposits -> Bool
match_rule_72_section_32_j_1_iv fromDate deposits =
    List.member deposits.product [ o_D_4, o_D_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Counterparty
        && List.member deposits.counterparty
            [ Counterparty.Non_Financial_Corporate
            , Counterparty.Public_Sector_Entity
            , Counterparty.Other_Supranational
            , Counterparty.Pension_Fund
            , Counterparty.Bank
            , Counterparty.Broker_Dealer
            , Counterparty.Investment_Company_or_Advisor
            , Counterparty.Financial_Market_Utility
            , Counterparty.Other_Supervised_Non_Bank_Financial_Entity
            , Counterparty.Non_Regulated_Fund
            , Counterparty.Debt_Issuing_Special_Purpose_Entity
            , Counterparty.Other
            ]
        -- Collateral Class: Level 2B HQLA
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class) |> Maybe.withDefault False)
        -- Rehopythecated: Y
        && deposits.rehypothecated
        == Just True


rule_72_section_32_j_1_iv_amount : Deposits -> List RuleBalance
rule_72_section_32_j_1_iv_amount deposits =
    case deposits.collateralValue of
        Just collateralValue ->
            if collateralValue < deposits.maturityAmount then
                [ RuleBalance "32(h)" (deposits.maturityAmount - collateralValue)
                , RuleBalance "32(j)(1)(iv))" deposits.maturityAmount
                ]

            else
                [ RuleBalance "32(j)(1)(iv))" deposits.maturityAmount ]

        _ ->
            []


apply_rule_72_section_32_j_1_iv : FromDate -> Deposits -> List RuleBalance
apply_rule_72_section_32_j_1_iv fromDate deposits =
    if match_rule_72_section_32_j_1_iv fromDate deposits then
        rule_72_section_32_j_1_iv_amount deposits

    else
        []


{-| (73) Secured Funding L2B (§.32(j)(1)(iv))
-}
match_rule_73_section_32_j_1_iv : FromDate -> Deposits -> Bool
match_rule_73_section_32_j_1_iv fromDate deposits =
    List.member deposits.product [ o_D_5, o_D_6 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: Level 2B HQLA
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class) |> Maybe.withDefault False)


{-| (77) Secured Funding Non-HQLA (§.32(j)(1)(vi))
-}
match_rule_77_section_32_j_1_vi : FromDate -> Deposits -> Bool
match_rule_77_section_32_j_1_vi fromDate deposits =
    List.member deposits.product [ o_D_4, o_D_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: Non-HQLA
        && (deposits.collateralClass |> Maybe.map (\class -> not (CollateralClass.isHQLA class)) |> Maybe.withDefault False)


{-| (78) Secured Funding Non-HQLA (§.32(j)(1)(vi))
-}
match_rule_78_section_32_j_1_vi : FromDate -> Deposits -> Bool
match_rule_78_section_32_j_1_vi fromDate deposits =
    List.member deposits.product [ o_D_5, o_D_6 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: Non-HQLA
        && (deposits.collateralClass |> Maybe.map (\class -> not (CollateralClass.isHQLA class)) |> Maybe.withDefault False)


{-| (81) Secured but Lower Unsecured Rate (§.32(j)(2))
-}
match_rule_81_section_32_j_2 : FromDate -> Deposits -> Bool
match_rule_81_section_32_j_2 fromDate deposits =
    List.member deposits.product [ o_D_5, o_D_6 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: Level 2B HQLA or Non-HQLA
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class || not (CollateralClass.isHQLA class)) |> Maybe.withDefault False)


{-| (83) Secured but Lower Unsecured Rate (§.32(j)(2))
-}
match_rule_83_section_32_j_2 : FromDate -> Deposits -> Bool
match_rule_83_section_32_j_2 fromDate deposits =
    List.member deposits.product [ o_D_4 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: If FDIC insured: Not Level 1; if not FDIC insured: Level 2B or Non-HQLA
        && (if Insured.isFDICInsured deposits.insured then
                deposits.collateralClass |> Maybe.map (\class -> not (CollateralClass.isHQLALevel1 class)) |> Maybe.withDefault True

            else
                deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class || not (CollateralClass.isHQLA class)) |> Maybe.withDefault False
           )


{-| (84) Secured but Lower Unsecured Rate (§.32(j)(2))
-}
match_rule_84_section_32_j_2 : FromDate -> Deposits -> Bool
match_rule_84_section_32_j_2 fromDate deposits =
    List.member deposits.product [ o_D_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
        -- Collateral Class: Level 2B HQLA or Non-HQLA
        && (deposits.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class || not (CollateralClass.isHQLA class)) |> Maybe.withDefault False)


{-| (98) Foreign Central Banking Borrowing (§.32(k))
-}
match_rule_98_section_32_k : FromDate -> Deposits -> Bool
match_rule_98_section_32_k fromDate deposits =
    List.member deposits.product [ o_D_4, o_D_5, o_D_6, o_D_7 ]
        -- Maturity Bucket: <= 30 calendar days
        && MaturityBucket.isLessThanOrEqual30Days fromDate deposits.maturityBucket
