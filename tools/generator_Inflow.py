from enum import Enum
import json
from random import randrange
import datetime

currency_Value = Enum('currency', ['USD', "EUR", "GBP", "CHF","JPY", "AUD", "CAD"])
converted_Value = Enum('converted', ['True', 'False'] )
Inflow_asset_product_Value = Enum('Inflow_asset_product', ['I.A.1', "I.A.2", "I.A.3", "I.A.7","I.A.4","I.A.5",  "I.A.6" ])
Inflow_other_product_Value = Enum('Inflow_other_product', ['I.O.1', "I.O.2", "I.O.3", "I.O.4","I.O.5",  "I.O.6" , "I.O.7", "I.O.8", "I.O.9", "I.O.10" ])
Inflow_secured_product_Value = Enum('Inflow_secured_product', ['I.S.1', "I.S.2", "I.S.3","I.S.4","I.S.5",  "I.S.6" , "I.S.7", "I.S.8", "I.S.9", "I.S.10" ])
Inflow_unsecured_product_Value = Enum('Inflow_unsecured_product', ['I.U.1', "I.U.2", "I.U.3", "I.U.4","I.U.5",  "I.U.6" , "I.U.7", "I.U.8" ])
reportingEntity_Value = "ABC123"
subProductValue = "XYZ123"
forwardStartAmount = "forwardStartAmount123"
forwardStartBucket = "forwardStartBucket123"
encumbranceType = "encumbranceType123"
internalCounterparty = "internalCounterparty123"
marketValue = 1821323.34
lendableValue = "RST123"
maturityBucketList = [["Open"], ["Day", 0], ["Days", 61, 67], ["Days", 68, 74] , ["Days", 75, 82] , ["Days", 83, 90], ["Days", 91, 120], ["Days", 121, 150], ["Days", 151, 179], ["Days", 180, 270], ["Days", 271, 364] ,["Perpetual"] ]
forwardStartAmountValue = 1374.22
# forwardStartBucketValue = maturityBucketValue
collateralClassValue = "XYZ98765"
gSIB = "gsib123"
riskWeight = "RiskWeight123"
treasuryControlValue = Enum('treasuryControl', ['True', 'False'] )
accountingDesignationValue = "WTE123"
businessLine = "KFC83"
other_internal = "TT11"
other_maturityAmount = 28432.4
securedCollateralValue = 3532.32
securedUnencumberedValue = Enum('securedUnencumbered', ['True', 'False'] )
securedSettlement = "settle1232"
securedCounterpartyValue = Enum('securedCounterparty', ['Retail', 'Small_Business', 'Non_Financial_Corporate', 'Sovereign', 'Government_Sponsored_Entity', 'Central_Bank', 'Public_Sector_Entity', 'Multilateral_Development_Bank', 'Other_Supranational', 'Pension_Fund', 'Bank', 'Broker_Dealer', 'Investment_Company_or_Advisor', 'Financial_Market_Utility', 'Other_Supervised_Non_Bank_Financial_Entity', 'Debt_Issuing_Special_Purpose_Entity', 'Non_Regulated_Fund', 'Other'] )

def rand_date():
    now_date = datetime.datetime.now()
    now_date = datetime.date.today()
    date1 = datetime.datetime.strptime(str(now_date), "%Y-%m-%d")
    end_date = date1.replace(minute=0, second=0, microsecond=0) + datetime.timedelta(days=randrange(1, 1825)) #1825 days
    str_end_date = str(end_date)
    return str_end_date.split(' ')[0]

