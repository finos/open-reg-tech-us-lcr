ifeq ($(OS),Windows_NT)
    scalaCli := './scala-cli.bat'
else
    scalaCli := './scala-cli.sh'
endif

SCALA_SOURCES = $(wildcard src/**/*.scala) $(wildcard target/generated-sources/**/.scala)

compile: $(SCALA_SOURCES)
	@echo "Building..."
	@$(scalaCli) compile ./src ./target/generated-sources --scala 2.13

run: $(SCALA_SOURCES)
	@$(scalaCli) run ./src ./target/generated-sources --scala 2.13