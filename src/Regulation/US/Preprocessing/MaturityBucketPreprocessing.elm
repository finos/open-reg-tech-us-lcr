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

module Regulation.US.Preprocessing.MaturityBucketPreprocessing exposing (..)

import Regulation.US.FR2052A.DataTables exposing (..)

import Regulation.US.FR2052A.DataTables.Inflows.Assets as Assets 

import Regulation.US.FR2052A.DataTables.Inflows.Unsecured as Unsecured

import Regulation.US.FR2052A.DataTables.Inflows.Secured as Secured 

import Regulation.US.FR2052A.DataTables.Inflows.Other as Other 


type InflowsProductCategory
     = Assets Assets.Product
     | Unsecured Unsecured.Product
     | Secured Secured.Product
     | Other Other.Product

type MaturityBucket
    = Open
    | Day Int
    | DayRange Int Int
    | YearRange Int Int
    | YearAbove Int
    | Perpetual

type TPlusN
    = NumDays Int
    | IsPerpetual
    | IsOpen

type ProductType
    = Inflows InflowsProductCategory
    | OutflowOrSupplemental

type MaturityBucketBankCategory
    = US_Category_I_or_Category_II_banking_organizations_and_FBOS_identified_as_Category_II 
    | US_Category_III_or_Category_IV_banking_organizations_with_wSTWF_greater_than_50B_and_FBOS_identified_as_Category_III_or_IV_with_wSTWF_greater_than_50B
    | US_Category_IV_banking_organizations_with_wSTWF_less_than_50B_and_FBOS_identified_as_Category_IV_with_wSTWF_less_than_50B

isLessThanOrEqual30Days : MaturityBucket -> Bool
isLessThanOrEqual30Days maturityBucket =
    case maturityBucket of
        Day n ->
            n <= 30
        _ ->
            False

{- 

Maturity Bucket Classification based on Appendix IV-b: FR 2052a Maturity Bucket Tailoring

-}
maturity_bucket_tailoring : TPlusN -> MaturityBucketBankCategory -> ProductType -> MaturityBucket
maturity_bucket_tailoring days maturityBucketBankCategory productType =
    case maturityBucketBankCategory of
        US_Category_I_or_Category_II_banking_organizations_and_FBOS_identified_as_Category_II ->
            getBucketCaseOne days
        US_Category_III_or_Category_IV_banking_organizations_with_wSTWF_greater_than_50B_and_FBOS_identified_as_Category_III_or_IV_with_wSTWF_greater_than_50B ->
            getBucketCaseTwo days productType
        US_Category_IV_banking_organizations_with_wSTWF_less_than_50B_and_FBOS_identified_as_Category_IV_with_wSTWF_less_than_50B ->
            getBucketCaseThree days productType
           
            --getBucketCaseThree days productType


getBucketCaseOne : TPlusN -> MaturityBucket
getBucketCaseOne bucket =
    case bucket of 
        NumDays day ->
            if day > 0 && day <= 60 then 
                Day day
            else if day > 60 && day <= 90 then
                getWeeklyBucket day
            else if day > 90 && day <= 179 then
                get30DayBucket day
            else if day > 179 && day <= 364 then
                get90DayBucket day 
            else if day > 364 && day <= (365*5) then
                getYearlyBucket day 
            else
                YearAbove 5

        IsOpen ->
            Open

        IsPerpetual ->
            Perpetual


getBucketCaseTwo : TPlusN -> ProductType -> MaturityBucket
getBucketCaseTwo bucket productType =
    case productType of
        Inflows inflowsProductCategory ->
            inflow_buckets bucket

        OutflowOrSupplemental ->
            outflow_and_supplemental_buckets bucket


getBucketCaseThree : TPlusN -> ProductType -> MaturityBucket
getBucketCaseThree days productType =
    case productType of
    Inflows inflowsProductCategory ->
        case inflowsProductCategory of
                Assets a ->
                    --rule 3 a
                    if rule_3_a a then
                        rule_3_a_bucket days
                    --rule 3 c
                    else
                        inflow_buckets days
                Unsecured u ->
                    --rule 3b
                    if rule_3_b_u u then
                        rule_3_b_bucket days
                    --rule 3 c
                    else
                        inflow_buckets days
                Secured s ->
                    --rule 3b
                    if rule_3_b_s s then
                        rule_3_b_bucket days
                    --rule 3 c
                    else
                        inflow_buckets days
                Other o ->
                    inflow_buckets days

    OutflowOrSupplemental ->
        outflow_and_supplemental_buckets days