def inflowSample():
    asset_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for Inflow_asset_product in Inflow_asset_product_Value:
                for maturityBucket in maturityBucketList:
                    for treasuryControl in treasuryControlValue:
                        if maturityBucket[0] == 'Day':
                            count = 1
                            for i in range(1,61):
                                maturityBucket[1] = i
                                asset_object = {
                                'Currency' : currency.name, 
                                'Converted' : converted.name,
                                'ReportingEntity': reportingEntity_Value, 
                                'Product' :Inflow_asset_product.name,
                                'MarketValue' : marketValue, 
                                'LendableValue' : lendableValue,
                                'MaturityBucket' : maturityBucket,
                                'CollateralClass' : collateralClassValue,
                                'TreasuryControl' :treasuryControl.name,
                                'AccountingDesignation':accountingDesignationValue,
                                'BusinessLine' : businessLine,
                                'MaturityDate': rand_date()
                               }
                                asset_samples.append(asset_object)
                        else:
                            asset_object = {
                                'Currency' : currency.name, 
                                'Converted' : converted.name,
                                'ReportingEntity': reportingEntity_Value, 
                                'Product' :Inflow_asset_product.name,
                                'MarketValue' : marketValue, 
                                'LendableValue' : lendableValue,
                                'MaturityBucket' : maturityBucket,
                                'CollateralClass' : collateralClassValue,
                                'TreasuryControl' :treasuryControl.name,
                                'AccountingDesignation':accountingDesignationValue,
                                'BusinessLine' : businessLine,
                                'MaturityDate': rand_date()
                                } 
                    asset_samples.append(asset_object)
    return asset_samples

def inflowMaybeSample():
    asset_maybe_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for Inflow_asset_product in Inflow_asset_product_Value:
                for maturityBucket in maturityBucketList:
                    for treasuryControl in treasuryControlValue:
                        if maturityBucket[0] == 'Day':
                            count = 1
                            for i in range(1,61):
                                maturityBucket[1] = i
                                asset_object = {
                                'Currency' : currency.name, 
                                'Converted' : converted.name,
                                'ReportingEntity': reportingEntity_Value, 
                                'Product' :Inflow_asset_product.name,
                                "SubProduct":subProductValue,
                                "ForwardStartAmount":forwardStartAmount,
                                "ForwardStartBucket":forwardStartBucket,
                                'MarketValue' : marketValue, 
                                'LendableValue' : lendableValue,
                                'MaturityBucket' : maturityBucket,
                                "EffectiveMaturityBucket" :maturityBucket,
                                'CollateralClass' : collateralClassValue,
                                'TreasuryControl' :treasuryControl.name,
                                'AccountingDesignation':accountingDesignationValue,
                                'EncumbranceType':encumbranceType,
                                'InternalCounterparty':internalCounterparty,
                                'BusinessLine' : businessLine,
                                'MaturityDate': rand_date()
                                }
                                asset_maybe_samples.append(asset_object)
                        else:
                            asset_object = {
                                'Currency' : currency.name, 
                                'Converted' : converted.name,
                                'ReportingEntity': reportingEntity_Value, 
                                'Product' :Inflow_asset_product.name,
                                "SubProduct":subProductValue,
                                "ForwardStartAmount":forwardStartAmount,
                                "ForwardStartBucket":forwardStartBucket,
                                'MarketValue' : marketValue, 
                                'LendableValue' : lendableValue,
                                'MaturityBucket' : maturityBucket,
                                "EffectiveMaturityBucket" :maturityBucket,
                                'CollateralClass' : collateralClassValue,
                                'TreasuryControl' :treasuryControl.name,
                                'AccountingDesignation':accountingDesignationValue,
                                'EncumbranceType':encumbranceType,
                                'InternalCounterparty':internalCounterparty,
                                'BusinessLine' : businessLine,
                                'MaturityDate': rand_date()
                                } 
                    asset_maybe_samples.append(asset_object)
    return asset_maybe_samples

def inflowOtherSample():
    other_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for Inflow_other_product in Inflow_other_product_Value:
                for maturityBucket in maturityBucketList:
                    for treasuryControl in treasuryControlValue:
                        if maturityBucket[0] == 'Day':
                            count = 1
                            for i in range(1,61):
                                maturityBucket[1] = i
                                other_object = {
                                'Currency' : currency.name, 
                                'Converted' : converted.name,
                                'ReportingEntity': reportingEntity_Value, 
                                'Product' :Inflow_other_product.name,
                                'MaturityAmount' : other_maturityAmount , 
                                'MaturityBucket' : maturityBucket,
                                'CollateralClass' : collateralClassValue,
                                'TreasuryControl' :treasuryControl.name,
                                'internal':other_internal,
                                'BusinessLine' : businessLine,
                                'MaturityDate': rand_date()
                                }
                                other_samples.append(other_object)
                        else:
                            other_object = {
                                'Currency' : currency.name, 
                                'Converted' : converted.name,
                                'ReportingEntity': reportingEntity_Value, 
                                'Product' :Inflow_other_product.name,
                                'MaturityAmount' : other_maturityAmount , 
                                'MaturityBucket' : maturityBucket,
                                'CollateralClass' : collateralClassValue,
                                'TreasuryControl' :treasuryControl.name,
                                'internal':other_internal,
                                'BusinessLine' : businessLine,
                                'MaturityDate': rand_date()
                                } 
                    other_samples.append(other_object)
    return other_samples

