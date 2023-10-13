package sample


import regulation.us.fr2052a.DataTables
import regulation.us.fr2052a.datatables.inflows
import regulation.us.fr2052a.datatables.inflows.Assets
import regulation.us.fr2052a.datatables.outflows
import regulation.us.fr2052a.fields.CollateralClass.CollateralClass
import regulation.us.fr2052a.fields.CollateralValue.CollateralValue
import regulation.us.fr2052a.fields.Converted.Converted
import regulation.us.fr2052a.fields.Counterparty.Counterparty
import regulation.us.fr2052a.fields.Currency.Currency
import regulation.us.fr2052a.fields.EffectiveMaturityBucket.EffectiveMaturityBucket
import regulation.us.fr2052a.fields.ForwardStartAmount.ForwardStartAmount
import regulation.us.fr2052a.fields.ForwardStartBucket.ForwardStartBucket
import regulation.us.fr2052a.fields.MaturityAmount.MaturityAmount
import regulation.us.fr2052a.fields.MaturityBucket.MaturityBucket
import regulation.us.fr2052a.fields.TreasuryControl.TreasuryControl
import regulation.us.fr2052a.fields.Unencumbered.Unencumbered
import regulation.us.fr2052a.fields.{CollateralClass, SubProduct}
import regulation.us.lcr.Calculations

import io.circe._, io.circe.generic.auto._, io.circe.parser._, io.circe.syntax._

object SimpleApp {
  def main(args: Array[String]) {
    val t0 = 0

    val data = Seq(
      ("UnrestrictedReserveBalances", "not Currency and Coin", 0, "a_0_Q", null, null, null, true, 1000000)
      , ("UnencumberedAssets", "not Currency and Coin", 1, "e_1_Q", null, null, null, true, 100000)
      , ("UnencumberedAssets", "not Currency and Coin", 2, "a_1_Q", null, null, null, true, 104000)
      , ("Capacity", "not Currency and Coin", 0, "a_4_Q", null, null, null, true, 2000000)
      , ("UnrestrictedReserveBalances", "Currency and Coin", 0, "a_5_Q", null, null, null, true, 200000)
    )

    val assets = List(
      toAssets(Currency.USD, true, inflows.Assets.Product.UnrestrictedReserveBalances, Some(SubProduct.level1), 1, MaturityBucket.Open, CollateralClass.a0Q)
      , toAssets(Currency.USD, true, inflows.Assets.Product.Capacity, Some(SubProduct.level2A), 10, MaturityBucket.Open, CollateralClass.e1Q)
    )

    val othersIn = List(
      toOtherIn(Currency.USD, true, inflows.Other.Product.Net30DayDerivativeReceivables, 100, MaturityBucket.Open, CollateralClass.a1Q, 100)
    )

    val wholesale = List(
      toWholesale(outflows.Wholesale.Product.AssetBackedCommercialPaperSingleSeller, 2, MaturityBucket.Open, Some(CollateralClass.a0Q), None, None)
      , toWholesale(outflows.Wholesale.FreeCredits, 20, MaturityBucket.Day(10), None, None, None)
    )

    val inSecured = List(
      toSecuredIn(inflows.Secured.Product.ReverseRepo, None, None, None, CollateralClass.a1Q, 4000, true, true)
    )

    val dataTables = DataTables.DataTables(
      DataTables.Inflows(assets, Nil, inSecured, othersIn)
      , DataTables.Outflows(Nil, wholesale, Nil, Nil)
      , DataTables.Supplemental(Nil, Nil, Nil, Nil, Nil)
    )


//    println(regulation.us.lcr.inflows.Assets.rule1Section20A1(assets(0)));
//    println(regulation.us.lcr.inflows.Assets.rule1Section20A1C(assets(0)));
//    println(regulation.us.lcr.inflows.Assets.rule1Section20B1(assets(0)));
//    println(regulation.us.lcr.inflows.Assets.rule1Section20C1(assets(1)));
//    println(regulation.us.lcr.inflows.Assets.rule107Section33D1(assets(0)));
//    println(" ------------ ")
//    println(regulation.us.lcr.inflows.Assets.applyRules(dataTables.inflows.assets));
//    println(regulation.us.lcr.inflows.Assets.toRuleBalances(dataTables.inflows.assets));
    println(" ------------ ")
    println("Other.toRuleBalances " + regulation.us.lcr.inflows.Other.toRuleBalances(t0)(dataTables.inflows.other))
    println("Secured.toRuleBalances " + regulation.us.lcr.inflows.Secured.toRuleBalances(t0)(dataTables.inflows.secured))
    println("Wholesale.toRuleBalances " + regulation.us.lcr.outflows.Wholesale.toRuleBalances(t0)(dataTables.outflows.wholesale))

    println(" ------------ ")
    println("AggregatedRuleBalances.inflowValues " + regulation.us.lcr.AggregatedRuleBalances.inflowValues(t0)(dataTables.inflows))
    println("AggregatedRuleBalances.outflowValues " + regulation.us.lcr.AggregatedRuleBalances.outflowValues(t0)(dataTables.outflows))

//    println(" ------------ ")
//    println("AggregatedRuleBalances.applyInflowRules " + regulation.us.lcr.AggregatedRuleBalances.inflowValues(t0)(dataTables.inflows))
//    println("AggregatedRuleBalances.applyOutflowRules " + regulation.us.lcr.AggregatedRuleBalances.outflowValues(t0)(dataTables.outflows))

    println(" ------------ ")
    val bankCategory = Calculations.GlobalSystemicallyImportantBHCOrGSIBDepositoryInstitution
    println("HQLA Amount: " + Calculations.hqlaAmount(dataTables))
    println("Total Net Cash Outflows: " + Calculations.totalNetCashOutflows(dataTables)(bankCategory))
    println("Liquidity Coverage Ratio: " + Calculations.lcr(bankCategory)(dataTables))
    println(" ------------ ")

    //    println("   ++++++++++++++++++ ")
    //    val result = SparkJobs.toRuleBalances(df)
    ////    result.foreach(row => println(row.get(0) + " -> " + row.get(1)))
    //    result.show()
    //    println("   ++++++++++++++++++ ")
    //
    //    spark.stop()
  }

