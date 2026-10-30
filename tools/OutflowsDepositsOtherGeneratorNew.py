from enum import Enum
import json
import datetime
import os
from random import randrange

currency_Value = Enum('currency', ["USD", "EUR", "GBP", "CHF","JPY", "AUD", "CAD"])
converted_Value = Enum('converted', ['True', 'False'] )
reportingEntity_Value = "ABC123"
Outflow_deposit_product_Value = Enum('Outflow_deposit_product', ['O.D.1', "O.D.2", "O.D.3", "O.D.5","O.D.6", "O.D.11", "O.D.12", "O.D.15"])
Outflow_other_product_Value = Enum('Outflow_other_product', ['O.O.1', "O.O.2", "O.O.9", "O.O.10", "O.O.11", "O.O.12", "O.O.18", "O.O.19", "O.O.22"])
Outflow_secured_product_Value = Enum('Outflow_secured_product', ['O.S.1', "O.S.2", "O.S.8", "O.S.9", "O.S.10", "O.S.11"])
Outflow_wholesale_product_Value = Enum('Outflow_wholesale_product', ['O.W.1', "O.W.2", "O.W.3", "O.W.12", "O.W.18", "O.W.19"])
counterparty_Value = Enum('counterdparty', ['Retail', 'Small_Business', 'Non_Financial_Corporate', 'Sovereign', 'Central_Bank', 'Government_Sponsored_Entity', 'Public_Sector_Entity', 'Multilateral_Development_Bank', 'Other_Supranational', 'Pension_Fund', 'Bank', 'Broker_Dealer', 'Investment_Company_or_Advisor', 'Financial_Market_Utility', 'Other_Supervised_Non_Bank_Financial_Entity', 'Debt_Issuing_Special_Purpose_Entity', 'Non_Regulated_Fund', 'Other'])
gSIB = None
maturityAmount = 1821323.34
maturityBucketList = [["Open"], ["Day", 0], ["Days", 61, 67], ["Days", 68, 74] , ["Days", 75, 82] , ["Days", 83, 90], ["Days", 91, 120], ["Days", 121, 150], ["Days", 151, 179], ["Days", 180, 270], ["Days", 271, 364] ,["Perpetual"] ]
#maturityBucketValue = Enum('maturityBucket', ["Open", "Day", "61to67Days", "68to74Days" , "75to82Days" , "83to90Days", "91to120Days", "121to150Days", "151to179Days", "180to270Days" , "271to364Days" ,"Perpetual" ])
maturityOptionality = None
collateralClassValue = None
collateralValue = None
forwardStartAmount = None
forwardStartBucket = None
insuredValue = Enum('insured', ['FDIC', 'Other', 'Uninsured'])
trigger = 'LCY383'
rehypothecated = None
businessLine = "KFC83"
internal = "XFZYW123"
internalCounterparty = None

def rand_date():
    now_date = datetime.datetime.now()
    now_date = datetime.date.today()
    date1 = datetime.datetime.strptime(str(now_date), "%Y-%m-%d")
    end_date = date1.replace(minute=0, second=0, microsecond=0) + datetime.timedelta(days=randrange(1, 1825)) #1825 days
    str_end_date = str(end_date)
    return str_end_date.split(' ')[0]

