module Regulation.US.LCR.Inflows.Assets exposing (..)


import Regulation.US.FR2052A.DataTables.Inflows.Assets exposing (..)
import Regulation.US.FR2052A.Fields.CollateralClass as CollateralClass
import Regulation.US.FR2052A.Fields.Insured as Insured
import Regulation.US.FR2052A.Fields.MaturityBucket as MaturityBucket
import Regulation.US.FR2052A.Fields.SubProduct as SubProduct
import Regulation.US.LCR.AmountCalculations exposing (..)
import Regulation.US.LCR.Rule exposing (applyRule)


applyRules : Assets -> List ( String, Float )
applyRules flow =
    List.concat
        [ applyRule (match_rule_1_section_20_a_1_C flow) "20(a)(1)C" flow.marketValue
        , applyRule (match_rule_1_section_20_a_1 flow) "20(a)(1)" flow.marketValue
        , applyRule (match_rule_1_section_20_b_1 flow) "20(b)(1)" flow.marketValue
        , applyRule (match_rule_1_section_20_c_1 flow) "20(c)(1)" flow.marketValue
        , applyRule (match_rule_107_section_33_d_1 flow) "33(d)(1)" flow.marketValue
        ]


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
match_rule_1_section_20_a_1_C : Assets -> Bool
match_rule_1_section_20_a_1_C flow =
    List.member flow.product [ i_A_3 ]
    -- Sub-Product: Not Currency and Coin
    && (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
    -- Maturity Bucket: Open
    && (MaturityBucket.isOpen flow.maturityBucket)
    -- Collateral Class: A-0-Q
    && (CollateralClass.isCash flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Encumbrance Type: Null
    && (flow.encumbranceType == Nothing)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
match_rule_1_section_20_a_1 : Assets -> Bool
match_rule_1_section_20_a_1 flow =
    List.member flow.product [ i_A_1, i_A_2 ]
    -- Sub-Product: Not Currency and Coin
    && (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
    -- Collateral Class: A-1-Q; A-2-Q; A-3-Q; A-4-Q; A-5-Q; S-1-Q; S-2-Q; S-3-Q; S-4-Q; CB-1-Q; CB-2-Q
    && (CollateralClass.isHQLALevel1 flow.collateralClass && not (CollateralClass.isCash flow.collateralClass))
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Encumbrance Type: Null
    && (flow.encumbranceType == Nothing)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
match_rule_1_section_20_b_1 : Assets -> Bool
match_rule_1_section_20_b_1 flow =
    List.member flow.product [ i_A_1, i_A_2 ]
    -- Sub-Product: Not Currency and Coin
    && (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
    -- Collateral Class: G-1-Q; G-2-Q; G-3-Q; S-5-Q; S-6-Q; S-7-Q; CB-3-Q
    && (CollateralClass.isHQLALevel2A flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Encumbrance Type: Null
    && (flow.encumbranceType == Nothing)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (1) High-Quality Liquid Assets (Subpart C, §.20-.22)
-}
match_rule_1_section_20_c_1 : Assets -> Bool
match_rule_1_section_20_c_1 flow =
    List.member flow.product [ i_A_1, i_A_2 ]
    -- Sub-Product: Not Currency and Coin
    && (flow.subProduct |> Maybe.map (\subProduct -> not (SubProduct.isCurrencyAndCoin subProduct)) |> Maybe.withDefault True)
    -- Collateral Class: E-1-Q; E-2-Q; IG-1-Q; IG-2-Q
    && (CollateralClass.isHQLALevel2B flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)
    -- Encumbrance Type: Null
    && (flow.encumbranceType == Nothing)
    -- Treasury Control: Y
    && (flow.treasuryControl == True)


{-| (107) Financial and Central Bank Cash Inflow Amount (§.33(d)(1))
-}
match_rule_107_section_33_d_1 : Assets -> Bool
match_rule_107_section_33_d_1 flow =
    List.member flow.product [ i_A_3 ]
    -- Maturity Bucket: <= 30 calendar days but not Open
    && (MaturityBucket.isLessThanOrEqual30Days flow.maturityBucket && not (MaturityBucket.isOpen flow.maturityBucket))
    -- Collateral Class: A-0-Q
    && (CollateralClass.isCash flow.collateralClass)
    -- Forward Start Amount: NULL
    && (flow.forwardStartAmount == Nothing)
    -- Forward Start Bucket: NULL
    && (flow.forwardStartBucket == Nothing)