def inflowOtherMaybeSample():
    other_maybe_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for Inflow_other_product in Inflow_other_product_Value:
                for maturityBucket in maturityBucketList:
                    for treasuryControl in treasuryControlValue:
                        if maturityBucket[0] == 'Day':
                            count = 1
                            for i in range(1,61):
                                maturityBucket[1] = i
                                other_object = {
                                'Currency' : currency.name, 
                                'Converted' : converted.name,
                                'ReportingEntity': reportingEntity_Value, 
                                'Product' :Inflow_other_product.name,
                                'MaturityAmount' : other_maturityAmount , 
                                'MaturityBucket' : maturityBucket,
                                'CollateralClass' : collateralClassValue,
                                'collateralValue':securedCollateralValue,
                                'TreasuryControl' :treasuryControl.name,
                                'GSIB':gSIB,
                                'internal':other_internal,
                                'InternalCounterparty':internalCounterparty,
                                'BusinessLine' : businessLine,
                                'MaturityDate': rand_date()
                                }
                                other_samples.append(other_object)
                        else:
                            other_object = {
                                'Currency' : currency.name, 
                                'Converted' : converted.name,
                                'ReportingEntity': reportingEntity_Value, 
                                'Product' :Inflow_other_product.name,
                                'MaturityAmount' : other_maturityAmount , 
                                'MaturityBucket' : maturityBucket,
                                'CollateralClass' : collateralClassValue,
                                'collateralValue':securedCollateralValue,
                                'TreasuryControl' :treasuryControl.name,
                                'GSIB':gSIB,
                                'internal':other_internal,
                                'InternalCounterparty':internalCounterparty,
                                'BusinessLine' : businessLine,
                                'MaturityDate': rand_date()
                                } 
                    other_maybe_samples.append(other_object)
    return other_maybe_samples

def inflowSecuredSample():
    secured_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for Inflow_secured_product in Inflow_secured_product_Value:
                for maturityBucket in maturityBucketList:
                    for treasuryControl in treasuryControlValue:
                        for securedUnencumbered in securedUnencumberedValue:
                           for securedCounterparty in  securedCounterpartyValue:
                                if maturityBucket[0] == 'Day':
                                    count = 1
                                    for i in range(1,61):
                                        maturityBucket[1] = i
                                        secured_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' :Inflow_secured_product.name,
                                        "SubProduct":subProductValue,
                                        'MaturityAmount' : other_maturityAmount , 
                                        'MaturityBucket' : maturityBucket,
                                        'CollateralClass' : collateralClassValue,
                                        'CollateralValue' : securedCollateralValue,
                                        'Unencumbered' :securedUnencumbered.name,
                                        'TreasuryControl' :treasuryControl.name,
                                        'internal':other_internal,
                                        'BusinessLine' : businessLine,
                                        'Settlement' :   securedSettlement,
                                        'Counterparty' : securedCounterparty.name ,
                                        'MaturityDate': rand_date()                           }
                                        secured_samples.append(secured_object)
                                else:
                                        secured_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' :Inflow_secured_product.name,
                                         "SubProduct":subProductValue,
                                        'MaturityAmount' : other_maturityAmount , 
                                        'MaturityBucket' : maturityBucket,
                                        'CollateralClass' : collateralClassValue,
                                        'CollateralValue' : securedCollateralValue,
                                        'Unencumbered' :securedUnencumbered.name,
                                        'TreasuryControl' :treasuryControl.name,
                                        'internal':other_internal,
                                        'BusinessLine' : businessLine,
                                        'Settlement' :   securedSettlement,
                                        'Counterparty' : securedCounterparty.name,
                                        'MaturityDate': rand_date() 
                                            } 
                                        secured_samples.append(secured_object)
    return secured_samples


