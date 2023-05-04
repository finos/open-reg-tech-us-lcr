from enum import Enum
import json 
import os
from random import randrange
import datetime

currency_Value = Enum('currency', ['USD', "EUR", "GBP", "CHF","JPY", "AUD", "CAD"])
converted_Value = Enum('converted', ['True', 'False'] )
supplemental_balancesheet_product_value = Enum('supplemental_balancesheet_product', ['S.B.1', "S.B.2", "S.B.3","S.B.4","S.B.5",  "S.B.6" ])
supplemental_derivativescollateral_product_value = Enum('supplemental_derivativescollateral_product', ['S.DC.1', "S.DC.2", "S.DC.3","S.DC.4","S.DC.5", "S.DC.6", "S.DC.7", "S.DC.8", "S.DC.9", "S.DC.10", "S.DC.11", "S.DC.12", "S.DC.13", "S.DC.14", "S.DC.15", "S.DC.16", "S.DC.17", "S.DC.18", "S.DC.19", "S.DC.20", "S.DC.21" ])
supplemental_foreignexchange_product_value = Enum('supplemental_foreignexchange_product', ['S.FX.1', "S.FX.2", "S.FX.3"])
supplemental_informational_product_value = Enum('supplemental_informational_product', ['S.I.1', "S.I.2", "S.I.3","S.I.4","S.I.5",  "S.I.6" ])
supplemental_liquidityriskmeasurement_product_value = Enum('supplemental_liquidityriskmeasurement_product', ['S.L.1', "S.L.2", "S.L.3","S.L.4","S.L.5","S.L.6","S.L.7","S.L.8","S.L.9","S.L.10" ])
counterparty_value = Enum('counterparty', ["Retail", "Small_Business", "Non_Financial_Corporate", "Sovereign", "Central_Bank", "Government_Sponsored_Entity", "Public_Sector_Entity", "Multilateral_Development_Bank", "Other_Supranational", "Pension_Fund", "Bank", "Broker_Dealer", "Investement_Company_or_Advisor", "Financial_Market_Utility", "Other_Supervised_Non_Bank_Financial_Entity", "Debt_Issuing_Special_Purpose_Entity", "Non_Regulated_Fund", "Other"])
reportingEntity_Value = "reportingEntityABC123"
maturityBucketList = [["Open"], ["Day", 0], ["Days", 61, 67], ["Days", 68, 74] , ["Days", 75, 82] , ["Days", 83, 90], ["Days", 91, 120], ["Days", 121, 150], ["Days", 151, 179], ["Days", 180, 270], ["Days", 271, 364] ,["Perpetual"] ]
internalValue = "internalValueXYZ123"
# subProductValue = "XYZ123"
marketValue = 1821323.34
# lendableValue = "RST123"
# forwardStartAmountValue = 1374.22
# forwardStartBucketValue = maturityBucketValue
# collateralClassValue = "XYZ98765"
treasuryControlValue = Enum('treasuryControl', ['True', 'False'] )
# accountingDesignationValue = "WTE123"
businessLine = "businessLineKFC83"
settlement = "settlement"
collectionReference = 'someCollectionReference'
productReference = 'someProductReference'
subProdructReference = 'someSubProductReference'
collateralClass = 'someCollateralClass'
encumbranceType = 'someEncumbranceType'
maturityAmount = 2023.99
collateralValue = 2024.99
gsib = "someGSIB"
riskWeight = 'someRiskWeight'
internalCounterparty = 'someInternalCounterparty'

subProduct1 = "someSubProduct1"
subProduct2 = "someSubProduct2"
collateralClass = "someCollateralClass"
collateralLevel = "someCollateralLevel"
nettingEligible = "someNettingEligible"

foreignExchangeOptionDirection = "someForeignExchangeOptionDirection"


global maybe_effectiveMaturityBucket
global maybe_counterparty
global maybe_treasuryControl
global maybe_forwardStartAmountCurrency1
global maybe_forwardStartAmountCurrency2
global maybe_ForwardStartBucket

