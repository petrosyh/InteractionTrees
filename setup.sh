#!/usr/bin/env sh

cd lib/

# Set up paco
git clone https://github.com/snu-sf/paco.git
(cd paco/src; make)

# Set up ExtLib
git clone https://github.com/coq-ext-lib/coq-ext-lib.git
(cd coq-ext-lib; make)

cd ../ # at /

printf -- '-Q lib/paco/src Paco\n-Q lib/coq-ext-lib/theories/ ExtLib\n' > _CoqPath

make
