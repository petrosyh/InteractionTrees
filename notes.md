# Interaction Trees

## Penn Versions

*  Internal to the DeepWeb development, mostly created by Li-yao.
   - https://github.com/DeepSpec/DeepWeb/blob/master/src/Free/Monad/Free.v 
   - does not use paco
   - supports typeclassses for "event combinators"
   - intended to be compatible with coq-ext-lib?

*  The Vellvm variants
   - https://github.com/vellvm/vellvm/blob/master/src/coq/Trace.v
   - some branches have ported it to use Paco
   - instantiates the monad typeclasses adapted from Iris.  See
     https://github.com/vellvm/vellvm/blob/master/src/coq/Classes.v

*  Newly created repo, intended to unify the two above:
   https://github.com/DeepSpec/InteractionTrees


## Gregory Malecha's variant
   - https://github.com/gmalecha/coq-interaction-trees
   - uses paco
   - more generic?


## MIT Version
   - created by Adam Chlipala and 
   - ?


## Yale Version
   - Vilhelm knows something about it...

# Discussions


# Challenges
- without paco, run into guardedness problems

- CoInductive proofs about interaction trees that use other lemmas. e.g. use
  transitivity of equivalence in some other lemma
  - e.g. interp distributes over bind: needs associativity / transitivity of
  equiv, but can't use it in Paco
  - potentially addressed by nat-indexing? (see Abishek's)
  - General question: connection of step indexing with coinduction
    (where to read more about this?)

# Paper Outline

# Introduction / Motivation

- basic definitions
   Q:   E : Type -> Type vs. action/reaction style

- McBride's treatment of effects:  _not_ E : Type -> Type, but rather S and
  S -> Type might be nicer for connecting to trace semantics

- bind / ret

- small example for exposition / comparison

# Effects : Kinds of Interactions
- examples
  * state
  * nondeterminism
   Q:   internal choice / fork   
  * failure
  * IO
  * Concurrency (??)
    Q: - Both constructor ?
     Interleaving
  * recursion 

- Effect handler composition / algebra 

# Reasoning Principles
- simulation / eutt
- laws etc.
- Paco

##  trace equivalence
Q: step-indexing ? / unwinding

- Gregory pointed out that the traces from the DeepWeb development can't
  express effects that "don't return" i.e.
    Exit : E Void


# Comparisons 

- FreeSpec
  * also a coq library
  * aimed at low-level hardware/state machines

- Yale "Game" semantics (?)

- Conventional inductive / trace based
  * extraction / executability ?
  Q: what is a good experiment we can do?

  * infinite behaviors (e.g. input a nat) work
    better with itrees (?)

# Extended Example / Application
to demonstrate programmability
& applications of reasoning techniques

- Imp + procedures + effects
  * compiler?

- Nondeterminism and Refinement

- or: Lambda calculus + effects
  * "standard" PL metatheory
  * program equivalence / contextual equivalences?

# Related Work
Freer Monads, More Extensible Effects
Oleg Kiselyov and Hiromi Ishii
http://okmij.org/ftp/Haskell/extensible/more.pdf

- point to comment on: performance of the underlying implementation using
  the "list" representation of continuations

Turing-Completeness Totally Free
Conor McBride
https://personal.cis.strath.ac.uk/conor.mcbride/TotallyFree.pdf

Interactive Programs in Dependent Type Theory
Peter Hancock and Anton Setzer
http://www.cs.swan.ac.uk/~csetzer/articles/ioconf.pdf

Adequacy for algebraic effects
Gordon Plotkin and John Power
https://www.era.lib.ed.ac.uk/bitstream/handle/1842/187/Op_Sem_Comp_Lam.pdf?sequence=1

A generic operational metatheory for algebraic effects
Patricia Johann, Alex Simpson and Janis Voigtländer
http://strathprints.strath.ac.uk/34343/1/genpar.pdf