maybe_effectiveMaturityBucket = None
maybe_counterparty = None
maybe_treasuryControl = None
maybe_forwardStartAmountCurrency1 = None
maybe_forwardStartAmountCurrency2 = None
maybe_ForwardStartBucket = None

def rand_maybe_val():
    global maybe_effectiveMaturityBucket
    global maybe_counterparty
    global maybe_treasuryControl
    global maybe_forwardStartAmountCurrency1
    global maybe_forwardStartAmountCurrency2
    global maybe_ForwardStartBucket
    maybe_effectiveMaturityBucket = maturityBucketList[randrange(len(maturityBucketList))]
    maybe_counterparty = counterparty_value(randrange(1, 1+ len(counterparty_value))).name
    maybe_treasuryControl = treasuryControlValue(randrange(1, 1+ len(treasuryControlValue))).name
    maybe_forwardStartAmountCurrency1 = currency_Value(randrange(1, 1+len(currency_Value))).name
    maybe_forwardStartAmountCurrency2 = currency_Value(randrange(1, 1+len(currency_Value))).name
    maybe_ForwardStartBucket = maturityBucketList[randrange(len(maturityBucketList))]

def reset_maybe():
    global maybe_effectiveMaturityBucket
    global maybe_counterparty
    global maybe_treasuryControl
    global maybe_forwardStartAmountCurrency1
    global maybe_forwardStartAmountCurrency2
    global maybe_ForwardStartBucket

    maybe_effectiveMaturityBucket = None
    maybe_counterparty = None
    maybe_treasuryControl = None
    maybe_forwardStartAmountCurrency1 = None
    maybe_forwardStartAmountCurrency2 = None
    maybe_ForwardStartBucket = None

def rand_date():
    now_date = datetime.datetime.now()
    now_date = datetime.date.today()
    date1 = datetime.datetime.strptime(str(now_date), "%Y-%m-%d")
    end_date = date1.replace(minute=0, second=0, microsecond=0) + datetime.timedelta(days=randrange(1, 1825)) #1825 days
    str_end_date = str(end_date)
    return str_end_date.split(' ')[0]

def balancesheet_sample():
    asset_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for balancesheet_product in supplemental_balancesheet_product_value:
                for maturityBucket in maturityBucketList:
                    if maturityBucket[0] == 'Day':
                        count = 1
                        for i in range(1,61):
                            maturityBucket[1] = i
                            asset_object = {
                            'Currency' : currency.name, 
                            'Converted' : converted.name,
                            'ReportingEntity': reportingEntity_Value, 
                            'Product' : balancesheet_product.name,
                            'MaturityBucket' : maturityBucket,
                            'Internal' : internalValue,
                            'MaturityDate': rand_date()
                            }
                            asset_samples.append(asset_object)
                    else:
                        asset_object = {
                            'Currency' : currency.name, 
                            'Converted' : converted.name,
                            'ReportingEntity': reportingEntity_Value, 
                            'Product' : balancesheet_product.name,
                            'MaturityBucket' : maturityBucket,
                            'Internal' : internalValue,
                            'MaturityDate': rand_date()
                            } 
                        asset_samples.append(asset_object)
    return asset_samples

