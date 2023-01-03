# Mapping the U.S. Liquidity Coverage Ratio to Morphir Code

This LCR implementation is based on the specifications round at the Fed's
[FR 2052a Instructions](https://www.federalreserve.gov/reportforms/forms/FR_2052a20220429_f.pdf).  

## Overview
Given the goal of providing the regulation as code, a core requirement is representing the business concepts defined in the specifiation as computer concepts. We do this by implementing the LCR using Morphir by way of the open-source [Elm](https://elm-lang.org) programming language. In order to be complete, it is important that every business concept is fully represented. This requires interpreting the specification to understand the best approach to implement each concept in Morphir. This document reviews that process and the decissions made.

## Business Glossary
The 2052a specification defines the business terms used in the regulation in the [Field Defitions](https://www.federalreserve.gov/reportforms/forms/FR_2052a20220429_f.pdf#page=17) section.  These field definitions provide both the business description and important data constraints.  So they are great for turning into Morphir type definitions.  Across the set of fields in the LCR, we see the following Morphir types:
* String - Text allowing any value.  Use for fields where the LCR specification provides no constraints, like names. 
* Enumeration - Text allowing only a finite set of allowable values. Use these where the specification provides a set of allowable values.
* Decimal (Float) - Decimal of unspecified precision. Use as 
* Boolean - True or False
* Integer - Non-decimal numbers.

Some fields have data constraints that limit what the allowable values are. The simplest of these are enumerations, 
like [Currency](../src/Regulation/US/FR2052A/Fields/Currency.elm), 
[Collateral Class](../src/Regulation/US/FR2052A/Fields/CollateralClass.elm), 
or [Counterparty](../src/Regulation/US/FR2052A/Fields/Counterparty.elm).


### Interesting cases.

* **Product** and **Sub-Product** - The spec instructs us to refer to the product definitions, meaning that each product 
  definition has its own set of allowable values, as found in [Appendix II-b](https://www.federalreserve.gov/reportforms/forms/FR_2052a20220429_f.pdf#page=89).
  In data management, this means each product defines its own *Product* and *Sub-Product* types as enumerations in their own modules (modules are sub-domains).  
  <br/>
  For example, we have the [Product definition for Assets](../src/Regulation/US/FR2052A/DataTables/Inflows/Assets.elm#line=69) 
  in the ```Regulation/US/FR2052A/DataTables/Inflows/Assets``` domain.
  We could define a top-level type that is a union of all of them, but the specification never uses it this way, so we don't.
  <br/><br/>

* **Maturity Bucket** - Is both a field and a base-type for other fields (Effective Maturity Bucket).  We handle this in Morphir
  by declaring the data type as a first-class type and the business use of that type as an ```alias``` of the base-type.
  That lets us define the data constraints in the base-type while signalling the business lingo in the alias. This is 
  convenient for generating data dictionaries and integrating with data lineage processes.
  <br/><br/>

## Data Sets
The specification defines the precise data inputs required for it to run via [13 Data Table definitions](https://www.federalreserve.gov/reportforms/forms/FR_2052a20220429_f.pdf#page=85).
We translate to [Morphir Record Types](https://package.elm-lang.org/packages/finos/morphir-elm/latest/Morphir-IR-Type),
which is the data structure for defining a collection of strongly-typed named fields.  The Data Tables are defined 
in terms of the Field Definitions, which means our Record Types are defined in terms of the type definitions that 
we defined.

We organized the 13 tables into their own modules (sub-domains) within their respective 
[Inflows](../src/Regulation/US/FR2052A/DataTables/Inflows), [Outflows](../src/Regulation/US/FR2052A/DataTables/Outflows),
and [Supplemental](../src/Regulation/US/FR2052A/DataTables/Supplemental) modules under [DataTables](../src/Regulation/US/FR2052A/DataTables/)
to align naturally with the specification.


## Other Calculations and rules
* **The LCR Calculation!** - The LCR basically operates in three layers:<br/><br/>
  * Categorize cashflows into groups
  * Aggregate the groups and apply a haircut to the result
  * Use the resulting haircuted values in various calculations that roll up to the final LCR ratio.<br/><br/>
  
  The actual calculation is defined in [Appendix VI](https://www.federalreserve.gov/reportforms/forms/FR_2052a20220429_f.pdf#page=108),
  which defines a composition of sub-calculations. [Our implementation](../src/Regulation/US/LCR/Calculations.elm) follows the specification precisely so that there 
  is a one-to-one match between the spec's calculations and corresponding Morphir functions.
  <br/><br/> 
  Notice that the specification doesn't dictate how to execute any of this. For example, should we categorize first then use the results across the calculations?
  Or should we categorize only when we need to for a specific calculation?  The specification stays clear of that, as it should.
  And so does our implementation.  One of the advantages of Morphir is that it defines what needs to be executed, but not how.
  That part is left to the interpretation.
  <br/><br/>

* **Categorization Rules** - The rules for categorizing various input cashflows into groups for aggregation and haircutting are defined in a somewhat
  confusing set of tables starting with [HQLA](https://www.federalreserve.gov/reportforms/forms/FR_2052a20220429_f.pdf#page=112)
  in a section of [Appendix VI](https://www.federalreserve.gov/reportforms/forms/FR_2052a20220429_f.pdf#page=108).  The
  specification here is a bit vague and actually uses a custom programming language / decision table.  This reflects
  the fact that sometimes English is not a precise language and that a programming language would be a better 
  tool for the job.  For example, our implementations of these rules are precise, organized, easy to read, and can be used to 
  generate documentation in various formats (including interactive).  We've collected the way that the tables are loosely
  related to the 13 Data Tables and organized them through the relevant modules.  For example, all rules that pertain
  to Inflow Assets can be found in the [LCR / Inflows / Assets](../src/Regulation/US/LCR/Inflows/Assets.elm) module.
  <br/><br/>

* **Maturity Bucket** - Another interesting point about Maturity Bucket is that it is relative to a particular date (T0).
  The specification tells us how to calculate Maturity Bucket by comparing the T0 date with the Maturity Date.  However,
  it also assumes that this calculation is done before passing the data to the LCR calculation. So the relevant Data Tables
  all take Maturity Bucket as fields rather than Maturity Date. While this saves us from having to deal with the complexity of
  date communication, it is all a bit confusing since there is a step that calculates differences in Maturity Buckets over 30 days. 
  There is much explaining on the topic, that probably would not have been necessary if they'd simply used straight date math.
  Anyway, we define all of this in functions in the Maturity Bucket module and even implement an alternative entry point
  that passes the 13 tables with Maturity Date and calculates the buckets as a convenience and data quality measure.
  <br/><br/>

## Interacting With The LCR
All of these can be seen in an [interactive LCR implementation](https://lcr-interactive.finos.org/). This is a useful
tool (via Morphir), for learning about the regulation without needing to understand code.  Starting with the 
[top-level LCR calculation](https://lcr-interactive.finos.org/home/Regulation/US.LCR.Calculations/lcr?&moduleClicked=US.LCR.Calculations)
and then drilling down into its components (by clicking the green areas) is a good place to start.
