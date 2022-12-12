[![FINOS - Incubating](https://cdn.jsdelivr.net/gh/finos/contrib-toolbox@master/images/badge-incubating.svg)](https://finosfoundation.atlassian.net/wiki/display/FINOS/Incubating)

<img align="right" width="40%" src="https://github.com/finos/finos-landscape/blob/master/hosted_logos/open-reg-tech-us-lcr.svg">

# FINOS Open Reg Tech - LCR

Welcome to the Open Reg Tech ipmlementation of the US Liquidity Coverage Ratio (LCR). The goal of the project is to establish the delivery and collaboration of regulations in code. 

# Local run
Local run uses Docker, please [follow instructions](https://docs.docker.com/get-docker/) to install it locally, then run the following commands:

```
docker build . -t morphir-lcr
docker run --name morphir-lcr-container -p 3000:3000 morphir-lcr:latest
docker rm morphir-lcr-container
```

## Compile to Scala over Spark

Morphir compilation has been abstracted away through maven (see [pom.xml](./pom.xml)) so that *.elm files can be 
directly generated to Scala and subsequently compiled as a jar file. 
The generated jar file can be easily pushed to CI/CD processes and be used in a spark based environment natively 
through the `--packages` or `--jars` options. 

```shell
mvn clean package
spark-shell --jars target/open-reg-tech-us-lcr-spark-1.0-SNAPSHOT.jar [../..]
```

Ideally, the same would be published to maven central, github package or enterprise repository (e.g. nexus) to be made
available across different environments. To deploy a new release to maven central, please refer to github 
workflow [release-spark.yaml](./.github/workflows/release-spark.yml)

## Update ECS cluster
- Access ECS Cluster on https://us-east-1.console.aws.amazon.com/ecs/home?region=us-east-1#/clusters and select the LCR cluster
- Access the `Task Definitions` menu item and select the `lcr-interactive` task
- Click on `Create new revision`
- Scroll down and click on `Add container`
  - container name: `lcr-morphir`
  - image: `finos/lcr-interactive:main` (replace `main` with the name of the code branch)
  - port mappings: `3000, tcp`
  - Keep other values as they are and complete the form to add the container
  - Remove the other container from the list
  - Keep other values as they are and complete the form to add a new task definition revision
- Select the LCR service and click on the Update button
  - Update the task definition revision
  - Keep other values as they are and complete the form to update the service
- Access the `Tasks` tab of the cluster service
- Keep only one Task running, remove all tasks with older task definitions

## Tentative Roadmap

1. Agree on the regulation (LCR)
2. Contribute existing LCR implementation into a new project in FINOS (done)
3. Implement the remainder of the LCR as a Open Reg Tech SIG team effort
4. Decide on an execution environment (i.e., Spark)
5. Enable procurement of the data with Legend
6. Demonstrate the complete solution.

## Contributing

1. Fork it (<https://github.com/finos/open-reg-tech-us-lcr/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Read our [contribution guidelines](.github/CONTRIBUTING.md) and [Community Code of Conduct](https://www.finos.org/code-of-conduct)
4. Commit your changes (`git commit -am 'Add some fooBar'`)
5. Push to the branch (`git push origin feature/fooBar`)
6. Create a new Pull Request

_NOTE:_ Commits and pull requests to FINOS repositories will only be accepted from those contributors with an active, executed Individual Contributor License Agreement (ICLA) with FINOS OR who are covered under an existing and active Corporate Contribution License Agreement (CCLA) executed with FINOS. Commits from individuals not covered under an ICLA or CCLA will be flagged and blocked by the FINOS Clabot tool (or [EasyCLA](https://community.finos.org/docs/governance/Software-Projects/easycla)). Please note that some CCLAs require individuals/employees to be explicitly named on the CCLA.

*Need an ICLA? Unsure if you are covered under an existing CCLA? Email [help@finos.org](mailto:help@finos.org)*
## License

Copyright 2022 Fintech Open Source Foundation

Distributed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

SPDX-License-Identifier: [Apache-2.0](https://spdx.org/licenses/Apache-2.0)