def maybe_balancesheet_sample():
    counter = 0
    asset_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for balancesheet_product in supplemental_balancesheet_product_value:
                for maturityBucket in maturityBucketList:
                    if maturityBucket[0] == 'Day':
                        for i in range(1,61):
                            counter += 1
                            maturityBucket[1] = i
                            if(counter % 10 == 0):
                                rand_maybe_val()

                            asset_object = {
                            'Currency' : currency.name, 
                            'Converted' : converted.name,
                            'ReportingEntity': reportingEntity_Value, 
                            'CollectionReference': collectionReference,
                            'Product' : balancesheet_product.name,
                            'ProductReference': productReference,
                            'SubProductReference': subProdructReference,
                            'CollateralClass': collateralClass,
                            'MaturityBucket' : maturityBucket,
                            'EffectiveMaturityBucket': maybe_effectiveMaturityBucket,
                            'EncumbranceType': encumbranceType,
                            'MarketValue': marketValue,
                            'MaturityAmount': maturityAmount,
                            'CollateralValue': collateralValue,
                            'Counterparty': maybe_counterparty,
                            'GSIB': gsib,
                            'RiskWeight': riskWeight,
                            'Internal' : internalValue,
                            'InternalCounterparty': internalCounterparty,
                            'MaturityDate': rand_date()
                            }
                            asset_samples.append(asset_object)
                            
                            if(counter % 10 == 0):
                                reset_maybe()
                    else:
                        counter += 1
                        if(counter % 10 == 0):
                            rand_maybe_val()
                        
                        asset_object = {
                            'Currency' : currency.name, 
                            'Converted' : converted.name,
                            'ReportingEntity': reportingEntity_Value, 
                            'CollectionReference': collectionReference,
                            'Product' : balancesheet_product.name,
                            'ProductReference': productReference,
                            'SubProductReference': subProdructReference,
                            'CollateralClass': collateralClass,
                            'MaturityBucket' : maturityBucket,
                            'EffectiveMaturityBucket': maybe_effectiveMaturityBucket,
                            'EncumbranceType': encumbranceType,
                            'MarketValue': marketValue,
                            'MaturityAmount': maturityAmount,
                            'CollateralValue': collateralValue,
                            'Counterparty': maybe_counterparty,
                            'GSIB': gsib,
                            'RiskWeight': riskWeight,
                            'Internal' : internalValue,
                            'InternalCounterparty': internalCounterparty,
                            'MaturityDate': rand_date()
                            }
                        asset_samples.append(asset_object)
                        if(counter % 10 == 0):
                            reset_maybe()
    return asset_samples

def derivativescollateral_sample():
    asset_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for derivativecollateral_product in supplemental_derivativescollateral_product_value:
                asset_object = {
                'Currency' : currency.name, 
                'Converted' : converted.name,
                'ReportingEntity': reportingEntity_Value, 
                'Product' : derivativecollateral_product.name,
                'MarketValue': marketValue,
                'Internal' : internalValue,
                'BusinessLine': businessLine
                }
                asset_samples.append(asset_object)
    return asset_samples

def maybe_derivativescollateral_sample():
    asset_samples = []
    counter = 0
    for currency in currency_Value:
        for converted in converted_Value:
            for derivativecollateral_product in supplemental_derivativescollateral_product_value:
                counter += 1
                if(counter % 10 == 0):
                    rand_maybe_val()
                asset_object = {
                'Currency' : currency.name, 
                'Converted' : converted.name,
                'ReportingEntity': reportingEntity_Value, 
                'Product' : derivativecollateral_product.name,
                'SubProduct1': subProduct1,
                'SubProduct2': subProduct2,
                'MarketValue': marketValue,
                'CollateralClass': collateralClass,
                'CollateralLevel': collateralLevel,
                'Counterparty': maybe_counterparty,
                'GSBI': gsib,
                'EffectiveMaturityBucket': maybe_effectiveMaturityBucket,
                'EncumbranceType': encumbranceType,
                'NettingEligible': nettingEligible,
                'TreasuryControl': maybe_treasuryControl,
                'Internal' : internalValue,
                'InternalCounterparty': internalCounterparty,
                'BusinessLine': businessLine,
                'MaturityDate': rand_date()
                }
                asset_samples.append(asset_object)
                if(counter % 10 == 0):
                    reset_maybe()
    return asset_samples

