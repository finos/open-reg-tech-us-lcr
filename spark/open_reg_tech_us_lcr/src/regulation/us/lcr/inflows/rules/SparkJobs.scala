package regulation.us.lcr.inflows.rules

object SparkJobs{

  def rule1Section20A1(
    assets: org.apache.spark.sql.DataFrame
  ): org.apache.spark.sql.DataFrame =
    assets.filter((org.apache.spark.sql.functions.col("product").isin(
      "UnencumberedAssets",
      "Capacity"
    )) and ((org.apache.spark.sql.functions.when(
      org.apache.spark.sql.functions.not(org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("subProduct"))),
      org.apache.spark.sql.functions.not((org.apache.spark.sql.functions.col("subProduct")) === ("Currency and Coin"))
    ).otherwise(true)) and (((org.apache.spark.sql.functions.col("collateralClass").isin(
      "a_0_Q",
      "a_1_Q",
      "a_2_Q",
      "a_3_Q",
      "a_4_Q",
      "a_5_Q",
      "s_1_Q",
      "s_2_Q",
      "s_3_Q",
      "s_4_Q",
      "cB_1_Q",
      "cB_2_Q"
    )) and (org.apache.spark.sql.functions.not((org.apache.spark.sql.functions.col("collateralClass")) === ("a_0_Q")))) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("forwardStartAmount"))) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("forwardStartBucket"))) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("encumbranceType"))) and ((org.apache.spark.sql.functions.col("treasuryControl")) === (true)))))))).select(org.apache.spark.sql.functions.sum(org.apache.spark.sql.functions.col("marketValue")).alias("marketValue"))
  
  def rule1Section20A1C(
    assets: org.apache.spark.sql.DataFrame
  ): org.apache.spark.sql.DataFrame =
    assets.filter((org.apache.spark.sql.functions.col("product").isin("UnrestrictedReserveBalances")) and ((org.apache.spark.sql.functions.when(
      org.apache.spark.sql.functions.not(org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("subProduct"))),
      org.apache.spark.sql.functions.not((org.apache.spark.sql.functions.col("subProduct")) === ("Currency and Coin"))
    ).otherwise(true)) and (((org.apache.spark.sql.functions.col("maturityBucket")) === (0)) and (((org.apache.spark.sql.functions.col("collateralClass")) === ("a_0_Q")) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("forwardStartAmount"))) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("forwardStartBucket"))) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("encumbranceType"))) and ((org.apache.spark.sql.functions.col("treasuryControl")) === (true))))))))).select(org.apache.spark.sql.functions.sum(org.apache.spark.sql.functions.col("marketValue")).alias("marketValue"))
  
  def rule1Section20B1(
    assets: org.apache.spark.sql.DataFrame
  ): org.apache.spark.sql.DataFrame =
    assets.filter((org.apache.spark.sql.functions.col("product").isin(
      "UnencumberedAssets",
      "Capacity"
    )) and ((org.apache.spark.sql.functions.when(
      org.apache.spark.sql.functions.not(org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("subProduct"))),
      org.apache.spark.sql.functions.not((org.apache.spark.sql.functions.col("subProduct")) === ("Currency and Coin"))
    ).otherwise(true)) and ((org.apache.spark.sql.functions.col("collateralClass").isin(
      "g_1_Q",
      "g_2_Q",
      "g_3_Q",
      "s_5_Q",
      "s_6_Q",
      "s_7_Q",
      "cB_3_Q"
    )) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("forwardStartAmount"))) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("forwardStartBucket"))) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("encumbranceType"))) and ((org.apache.spark.sql.functions.col("treasuryControl")) === (true)))))))).select(org.apache.spark.sql.functions.sum(org.apache.spark.sql.functions.col("marketValue")).alias("marketValue"))
  
  def rule1Section20C1(
    assets: org.apache.spark.sql.DataFrame
  ): org.apache.spark.sql.DataFrame =
    assets.filter((org.apache.spark.sql.functions.col("product").isin(
      "UnencumberedAssets",
      "Capacity"
    )) and ((org.apache.spark.sql.functions.when(
      org.apache.spark.sql.functions.not(org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("subProduct"))),
      org.apache.spark.sql.functions.not((org.apache.spark.sql.functions.col("subProduct")) === ("Currency and Coin"))
    ).otherwise(true)) and ((org.apache.spark.sql.functions.col("collateralClass").isin(
      "e_1_Q",
      "e_2_Q",
      "iG_1_Q",
      "iG_2_Q"
    )) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("forwardStartAmount"))) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("forwardStartBucket"))) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("encumbranceType"))) and ((org.apache.spark.sql.functions.col("treasuryControl")) === (true)))))))).select(org.apache.spark.sql.functions.sum(org.apache.spark.sql.functions.col("marketValue")).alias("marketValue"))
  
  def rule107Section33D1(
    assets: org.apache.spark.sql.DataFrame
  ): org.apache.spark.sql.DataFrame =
    assets.filter((org.apache.spark.sql.functions.col("product").isin("UnrestrictedReserveBalances")) and (((((org.apache.spark.sql.functions.col("maturityBucket")) > (0)) and ((org.apache.spark.sql.functions.col("maturityBucket")) <= (30))) and (org.apache.spark.sql.functions.not((org.apache.spark.sql.functions.col("maturityBucket")) === (0)))) and (((org.apache.spark.sql.functions.col("collateralClass")) === ("a_0_Q")) and ((org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("forwardStartAmount"))) and (org.apache.spark.sql.functions.isnull(org.apache.spark.sql.functions.col("forwardStartBucket"))))))).select(org.apache.spark.sql.functions.sum(org.apache.spark.sql.functions.col("marketValue")).alias("marketValue"))

}