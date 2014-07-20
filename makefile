.PHONY: compile run

compile:
	coffee -c index.coffee

run: compile
	node index.js