def foreignexchange_sample():
    asset_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for foreignexchange_product in supplemental_foreignexchange_product_value:
                for maturity_currency1 in currency_Value:
                    for maturity_currency2 in currency_Value:
                        for maturityBucket in maturityBucketList:
                            if maturityBucket[0] == 'Day':
                                for i in range(1,61):
                                    maturityBucket[1] = i
                                    for counterparty in counterparty_value:
                                        asset_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' : foreignexchange_product.name,
                                        'MaturityAmountCurrency1': maturity_currency1.name,
                                        'MaturityAmountCurrency2': maturity_currency2.name,
                                        'MaturityBucket' : maturityBucket,
                                        'Counterparty': counterparty.name,
                                        'Settlement': settlement,
                                        'BusinessLine': businessLine,
                                        'Internal' : internalValue
                                        }
                                        asset_samples.append(asset_object)
                            else:
                                for counterparty in counterparty_value:
                                    asset_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' : foreignexchange_product.name,
                                        'MaturityAmountCurrency1': maturity_currency1.name,
                                        'MaturityAmountCurrency2': maturity_currency2.name,
                                        'MaturityBucket' : maturityBucket,
                                        'Counterparty': counterparty.name,   
                                        'Settlement': settlement, 
                                        'BusinessLine': businessLine,
                                        'Internal' : internalValue
                                        } 
                                    asset_samples.append(asset_object)
    return asset_samples

def maybe_foreignexchange_sample():
    counter = 0
    asset_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for foreignexchange_product in supplemental_foreignexchange_product_value:
                for maturity_currency1 in currency_Value:
                    for maturity_currency2 in currency_Value:
                        for maturityBucket in maturityBucketList:
                            if maturityBucket[0] == 'Day':
                                for i in range(1,61):
                                    maturityBucket[1] = i
                                    for counterparty in counterparty_value:
                                        counter += 1
                                        if(counter % 10 == 0):
                                            rand_maybe_val()
                                        asset_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' : foreignexchange_product.name,
                                        'MaturityAmountCurrency1': maturity_currency1.name,
                                        'MaturityAmountCurrency2': maturity_currency2.name,
                                        'MaturityBucket' : maturityBucket,
                                        'ForeignExchangeOptionDirection': foreignExchangeOptionDirection,
                                        'ForwardStartAmountCurrency1': maybe_forwardStartAmountCurrency1,
                                        'ForwardStartAmountCurrency2': maybe_forwardStartAmountCurrency2,
                                        'ForwardStartBucket': maybe_ForwardStartBucket,
                                        'Counterparty': counterparty.name,
                                        'GSIB': gsib,
                                        'Settlement': settlement,
                                        'BusinessLine': businessLine,
                                        'Internal' : internalValue,
                                        'InternalCounterparty': internalCounterparty,
                                        'MaturityDate': rand_date()
                                        }
                                        asset_samples.append(asset_object)
                                        if(counter % 10 == 0):
                                            reset_maybe()
                            else:
                                for counterparty in counterparty_value:
                                    counter += 1
                                    if(counter % 10 == 0):
                                        rand_maybe_val()
                                    asset_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' : foreignexchange_product.name,
                                        'MaturityAmountCurrency1': maturity_currency1.name,
                                        'MaturityAmountCurrency2': maturity_currency2.name,
                                        'MaturityBucket' : maturityBucket,
                                        'ForeignExchangeOptionDirection': foreignExchangeOptionDirection,
                                        'ForwardStartAmountCurrency1': maybe_forwardStartAmountCurrency1,
                                        'ForwardStartAmountCurrency2': maybe_forwardStartAmountCurrency2,
                                        'ForwardStartBucket': maybe_ForwardStartBucket,
                                        'Counterparty': counterparty.name,
                                        'GSIB': gsib,
                                        'Settlement': settlement,
                                        'BusinessLine': businessLine,
                                        'Internal' : internalValue,
                                        'InternalCounterparty': internalCounterparty,
                                        'MaturityDate': rand_date()
                                        }
                                    asset_samples.append(asset_object)
                                    if(counter % 10 == 0):
                                        reset_maybe()
    return asset_samples

def informational_sample():
    asset_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for balancesheet_product in supplemental_balancesheet_product_value:
                asset_object = {
                'Currency' : currency.name, 
                'Converted' : converted.name,
                'ReportingEntity': reportingEntity_Value, 
                'Product' : balancesheet_product.name,
                'MarketValue': marketValue,
                'Internal' : internalValue,
                'BusinessLine': businessLine
                }
                asset_samples.append(asset_object)
    return asset_samples

