.PHONY: all build format edit demo clean

src?=0
dst?=5
graph?=graph6.txt

all: build

build:
	@echo "\n   🚨  COMPILING  🚨 \n"
	dune build src/ftest.exe
	ls src/*.exe > /dev/null && ln -fs src/*.exe .

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n   ⚡  EXECUTING  ⚡\n"
	./ftest.exe graphs/${graph} $(src) $(dst) outfile 
	@echo "\n   🥁  RESULT (content of outfile)  🥁\n"
	@cat outfile

demo2: build
	@echo "\n   ⚡  EXECUTING  ⚡\n"
	./ftest.exe graphs/${graph} $(src) $(dst) outfile 
	@echo "\n   🥁  RESULT (content of outfile)  🥁\n"
	@cat outfile > my_graph.dot
	dot -Tsvg my_graph.dot > my_graph.svg
	firefox my_graph.svg

clean:
	find -L . -name "*~" -delete
	rm -f *.exe
	dune clean