def outflow_Deposits_Sample():
    deposit_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for Outflow_deposit_product in Outflow_deposit_product_Value:
                for counterparty in counterparty_Value:
                    for insured in insuredValue:
                        for maturityBucket in maturityBucketList:                        
                            if maturityBucket[0] == 'Day':
                                count = 1
                                for i in range(1,61):
                                    maturityBucket[1] = i
                                    count = count + 1
                                    deposit_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' : Outflow_deposit_product.name,
                                        'Counterparty' : counterparty.name,
                                        'gSIB' : gSIB, 
                                        'MaturityAmount': maturityAmount,
                                        'MaturityBucket' : maturityBucket,
                                        'MaturityDate': rand_date(),
                                        'MaturityOptionality': maturityOptionality,
                                        'CollateralClassValue' : collateralClassValue,
                                        'CollateralValue': collateralValue,
                                        'Trigger': trigger,
                                        'Rehypothecated' : rehypothecated,
                                        'BusinessLine' : businessLine,
                                        'Internal' : internal,
                                        'InternalCounterparty' : internalCounterparty
                                    }
                                    deposit_samples.append(deposit_object)
                            else:
                                deposit_object = {
                                    'Currency' : currency.name, 
                                    'Converted' : converted.name,
                                    'ReportingEntity': reportingEntity_Value, 
                                    'Product' : Outflow_deposit_product.name,
                                    'Counterparty' : counterparty.name,
                                    'gSIB' : gSIB, 
                                    'MaturityAmount': maturityAmount,
                                    'MaturityBucket' : maturityBucket,
                                    'MaturityDate': rand_date(),
                                    'MaturityOptionality': maturityOptionality,
                                    'CollateralClassValue' : collateralClassValue,
                                    'CollateralValue' : collateralValue,
                                    'Trigger' : trigger,
                                    'Rehypothecated' : rehypothecated,
                                    'BusinessLine' : businessLine,
                                    'Internal' : internal,
                                    'InternalCounterparty' : internalCounterparty
                                    }
                                deposit_samples.append(deposit_object)
    return deposit_samples


def outflow_Other_Sample():
    other_samples = []
    for currency in currency_Value:
        for converted in converted_Value:
            for Outflow_other_product in Outflow_other_product_Value:
                for counterparty in counterparty_Value:
                        for maturityBucket in maturityBucketList:                        
                            if maturityBucket[0] == 'Day':
                                count = 1
                                for i in range(1,61):
                                    maturityBucket[1] = i
                                    count = count + 1
                                    other_object = {
                                        'Currency' : currency.name, 
                                        'Converted' : converted.name,
                                        'ReportingEntity': reportingEntity_Value, 
                                        'Product' : Outflow_other_product.name,
                                        'Counterparty' : counterparty.name,
                                        'gSIB' : gSIB, 
                                        'MaturityAmount': maturityAmount,
                                        'MaturityBucket' : maturityBucket,
                                        'MaturityDate': rand_date(),
                                        'ForwardStartAmount' : forwardStartAmount,
                                        'ForwardStartBucket' : forwardStartBucket,
                                        'CollateralClassValue' : collateralClassValue,
                                        'CollateralValue': collateralValue,                                        
                                        'Internal' : internal,
                                        'InternalCounterparty' : internalCounterparty,
                                        'BusinessLine' : businessLine
                                    }
                                    other_samples.append(other_object)
                            else:
                                other_object = {
                                    'Currency' : currency.name, 
                                    'Converted' : converted.name,
                                    'ReportingEntity': reportingEntity_Value, 
                                    'Product' : Outflow_other_product.name,
                                    'Counterparty' : counterparty.name,
                                    'gSIB' : gSIB, 
                                    'MaturityAmount': maturityAmount,
                                    'MaturityBucket' : maturityBucket,
                                    'ForwardStartAmount' : forwardStartAmount,
                                    'ForwardStartBucket' : forwardStartBucket,
                                    'MaturityDate': rand_date(),
                                    'CollateralClassValue' : collateralClassValue,
                                    'CollateralValue': collateralValue,                                        
                                    'Internal' : internal,
                                    'InternalCounterparty' : internalCounterparty,
                                    'BusinessLine' : businessLine
                                    }
                                other_samples.append(other_object)
    return other_samples

if not os.path.exists("./outflows_samples"):
    print("Creating outflows_samples dir...")
    os.mkdir("outflows_samples")

deposit_samples = outflow_Deposits_Sample()
with open("outflows_samples/OutflowsDepositsSample.json", "w") as outfile:
    json.dump(deposit_samples, outfile)
    
other_samples = outflow_Other_Sample()
with open("outflows_samples/OutflowsOtherSample.json", "w") as outfile:
    json.dump(other_samples, outfile)

# print("Product :")

# for deposit in (deposit_samples):
#     print (deposit)