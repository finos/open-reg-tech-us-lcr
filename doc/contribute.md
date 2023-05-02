# Contributing

## Workspace Setup
The LCR project uses [the FINOS Morphir project](https://morphir.finos.org) so requires 
[Morphir installation](https://morphir.finos.org/docs/using/installation_and_usage). 

The quick summary is:
1. Create a fork of this project and clone it to your workspace. 
1. Be sure to [install **npm**](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
1. Install the Morphir command line tool with: `npm install morphir`
1. Compile the CLR with: `npx morphir-elm make -f`
2. Interact with: `npx morphir-elm develop -o localhost` (the [lcr function](http://localhost:3000/home/Morphir.SDK/US.LCR.Calculations/lcr?&moduleClicked=US.LCR.Calculations) is a good starting point).

## Code Organization
The code is organized in two sections:

### Data Definitions
The 2052a spec defines data types and the structure of the tables it requires to be supplied to run.
The project places those in the [FR2052A](src/Regulation/US/FR2052A) module.

* The business glossary (data types) are in the [Fields](src/Regulation/US/FR2052A/Fields) sub-module.
* The table structures and asset class specific field definitions are in the [DataTables]((src/Regulation/US/FR2052A/DataTables)) module,
which is further split into [Inflows](src/Regulation/US/FR2052A/DataTables/Inflows), [Outflows](src/Regulation/US/FR2052A/DataTables/OutFlows), and [Supplemental](src/Regulation/US/FR2052A/DataTables/Supplemental) modules.
### Rules and Calculations
The various rules and calculations are in the [LCR](src/Regulation/US/LCR) module.
[TODO: Add more detail about the sub-modules]


### Sample Scala runtime
There is a sample runtime to demonstrate calling the LCR as a library in Scala.
The code can be found at [SimpleApp](src/main/scala/SimpleApp.scala).

## What To Contribute
There are a few main opportunities for contribution:

### Updates to LCR Implementation
Parts of the LCR have been left unimplemented in order to experience collaborating on regulations in open-source. These
include:
* **Categorization Rules** - Verify the rules for the different types of cash flows defined in the [Inflows](src/Regulation/LCR/Inflows), 
[Outflows](src/Regulation/LCR/Outflows), and [Supplemental](src/Regulation/LCR/Supplemental) sub-modules of the
[LCR](src/Regulation/LCR) module.
* **Maturity Date** - The spec defines specific [rules for calculating the Maturity Bucket](https://www.federalreserve.gov/reportforms/forms/FR_2052a20220429_f.pdf&page=103).
The Data Tables assume that the tables come with Maturity Bucket so the calculation has to happen before.

### Testing
* **Unit Tests** - Many of the rules don't have unit tests. Unit tests would be useful for managing future changes and development. 
Tests can be created by using the Morphir Develop app or by generation based on the rule predicates.
* **Acceptance Tests** - We need a test harness with realistic data that produces an expected result.  That's challenging
to do in open-source. Options include donation of previously built tests, scrubbed data, or synthetic data generation. 

