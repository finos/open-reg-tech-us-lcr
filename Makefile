ifeq ($(OS),Windows_NT)
    scalaCli := './scala-cli.bat'
else
    scalaCli := './scala-cli.sh'
endif

SCALA_SOURCES = $(wildcard src/**/*.scala) $(wildcard target/generated-sources/**/.scala)
ELM_SOURCES = $(wildcard src/Regulation/**/*.elm) elm.json morphir.json

install: package.json 
	npm install

morphir-ir.json: $(ELM_SOURCES)
	@echo "Generating Morphir IR..."
	@npx morphir-elm make -f

generated-sources: $(ELM_SOURCES) morphir-ir.json
	@echo "Generating Scala code..."
	@npx morphir-elm gen -t Scala -c -o ./src/main/generated-sources/main/scala --target-version 2.13 --include-codecs
	@echo 'SCALA GENERATED INTO generated-sources/scala/main'

compile: $(SCALA_SOURCES)
	@echo "Building..."
	@$(scalaCli) compile ./src ./target/generated-sources --scala 2.13

run: $(SCALA_SOURCES)
	@$(scalaCli) run ./src ./target/generated-sources --scala 2.13