import regulation.us.fr2052a.DataTables
import regulation.us.fr2052a.datatables.inflows
import regulation.us.fr2052a.datatables.outflows
import regulation.us.lcr.Calculations

object SimpleApp {
  def main(args: Array[String]) {

    val data = Seq(
      ("UnrestrictedReserveBalances", "not Currency and Coin", 0, "a_0_Q", null, null, null, true, 1000000)
      , ("UnencumberedAssets", "not Currency and Coin", 1, "e_1_Q", null, null, null, true, 100000)
      , ("UnencumberedAssets", "not Currency and Coin", 2, "a_1_Q", null, null, null, true, 104000)
      , ("Capacity", "not Currency and Coin", 0, "a_4_Q", null, null, null, true, 2000000)
      , ("UnrestrictedReserveBalances", "Currency and Coin", 0, "a_5_Q", null, null, null, true, 200000)
    )

    val assets = inflows.Assets.Assets(regulation.us.fr2052a.fields.Currency.Currency.USD,
      true,
      "ReportingEntity",
      regulation.us.fr2052a.datatables.inflows.Assets.Product.UnrestrictedReserveBalances,
      Some(regulation.us.fr2052a.fields.SubProduct.currencyAndCoin + " not"),
      1000000,
      "one",
      regulation.us.fr2052a.fields.MaturityBucket.open,
      None,
      None,
      regulation.us.fr2052a.fields.CollateralClass.a0Q,
      true,
      "AccountingDesignation",
      None,
      None,
      None,
      "BusinessLine"
    )

    val dataTables = DataTables.DataTables(
      DataTables.Inflows(List(assets), Nil, Nil, Nil)
      , DataTables.Outflows(Nil, Nil, Nil, Nil)
      , DataTables.Supplemental(Nil, Nil, Nil, Nil, Nil)
    )


    println(regulation.us.lcr.inflows.Assets.rule1Section20A1(assets));
    println(regulation.us.lcr.inflows.Assets.rule1Section20A1C(assets));
    println(regulation.us.lcr.inflows.Assets.rule1Section20B1(assets));
    println(regulation.us.lcr.inflows.Assets.rule1Section20C1(assets));
    println(regulation.us.lcr.inflows.Assets.rule107Section33D1(assets));

    println (" ------------ ")
    val bankCategory = Calculations.GlobalSystemicallyImportantBHCOrGSIBDepositoryInstitution
    println(Calculations.hqlaAmount(dataTables));
    println(Calculations.totalNetCashOutflows(dataTables)(bankCategory));
    val lcr = Calculations.lcr(bankCategory)(dataTables)
    println("Liquidity Coverage Ratio: " + lcr)
    println (" ------------ ")

//    println("   ++++++++++++++++++ ")
//    val result = SparkJobs.toRuleBalances(df)
////    result.foreach(row => println(row.get(0) + " -> " + row.get(1)))
//    result.show()
//    println("   ++++++++++++++++++ ")
//
//    spark.stop()
  }
}