def maybe_informational_sample():
    counter = 0
    asset_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for balancesheet_product in supplemental_balancesheet_product_value:
                counter += 1 
                if(counter % 10 == 0):
                    rand_maybe_val()
                asset_object = {
                'Currency' : currency.name, 
                'Converted' : converted.name,
                'ReportingEntity': reportingEntity_Value, 
                'Product' : balancesheet_product.name,
                'MarketValue': marketValue,
                'CollateralClass': collateralClass,
                'Internal' : internalValue,
                'InternalCounterparty': internalCounterparty,
                'BusinessLine': businessLine
                }
                asset_samples.append(asset_object)
                if(counter % 10 == 0):
                    reset_maybe()
    return asset_samples

def liquidityriskmeasurement_sample():
    asset_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for balancesheet_product in supplemental_balancesheet_product_value:
                asset_object = {
                'Currency' : currency.name, 
                'Converted' : converted.name,
                'ReportingEntity': reportingEntity_Value, 
                'Product' : balancesheet_product.name,
                'MarketValue': marketValue,
                'Internal' : internalValue
                }
                asset_samples.append(asset_object)
    return asset_samples

def maybe_liquidityriskmeasurement_sample():
    counter = 0
    asset_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for balancesheet_product in supplemental_balancesheet_product_value:
                counter += 1
                if(counter % 10 == 0):
                    rand_maybe_val()
                asset_object = {
                'Currency' : currency.name, 
                'Converted' : converted.name,
                'ReportingEntity': reportingEntity_Value, 
                'Product' : balancesheet_product.name,
                'MarketValue': marketValue,
                'CollateralClass': collateralClass,
                'Internal' : internalValue,
                'InternalCounterparty': internalCounterparty
                }
                asset_samples.append(asset_object)
                if(counter % 10 == 0):
                    reset_maybe()
    return asset_samples


if not os.path.exists("./supplemental_samples"):
    print("Creating supplemental_samples dir...")
    os.mkdir("supplemental_samples")

print("balancesheet_sample.json")
asset_samples = balancesheet_sample()
with open("supplemental_samples/balancesheet_sample.json", "w") as outfile:
    json.dump(asset_samples, outfile)

print("maybe_balancesheet_sample.json")
asset_samples = maybe_balancesheet_sample()
with open("supplemental_samples/maybe_balancesheet_sample.json", "w") as outfile:
    json.dump(asset_samples, outfile)

print("derivativescollateral_sample.json")
asset_samples = derivativescollateral_sample()
with open("supplemental_samples/derivativescollateral_sample.json", "w") as outfile:
    json.dump(asset_samples, outfile)

print("maybe_derivativescollateral_sample.json")
asset_samples = maybe_derivativescollateral_sample()
with open("supplemental_samples/maybe_derivativescollateral_sample.json", "w") as outfile:
    json.dump(asset_samples, outfile)

print("foreignexchange_sample.json")
asset_samples = foreignexchange_sample()
with open("supplemental_samples/foreignexchange_sample.json", "w") as outfile:
    json.dump(asset_samples, outfile)

print("maybe_foreignexchange_sample.json")
asset_samples = maybe_foreignexchange_sample()
with open("supplemental_samples/maybe_foreignexchange_sample.json", "w") as outfile:
    json.dump(asset_samples, outfile)

print("informational_sample.json")
asset_samples = informational_sample()
with open("supplemental_samples/informational_sample.json", "w") as outfile:
    json.dump(asset_samples, outfile)

print("maybe_informational_sample.json")
asset_samples = maybe_informational_sample()
with open("supplemental_samples/maybe_informational_sample.json", "w") as outfile:
    json.dump(asset_samples, outfile)

print("liquidityriskmeasurement_sample.json")
asset_samples = liquidityriskmeasurement_sample()
with open("supplemental_samples/liquidityriskmeasurement_sample.json", "w") as outfile:
    json.dump(asset_samples, outfile)

print("maybe_liquidityriskmeasurement_sample.json")
asset_samples = maybe_liquidityriskmeasurement_sample()
with open("supplemental_samples/maybe_liquidityriskmeasurement_sample.json", "w") as outfile:
    json.dump(asset_samples, outfile)