{-
getBucketCaseThree : TPlusN -> ProductType -> MaturityBucket
getBucketCaseThree days productType =
    case productType of
        Inflow ->
            case inflowProductType of
                Assets ->
                    --rule 3 a
                    if rule_3_a inflowAssetProduct then
                        rule_3_a_bucket days
                    --rule 3 c
                    else
                        inflow_buckets days
                Unsecured ->
                    --rule 3b
                    if rule_3_b_u inflowUnsecuredProduct then
                        rule_3_b_bucket days
                    --rule 3 c
                    else
                        inflow_buckets days
                Secured ->
                    --rule 3b
                    if rule_3_b_s inflowSecuredProduct then
                        rule_3_b_bucket days
                    --rule 3 c
                    else
                        inflow_buckets days
                Other ->
                    inflow_buckets days
        Outflow ->
            outflow_and_supplemental_buckets days
        Supplemental->
            outflow_and_supplemental_buckets days
-}
getWeeklyBucket : Int -> MaturityBucket
getWeeklyBucket day =
    if day > 60 && day <= 67 then 
        DayRange 61 67
    else if day > 67 && day <= 74 then 
        DayRange 68 74
    else if day > 74 && day <= 82 then 
        DayRange 75 82
    else
        DayRange 83 90

get30DayBucket : Int -> MaturityBucket
get30DayBucket day =
    if day > 90 && day <=120 then 
        DayRange 91 120
    else if day > 120 && day <= 150 then 
        DayRange 121 150
    else
        DayRange 151 179

get90DayBucket : Int -> MaturityBucket
get90DayBucket day =
    if day > 179 && day <= 270 then 
        DayRange 180 270
    else
        DayRange 271 364

getYearlyBucket : Int -> MaturityBucket
getYearlyBucket day =
    if day > 364 && day <= 365*2 then 
        YearRange 1 2
    else if day > 365*2 && day <= 365*3 then 
        YearRange 2 3
    else if day > 365*3 && day <= 365*4 then 
        YearRange 3 4
    else
        YearRange 4 5


rule_3_a : Assets.Product -> Bool
rule_3_a product =
    List.member product [Assets.i_A_1, Assets.i_A_2, Assets.i_A_7]

rule_3_a_bucket : TPlusN -> MaturityBucket
rule_3_a_bucket bucket =
    case bucket of
        NumDays day ->
            if day > 0 && day <= 182 then 
                Open
            else if day > 182 && day < 365 then
                DayRange  271 364
            else
                YearAbove 5
        IsOpen ->
            Open
        IsPerpetual ->
            Perpetual


rule_3_b_bucket : TPlusN -> MaturityBucket
rule_3_b_bucket bucket =
    case bucket of
        NumDays day ->
            if day > 0 && day <= 30 then 
                Day 30
            else
                YearAbove 5
        IsOpen ->
            Open
        IsPerpetual ->
            Perpetual        

rule_3_b_u : Unsecured.Product -> Bool
rule_3_b_u unsecuredProduct  =
    List.member unsecuredProduct [Unsecured.i_U_6]

rule_3_b_s : Secured.Product -> Bool
rule_3_b_s securedProduct =
    List.member securedProduct [Secured.i_S_7]


inflow_buckets : TPlusN -> MaturityBucket    
inflow_buckets bucket=
    case bucket of
        NumDays day ->
            if day > 0 && day <= 60 then 
                Day day
            else if day > 60 && day <= 90 then
                getWeeklyBucket day
            else if day > 90 && day <= 179 then
                get30DayBucket day
            else if day > 179 && day <= 364 then
                get90DayBucket day 
            else
                YearAbove 5
        IsOpen ->
            Open
        IsPerpetual ->
            Perpetual

outflow_and_supplemental_buckets : TPlusN -> MaturityBucket
outflow_and_supplemental_buckets bucket =
    case bucket of
        NumDays day ->
            if day > 0 && day <= 60 then 
                Day day
            else if day > 60 && day <= 90 then
                getWeeklyBucket day
            else if day > 90 && day <= 179 then
                get30DayBucket day
            else if day > 179 && day <= 364 then
                get90DayBucket day 
            else
                YearRange 1 2
        IsOpen ->
            Open
        IsPerpetual ->
            Perpetual

