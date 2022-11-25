import regulation.us.lcr.inflows.applyrules.{SparkJobs => Jobs}
import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.types.{BooleanType, DoubleType, FloatType, IntegerType, StringType, StructType}
import org.scalatest.FunSuite
import org.scalatest.Matchers._

/**
 * type alias Assets =
 * { currency : Currency - Enum
 * , converted : Converted - Bool
 * , reportingEntity : ReportingEntity - String
 * , product : Product - Enum
 * , subProduct : Maybe SubProduct - ?String
 * , marketValue : MarketValue - Float
 * , lendableValue : LendableValue - String
 * , maturityBucket : MaturityBucket - Int
 * , forwardStartAmount : Maybe ForwardStartAmount - ?String
 * , forwardStartBucket : Maybe ForwardStartBucket - ?String
 * , collateralClass : CollateralClass - String
 * , treasuryControl : TreasuryControl - Bool
 * , accountingDesignation : AccountingDesignation - String
 * , effectiveMaturityBucket : Maybe EffectiveMaturityBucket - ?Int
 * , encumbranceType : Maybe EncumbranceType - ?String
 * , internalCounterparty : Maybe InternalCounterparty - ?String
 * , businessLine : BusinessLine - String
 * }
 */

class SparkJobs extends FunSuite {

  val localTestSession: SparkSession =
    SparkSession.builder().master("local").appName("LCRTest").getOrCreate()

  val asset_schema: StructType = new StructType()
    .add(name = "currency", StringType, nullable = false)
    .add("converted", BooleanType, nullable = false)
    .add("reportingEntity", StringType, nullable = false)
    .add("product", StringType, nullable = false)
    .add("subProduct", StringType, nullable = true)
    .add("marketValue", FloatType, nullable = false)
    .add("lendableValue", StringType, nullable = false)
    .add("maturityBucket", IntegerType, nullable = false)
    .add("forwardStartAmount", StringType, nullable = true)
    .add("forwardStartBucket", StringType, nullable = true)
    .add("collateralClass", StringType, nullable = false)
    .add("treasuryControl", BooleanType, nullable = false)
    .add("accountingDesignation", StringType, nullable = false)
    .add("effectiveMaturityBucket", IntegerType, nullable = true)
    .add("encumbranceType", StringType, nullable = true)
    .add("internalCounterparty", StringType, nullable = true)
    .add("businessLine", StringType, nullable = false)

  val assetsDF: DataFrame = localTestSession.read.format("csv")
    .option("header", "true")
    .schema(asset_schema)
    .load("./open_reg_tech_us_lcr/test/test_data/assets.csv")


  test("testRule1Section20A1C") {
    val df_expected_results = localTestSession.read.format("csv")
      .option("header", "true")
      .schema(new StructType().add("marketValue", FloatType, nullable = false))
      .load("./open_reg_tech_us_lcr/test/test_data/rule1Section20A1C_expected_results.csv")

    val df_actual_results = Jobs.rule1Section20A1C(assetsDF)

    df_actual_results.show()
    df_expected_results.show()
    assert(df_actual_results.columns.length == df_expected_results.columns.length)
    assert(df_actual_results.count == df_expected_results.count)
    df_actual_results.collectAsList() shouldEqual df_expected_results.collectAsList()
  }
}