def inflowSecuredMaybeSample():
    secured_maybe_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for Inflow_secured_product in Inflow_secured_product_Value:
                for maturityBucket in maturityBucketList:
                    for treasuryControl in treasuryControlValue:
                        for securedUnencumbered in securedUnencumberedValue:
                           for securedCounterparty in  securedCounterpartyValue:
                                if maturityBucket[0] == 'Day':
                                    for i in range(1,61):
                                        maturityBucket[1] = i
                                        secured_maybe_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' :Inflow_secured_product.name,
                                        'MaturityAmount' : other_maturityAmount , 
                                        'MaturityBucket' : maturityBucket,
                                        "EffectiveMaturityBucket" :maturityBucket,
                                        "EncumbranceType":encumbranceType,
                                        'ForwardStartAmount':forwardStartAmount,
                                        'ForwardStartBucket':forwardStartBucket,
                                        'CollateralClass' : collateralClassValue,
                                        'CollateralValue' : securedCollateralValue,
                                        'Unencumbered' :securedUnencumbered.name,
                                        'TreasuryControl' :treasuryControl.name,
                                        'internal':other_internal,
                                        'InternalCounterparty':internalCounterparty,
                                        'RiskWeight':riskWeight,
                                        'BusinessLine' : businessLine,
                                        'Settlement' :   securedSettlement,
                                        'Counterparty' : securedCounterparty.name,
                                        'GSIB':gSIB,
                                        'MaturityDate': rand_date()                            }
                                        secured_maybe_samples.append(secured_maybe_object)
                                else:
                                        secured_maybe_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' :Inflow_secured_product.name,
                                        'MaturityAmount' : other_maturityAmount , 
                                        'MaturityBucket' : maturityBucket,
                                        "EffectiveMaturityBucket" :maturityBucket,
                                        "EncumbranceType":encumbranceType,
                                        'ForwardStartAmount':forwardStartAmount,
                                        'ForwardStartBucket':forwardStartBucket,
                                        'CollateralClass' : collateralClassValue,
                                        'CollateralValue' : securedCollateralValue,
                                        'Unencumbered' :securedUnencumbered.name,
                                        'TreasuryControl' :treasuryControl.name,
                                        'internal':other_internal,
                                        'InternalCounterparty':internalCounterparty,
                                        'RiskWeight':riskWeight,
                                        'BusinessLine' : businessLine,
                                        'Settlement' :   securedSettlement,
                                        'Counterparty' : securedCounterparty.name,
                                        'GSIB':gSIB,
                                        'MaturityDate': rand_date() 
                                            } 
                                        secured_maybe_samples.append(secured_maybe_object)
    return secured_maybe_samples

def inflowUnSecuredSample():
        unsecured_samples = []
        for currency in currency_Value:
            for converted in converted_Value:
                for Inflow_unsecured_product in Inflow_unsecured_product_Value:
                    for maturityBucket in maturityBucketList:
                        for securedUnencumbered in securedUnencumberedValue:
                            for securedCounterparty in  securedCounterpartyValue:
                                if maturityBucket[0] == 'Day':
                                    for i in range(1,61):
                                        maturityBucket[1] = i
                                        unsecured_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' :Inflow_unsecured_product.name,
                                        'MaturityAmount' : other_maturityAmount , 
                                        'MaturityBucket' : maturityBucket,
                                        'CollateralClass' : collateralClassValue,
                                        'CollateralValue' : securedCollateralValue,
                                        'Unencumbered' :securedUnencumbered.name,
                                        'internal':other_internal,
                                        'BusinessLine' : businessLine,
                                        'Counterparty' : securedCounterparty.name,
                                        'MaturityDate': rand_date()                            }
                                        unsecured_samples.append(unsecured_object)
                                    else:
                                        unsecured_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' :Inflow_unsecured_product.name,
                                        'MaturityAmount' : other_maturityAmount , 
                                        'MaturityBucket' : maturityBucket,
                                        'CollateralClass' : collateralClassValue,
                                        'CollateralValue' : securedCollateralValue,
                                        'Unencumbered' :securedUnencumbered.name,
                                        'internal':other_internal,
                                        'BusinessLine' : businessLine,
                                        'Counterparty' : securedCounterparty.name,
                                        'MaturityDate': rand_date() 
                                        } 
                                        unsecured_samples.append(unsecured_object)
        return unsecured_samples

