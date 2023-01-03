# Quick Start
The LCR uses Morphir as its base technology. This version uses Elm as the main programming language with Morphir's Elm support.
Morphir can be used to compile the project for execution and to generate interactive documentation.

If you are new to Morphir, start with the [Morphir installation instructions](https://finos.github.io/morphir-elm/).
Once Morphir is installed, you can use the following commands:

## Build the LCR
```
morphir-elm make -f
```

## Browse the interactive documentation
```
morphir-elm develop -- follow the instructions or open [http://localhost:3000](http://localhost:3000) in your browser.
```
You can also view [the interactive pages of the latest](https://lcr-interactive.finos.org).


### Interactive documentation with Docker
You can also run using Docker, please [follow instructions](https://docs.docker.com/get-docker/) to install it locally, then run the following commands:

```
docker build . -t morphir-lcr
docker run --name morphir-lcr-container -p 3000:3000 morphir-lcr:latest
docker rm morphir-lcr-container
```