  def toAssets(
                currency: regulation.us.fr2052a.fields.Currency.Currency,
                converted: regulation.us.fr2052a.fields.Converted.Converted,
                product: inflows.Assets.Product,
                subProduct: morphir.sdk.Maybe.Maybe[regulation.us.fr2052a.fields.SubProduct.SubProduct],
                marketValue: regulation.us.fr2052a.fields.MarketValue.MarketValue,
                maturityBucket: regulation.us.fr2052a.fields.MaturityBucket.MaturityBucket,
                collateralClass: regulation.us.fr2052a.fields.CollateralClass.CollateralClass
              ): Assets.Assets =
    inflows.Assets.Assets(currency, converted,
      "ReportingEntity",
      product,
      subProduct,
      marketValue,
      "one",
      maturityBucket,
      None,
      None,
      collateralClass,
      true,
      "AccountingDesignation",
      None,
      None,
      None,
      "BusinessLine"
    )

  def toOtherIn(
                 currency: Currency
                 , converted: Converted
                 , product: inflows.Other.Product
                 , maturityAmount: MaturityAmount
                 , maturityBucket: MaturityBucket
                 , collateralClass: CollateralClass
                 , collateralValue: CollateralValue) =
    inflows.Other.Other(
      currency
      , converted
      , "ReportingEntity"
      , product
      , maturityAmount
      , maturityBucket
      , None
      , None
      , Some(collateralClass)
      , Some(collateralValue)
      , true
      , None
      , None
      , "Internal"
      , None
      , "BusinessLine"
    )

  def toWholesale(
                   product: regulation.us.fr2052a.datatables.outflows.Wholesale.Product,
                   maturityAmount: regulation.us.fr2052a.fields.MaturityAmount.MaturityAmount,
                   maturityBucket: regulation.us.fr2052a.fields.MaturityBucket.MaturityBucket,
                   collateralClass: morphir.sdk.Maybe.Maybe[regulation.us.fr2052a.fields.CollateralClass.CollateralClass],
                   forwardStartAmount: morphir.sdk.Maybe.Maybe[regulation.us.fr2052a.fields.ForwardStartAmount.ForwardStartAmount],
                   forwardStartBucket: morphir.sdk.Maybe.Maybe[regulation.us.fr2052a.fields.ForwardStartBucket.ForwardStartBucket]
                 ) =
    outflows.Wholesale.Wholesale(
      Currency.USD,
      true,
      "ReportingEntity",
      product,
      None,
      None,
      maturityAmount: regulation.us.fr2052a.fields.MaturityAmount.MaturityAmount,
      maturityBucket: regulation.us.fr2052a.fields.MaturityBucket.MaturityBucket,
      None,
      collateralClass,
      None,
      forwardStartAmount,
      forwardStartBucket,
      "Internal",
      None,
      None,
      "BusinessLine"
    )

  def toSecuredIn(
                   product : inflows.Secured.Product
                   , effectiveMaturityBucket : Option [EffectiveMaturityBucket]
                   , forwardStartAmount : Option [ForwardStartAmount]
                   , forwardStartBucket : Option [ForwardStartBucket]
                   , collateralClass : CollateralClass
                   , collateralValue : CollateralValue
                   , unencumbered : Unencumbered
                   , treasuryControl : TreasuryControl
                 ) =
    inflows.Secured.Secured(
      Currency.USD
      , true
      , "ReportingEntity"
      , product
      , None
      , 100
      , MaturityBucket.Open
      , None
      , effectiveMaturityBucket
      , None
      , forwardStartAmount
      , forwardStartBucket
      , collateralClass
      , collateralValue
      , unencumbered
      , treasuryControl
      , "Internal"
      , None
      , None
      , "BusinessLine"
      , "Settlement"
      , Counterparty.CentralBank
      , None
    )
}