def inflowUnSecuredMaybeSample():
        unsecured_maybe_samples = []
        for currency in currency_Value:
            for converted in converted_Value:
                for Inflow_unsecured_product in Inflow_unsecured_product_Value:
                    for maturityBucket in maturityBucketList:
                        for securedUnencumbered in securedUnencumberedValue:
                            for securedCounterparty in  securedCounterpartyValue:
                                if maturityBucket[0] == 'Day':
                                    for i in range(1,61):
                                        maturityBucket[1] = i
                                        unsecured_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' :Inflow_unsecured_product.name,
                                        'MaturityAmount' : other_maturityAmount , 
                                        'MaturityBucket' : maturityBucket,
                                        'EncumbranceType':encumbranceType,
                                         "ForwardStartAmount":forwardStartAmount,
                                         "ForwardStartBucket":forwardStartBucket,
                                        "EffectiveMaturityBucket":maturityBucket,
                                        'CollateralClass' : collateralClassValue,
                                        'CollateralValue' : securedCollateralValue,
                                        'Unencumbered' :securedUnencumbered.name,
                                        'internal':other_internal,
                                        'InternalCounterparty':internalCounterparty,
                                        'RiskWeight':riskWeight,
                                        'BusinessLine' : businessLine,
                                        'Counterparty' : securedCounterparty.name,
                                        'MaturityDate': rand_date()                            }
                                        unsecured_maybe_samples.append(unsecured_object)
                                    else:
                                        unsecured_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' :Inflow_unsecured_product.name,
                                        'MaturityAmount' : other_maturityAmount , 
                                        'MaturityBucket' : maturityBucket,
                                        'EncumbranceType':encumbranceType,
                                        "ForwardStartAmount":forwardStartAmount,
                                        "ForwardStartBucket":forwardStartBucket,
                                        "EffectiveMaturityBucket":maturityBucket,
                                        'CollateralClass' : collateralClassValue,
                                        'CollateralValue' : securedCollateralValue,
                                        'Unencumbered' :securedUnencumbered.name,
                                        'internal':other_internal,
                                        'InternalCounterparty':internalCounterparty,
                                        'RiskWeight':riskWeight,
                                        'BusinessLine' : businessLine,
                                        'Counterparty' : securedCounterparty.name,
                                        'MaturityDate': rand_date() 
                                        } 
                                        unsecured_maybe_samples.append(unsecured_object)
        return unsecured_maybe_samples
asset_samples = inflowSample()
asset_maybe_samples =inflowMaybeSample()
other_samples = inflowOtherSample()
secured_samples = inflowSecuredSample()
unsecured_samples = inflowUnSecuredSample()
other_maybe_samples = inflowOtherMaybeSample()
secured_maybe_samples=inflowSecuredMaybeSample()
unsecured_maybe_samples = inflowUnSecuredMaybeSample()

with open("InflowAsset.json", "w") as outfile:
    json.dump(asset_samples, outfile)

with open("InflowAssetMaybe.json", "w") as outfile:
    json.dump(asset_maybe_samples, outfile)

with open("Inflowother.json", "w") as outfile:
    json.dump(other_samples, outfile)

with open("InflowotherMaybe.json", "w") as outfile:
    json.dump(other_maybe_samples, outfile)

with open("InflowSecured.json", "w") as outfile:
    json.dump(secured_samples, outfile)

with open("InflowMaybeSecured.json", "w") as outfile:
    json.dump(secured_maybe_samples, outfile)

with open("InflowUnSecured.json", "w") as outfile:
    json.dump(unsecured_samples, outfile)

with open("InflowMaybeUnSecured.json", "w") as outfile:
    json.dump(unsecured_maybe_samples, outfile)
print("Product :")

for asset in (asset_samples):
    print (asset)