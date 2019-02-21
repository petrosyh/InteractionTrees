.PHONY: clean all coq test tests examples install uninstall depgraph \
  example-imp example-lc example-io example-nimp example-asm

COQPATHFILE=$(wildcard _CoqPath)

all: coq

coq: Makefile.coq
	$(MAKE) -f Makefile.coq

install: Makefile.coq all
	$(MAKE) -f $< $@

uninstall: Makefile.coq
	$(MAKE) -f $< $@

test: examples tests

tests:
	make -C tests

examples: example-imp example-lc example-io example-nimp example-threads

examples/%.vo: examples/%.v
	cd examples && \
	  coqc -Q ../theories/ ITree $*.v

example-imp: examples/Imp.vo

example-lc: examples/stlc.vo

example-lc: examples/stlc.vo

example-io: examples/IO.vo
	cd examples && \
	  ocamlbuild io.native && ./io.native

examples/Asm.vo: examples/sum.vo examples/Imp.vo
examples/Imp2Asm.vo: examples/Asm.vo
examples/Imp2AsmBis.vo: examples/sum.vo

example-asm: examples/Asm.vo

example-imp2asm: examples/Imp2Asm.vo

example-imp2asm2: examples/Imp2AsmBis.vo

THREADSV=examples/MultiThreadedPrinting.v examples/ExtractThreadsExample.v
THREADSML=examples/runthread.ml
example-threads: $(THREADSV) $(THREADSML)
	coqc -Q theories/ ITree -Q examples/ Examples $(THREADSV) && \
	cd examples && \
	ocamlbuild -I extracted runthread.native && \
	./runthread.native

Makefile.coq: _CoqProject
	coq_makefile -f $< -o $@

clean: Makefile.coq
	$(MAKE) -f Makefile.coq clean
	$(RM) {*,*/*}/*.{vo,glob} {*,*/*}/.*.aux
	$(RM) _CoqProject Makefile.coq*
	$(RM) examples/extracted/*.*
	cd examples && ocamlbuild -clean

_CoqProject: $(COQPATHFILE) _CoqConfig Makefile
	@ echo "# Generating _CoqProject"
	@ rm -f _CoqProject
	@ echo "# THIS IS AN AUTOMATICALLY GENERATED FILE" >> _CoqProject
	@ echo "# PLEASE EDIT _CoqConfig INSTEAD" >> _CoqProject
	@ echo >> _CoqProject
ifneq ("$(COQPATHFILE)","")
	@ echo "# including: _CoqPath"
	@ cat _CoqPath >> _CoqProject
	@ echo >> _CoqProject
endif
	@ echo "# including: _CoqConfig"
	@ cat _CoqConfig >> _CoqProject

COQDEP=coqdep
DEPS_DOT=deps.dot
DEPS_OUT=deps.jpg

depgraph:
	$(COQDEP) -dumpgraph $(DEPS_DOT) $(shell cat _CoqProject) > /dev/null 2>&1
	# sed 's%\("\([^"]*\)/\([^"/]*\)"\[label="\)%\1\2/\n%' -i deps.dot
	dot $(DEPS_DOT) -Tjpg -o$(DEPS_OUT)
