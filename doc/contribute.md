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
[TODO: Add more detail]


### Sample Scala runtime
There is a sample runtime to demonstrate calling the LCR as a library in Scala.
The code can be found at [SimpleApp](src/main/scala/SimpleApp.scala).

## What To Contribute
### Updates to LCR Implementation

### Testing

