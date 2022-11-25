// build.sc

import mill._, scalalib._

object open_reg_tech_us_lcr extends ScalaModule {
  def scalaVersion = "2.12.12"

  override def ivyDeps = Agg(
    ivy"org.apache.spark::spark-core:3.2.1",
    ivy"org.apache.spark::spark-sql:3.2.1"
  )

  object test extends Tests {
    override def ivyDeps = Agg(
      ivy"org.scalatest::scalatest:3.0.2"
    )

    override def testFramework = "org.scalatest.tools.Framework"
  }
}
