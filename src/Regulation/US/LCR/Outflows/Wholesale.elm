module Regulation.US.LCR.Outflows.Wholesale exposing (..)


import Regulation.US.FR2052A.DataTables.Outflows.Wholesale exposing (..)
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.FR2052A.Fields.Insured as Insured
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct
import Regulation.US.LCR.AmountCalculations exposing (..)
import Regulation.US.LCR.Rule exposing (applyRule)


applyRules : Wholesale -> List ( String, Float )
applyRules flow =
    List.concat
        [ applyRule (match_rule_17_section_32_a_5 flow) "32(a)(5)" flow.maturityAmount
        , applyRule (match_rule_50_section_32_h_1_ii_A flow) "32(h)(1)(ii)(A)" flow.maturityAmount
        , applyRule (match_rule_54_section_32_h_2 flow) "32(h)(2)" flow.maturityAmount
        , applyRule (match_rule_56_section_32_h_2 flow) "32(h)(2)" flow.maturityAmount
        , applyRule (match_rule_61_section_32_h_5 flow) "32(h)(5)" flow.maturityAmount
        , applyRule (match_rule_66_section_32_j_1_i flow) "32(j)(1)(i)" flow.maturityAmount
        , applyRule (match_rule_69_section_32_j_1_ii flow) "32(j)(1)(ii)" flow.maturityAmount
        , applyRule (match_rule_75_section_32_j_1_iv flow) "32(j)(1)(iv)" flow.maturityAmount
        , applyRule (match_rule_80_section_32_j_1_vi flow) "32(j)(1)(vi)" flow.maturityAmount
        ]


{-| (17) Other Retail Funding (§.32(a)(5))
-}
match_rule_17_section_32_a_5 : Wholesale -> Bool
match_rule_17_section_32_a_5 flow =
    List.member flow.product [ o_W_18 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (50) Not Fully Insured Unsecured Wholesale Non-Operational Non-Financial (§.32(h)(1)(ii)(A))
-}
match_rule_50_section_32_h_1_ii_A : Wholesale -> Bool
match_rule_50_section_32_h_1_ii_A flow =
    List.member flow.product [ o_W_9, o_W_10, o_W_17, o_W_18 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (54) Financial Non-Operational (§.32(h)(2))
-}
match_rule_54_section_32_h_2 : Wholesale -> Bool
match_rule_54_section_32_h_2 flow =
    List.member flow.product [ o_W_9, o_W_10, o_W_17, o_W_18 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (56) Issued Debt Securities Maturing within 30 Days (§.32(h)(2))
-}
match_rule_56_section_32_h_2 : Wholesale -> Bool
match_rule_56_section_32_h_2 flow =
    List.member flow.product [ o_W_8, o_W_11, o_W_12, o_W_13, o_W_14, o_W_15, o_W_16 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (61) Other Unsecured Wholesale (§.32(h)(5))
-}
match_rule_61_section_32_h_5 : Wholesale -> Bool
match_rule_61_section_32_h_5 flow =
    List.member flow.product [ o_W_19 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (66) Secured Funding L1 (§.32(j)(1)(i))
-}
match_rule_66_section_32_j_1_i : Wholesale -> Bool
match_rule_66_section_32_j_1_i flow =
    List.member flow.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Level 1 HQLA
    && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel1 class) |> Maybe.withDefault False)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (69) Secured Funding L2A (§.32(j)(1)(ii))
-}
match_rule_69_section_32_j_1_ii : Wholesale -> Bool
match_rule_69_section_32_j_1_ii flow =
    List.member flow.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Level 2A HQLA
    && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2A class) |> Maybe.withDefault False)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (75) Secured Funding L2B (§.32(j)(1)(iv))
-}
match_rule_75_section_32_j_1_iv : Wholesale -> Bool
match_rule_75_section_32_j_1_iv flow =
    List.member flow.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Level 2B HQLA
    && (flow.collateralClass |> Maybe.map (\class -> CollateralClass.isHQLALevel2B class) |> Maybe.withDefault False)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)


{-| (80) Secured Funding Non-HQLA (§.32(j)(1)(vi))
-}
match_rule_80_section_32_j_1_vi : Wholesale -> Bool
match_rule_80_section_32_j_1_vi flow =
    List.member flow.product [ o_W_1, o_W_2, o_W_3, o_W_4, o_W_5, o_W_6, o_W_7 ]
    -- Maturity Bucket: <= 30 calendar days
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket)
    -- Collateral Class: Non-HQLA
    && (flow.collateralClass |> Maybe.map (\class -> not (CollateralClass.isHQLA class)) |> Maybe.withDefault False)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)