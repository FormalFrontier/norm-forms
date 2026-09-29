# Norm Forms

`NormForms` is a source-independent Lean library for universal coordinate norms
under commutative base change, coordinate norm forms of field extensions,
unbounded attained-degree anisotropic homogeneous forms, finite polynomial
zero-set compression over non-algebraically-closed fields, and nontrivial
common zeros of equal-degree homogeneous systems under a direct
all-positive-degree single-form bound. The same bound also yields nontrivial
zeros of homogeneous forms over arbitrary algebraic field extensions and,
with one extra degree factor in the strict arity bound, over rational-function
fields; a finite-transcendence-degree extension receives the corresponding
degree-shifted bound. It depends directly on mathlib and
exact official `multivariate-polynomials`, `algebraic-groups` and
`sequence-growth` releases.

At preparation on 2026-09-29, the finite-transcendence contribution adds
`NormForms.FiniteTranscendenceFormZeros`, its ordinary client and the
[eighth mathematical guide](docs/FiniteTranscendenceFormZeros.md), bringing
the library to **twenty-two Lean modules**. The preceding twenty-module
`NormForms` main `67a2402fd60456f510bea901a59a724865a93538` is accepted,
and its same-tree official release `62260e19ae5f3e4bc1742bb8156b3023f59161fe`
is reviewed and privately published. This new transfer is **unreviewed,
unaccepted and unreleased**; the preceding checks and review do not certify
the changed destination graph.

## Historical preparation boundary — 2026-09-29

All following predecessor preparation and lifecycle text retains its dated
meaning, including then-pending labels for the rational-function candidate.
Those labels predate the accepted and published twenty-module predecessor;
they do not describe this new twenty-two-module candidate.

At its preparation on 2026-09-29, before destination review and acceptance,
this twenty-module rational-function transfer was a candidate, not yet
independently reviewed, accepted or published. The preceding eighteen-module
library is already accepted at ordinary main
`ba4a2c3a7e71afe516ef4b91d6f373c1a0846e1c` and separately published at
official `3e492c4684694e80bceacb43bf930fef5157048b` with the same tree.
See the [rational-function theorem guide](docs/RatFuncFormZeros.md) and its
[ordinary-import examples](NormFormsTests/RatFuncFormZeros.lean).

## Historical predecessor lifecycle (through 2026-09-29)

The following complete predecessor account retains its original stage-scoped
pending labels and receipts. They describe their dated inputs, not the present
rational-function transfer or the eventual acceptance of this candidate. In
particular, native run 823 used an earlier `multivariate-polynomials` pin; the
accepted eighteen-module predecessor has its own run 1097, separate review and
official publication.

The preceding sixteen-module library is published at official
`22413e8f4fa8409ba06b6242a67adbbc76733a02` (same tree as destination
parent `eddc91b7e71fdb0e8fb26b4441b445b389d6db7b`); the historical
paragraphs below describe earlier stage-specific handoffs, not this separate
algebraic-extension contribution's acceptance or publication. At its
construction on 2026-09-29, the changed eighteen-module destination graph
still required its own checks and independent review.

An earlier mathematical input was accepted for ordinary development on
2026-09-25 at
`a87e5d0691a76d2118fbe8de864a5d02a38596bc` (tree
`a9e3d910f11de2ba3412e20fc758e66d2249f510`). The lint repair analyzed by
the native reference comes from subsequent code commit
`54accffeba182bea1f6969c2f6d67a96a43dc6f7`, which was unaccepted when
the native runs were recorded on 2026-09-26. Neither the earlier acceptance
nor the Lake package version `0.1.0` designates a release. Exact-artifact review
and publication records identify any subsequently accepted release; the repair
and documentation do not inherit the historical mathematical review.
The earlier official public release `119fc4967e1ccd2415a3a5fffa3cd712f275635e`
predates the existence-theorem transfer. On 2026-09-28, Beacon accepted the
exact destination contribution `313612a372a8c55a4e2af2bd0461d302998b6217`
(PR #13, acceptance 58741), and its protected `main` integration was verified
(58744). The later official publication of the previous library at
`db29d765e132d995bfed69f4424cf6a0261e95ac` and its separate no-target
disposition are **complete**; that published commit has the same tree as frozen
destination parent `d81d250bdef45315552d1c1027391296aa53f192`.
Beacon accepted the universal-coordinate contribution at
`7a0fe210795b6b1ba26a0bdf272e69c156b123c0` (PR #17, acceptance 59647)
on 2026-09-28, and verified its protected `main` integration (incubator issue
#170, record 59660). This is code/API acceptance, not approval or publication
of a later release artifact; the previous release does not approve changed
inputs. Beacon is responsible for this unit, with shared source-maintainer
stewardship. Exact-artifact release records determine its later publication.
The universal-coordinate library at destination parent
`75a4f9d5f67bc65b5d319cec30c92d785e8debef` (tree
`c099e4295f9944acb38166f6139d4d687224f520`) is already published at
official commit `e1cb91e0f25b663ef6d2439c77946602c8eae8e7` with the same
tree. That completed publication does not accept or release the new polynomial
compression artifact. On 2026-09-28 Beacon accepted its separate code/API at
`4a803474814f73e7011c045c5f613f360024b1a5` (PR #21/60312) and verified
guarded protected `main` integration (incubator #175/60316). That code
acceptance did not itself review or publish the later release artifact. The
separately reviewed official polynomial-compression publication is now complete
at `5fe9ff797f65d19f174f903774e660130ccf682d`, with the same tree as
ordinary main `f3f4e616920c163fa2a8bdd2b92ed42d419c4813`. The new public
padding-law extraction was separately accepted as code/API at
`34366b58f3e8448fdfba4210963690694b2e0042` (PR #26/61186), following
independent review 4782 and native run 939. Beacon verified its protected
`main` integration on 2026-09-29 at 02:25:07 UTC (issue #25/61199).
At that integration handoff, neither code acceptance nor integration published
the next official release; its publication was subsequently completed.

## Headline results

For a commutative ring `R`, a finite-free `R`-algebra `B` (not necessarily
commutative), and any commutative `R`-algebra `A`, the library adds:

- **A universal-coordinate norm identity.**
  `Algebra.norm_coordinates_baseChange b x` identifies evaluation of the
  native signed constant characteristic coefficient with the norm of
  `∑ i, x i ⊗ₜ[R] b i` in `A ⊗[R] B` for all `x : ι → A`.
  `Algebra.norm_universalCoordinates b` proves the **actual polynomial
  equality** with the norm of the universal tensor built from `X i`, not
  just equality of evaluations. These results work over finite fields and
  trivial coefficient algebras. Import `NormForms.UniversalCoordinates` or
  `NormForms`; see the [guide](docs/UniversalCoordinateNorm.md) and
  [ordinary-import clients](NormFormsTests/UniversalCoordinates.lean).

For a field extension `L / K` with a chosen finite `K`-basis `b` of `n` elements,
the library provides:

- **A homogeneous, anisotropic polynomial for the field norm.**
  `coordinateNormPolynomial b` evaluates at a coordinate vector `x` to the
  algebraic field norm of the element represented by `x`. It is homogeneous of
  exact total degree `n`, and its value is zero exactly when every coordinate
  is zero. See the [construction and evaluation law](NormForms/Coordinate.lean#L78),
  [zero criterion](NormForms/Coordinate.lean#L112) and
  [exact degree](NormForms/Coordinate.lean#L128).
- **Change of basis as an equality of norm polynomials.** For another finite
  basis `b'` of the same extension, substituting the linear forms that convert
  new `b'`-coordinates to old `b`-coordinates into the norm polynomial for `b`
  gives the norm polynomial for `b'`. This is a
  [structural polynomial identity](NormForms/Coordinate.lean#L284), not merely
  equality of evaluations, so it also holds over finite fields.
  [Reindexing a basis](NormForms/Coordinate.lean#L209) simply renames its variables.
- **Anisotropic forms in unbounded attained degrees.** For any field `K` with
  `¬ IsAlgClosed K` and any `bound : ℕ`, the theorem
  `MvPolynomial.exists_anisotropic_homogeneous_of_not_isAlgClosed` returns a
  homogeneous `p : MvPolynomial (Fin d) K` with `bound < d`, actual total degree
  `d` and `eval x p = 0 ↔ x = 0`. It works over finite fields and uses the
  coordinate norm of one extension followed by official finite block iteration.
  Import `NormForms.CoordinateNormIteration` or `NormForms`; see the
  [theorem and mathematical guide](docs/CoordinateNormIteration.md).

For any commutative semiring `R`, the accepted maintenance API also provides:

- **Fixed-form zero-padded substitution laws.** For an embedding `j : ι ↪ κ`,
  a family `f : ι → MvPolynomial σ R` and a fixed
  `p : MvPolynomial κ R`, the forward zero law transfers an outer polynomial's
  `eval y p = 0 → y = 0` condition to the vanishing of each substituted `f i`.
  With the outer equivalence it gives an inner equivalence, and homogeneous
  inputs of degrees `d` and `e` yield a homogeneous substitution of degree
  `d * e`. No finite-index or field assumption is needed. Import
  `NormForms.PaddedSubstitution` or `NormForms`; see the
  [padding guide](docs/PaddedSubstitution.md) and
  [direct-import client](NormFormsTests/PaddedSubstitution.lean).

For any field `K` with `¬ IsAlgClosed K`, the library also provides:

- **One equation for a finite polynomial system's K-point zeros.** Given
  `[Fintype ι]` and `f : ι → MvPolynomial σ K`, one polynomial `g` has
  `eval x g = 0 ↔ ∀ i, eval x (f i) = 0` at every `x : σ → K`.
  If every `f i` is homogeneous of degree `d`, `g` is homogeneous of degree
  `d * m` for some `m > Fintype.card ι`. No positive degree, nonempty family,
  finite variable type or infinite-field hypothesis is needed. Import
  `NormForms.CommonZeroCompression` or `NormForms`; see the
  [standalone guide](docs/PolynomialCommonZeroCompression.md) and
  [ordinary-import clients](NormFormsTests/CommonZeroCompression.lean).

For an arbitrary field `K`, given a direct single-form nontrivial-zero premise
uniform in **all positive degrees**, the library additionally provides:

- **A nontrivial zero common to equally labelled homogeneous forms.**
  `MvPolynomial.exists_nonzero_common_zero_of_single_form_bound` takes `r : ℕ`,
  `0 < d`, `s * d ^ r < n`, and `s` forms with `IsHomogeneous d` labels in
  `n` variables; it returns a nonzero common zero. Zero and repeated forms,
  `s = 0`, `r = 0` and `d = 1` need no additional hypotheses. Import
  `NormForms.HomogeneousSystemZeros` or `NormForms`; see the
  [standalone guide](docs/HomogeneousSystemZeros.md) and
  [ordinary-import clients](NormFormsTests/HomogeneousSystemZeros.lean).
  Unlike `NormForms.CommonZeroCompression`, this is a conditional
  existence theorem, not a coefficient-field zero-set compression theorem.

For fields `k` and `K` with `[Algebra k K]` and `[Algebra.IsAlgebraic k K]`,
the same direct **all-positive-degree base-field** premise gives:

- **A nontrivial zero over any algebraic field extension.**
  `MvPolynomial.exists_nonzero_zero_of_isAlgebraic_of_single_form_bound`
  takes `r : ℕ`, `0 < d`, `d ^ r < n`, and a form over `K` with
  `IsHomogeneous d`; it produces a nonzero zero over `K`, with no finite,
  separable or perfect extension assumption and no requirement that the form
  be nonzero. It covers `r = 0` and `d = 1`. Import
  `NormForms.AlgebraicExtensionFormZeros` or `NormForms`; see the
  [guide](docs/AlgebraicExtensionFormZeros.md) and
  [ordinary-import examples](NormFormsTests/AlgebraicExtensionFormZeros.lean).

For an arbitrary field `k`, the same direct **all-positive-degree single-form
premise over `k`** also gives:

- **A nontrivial zero over `RatFunc k`.**
  `MvPolynomial.exists_nonzero_zero_ratFunc_of_single_form_bound` takes
  `r : ℕ`, `0 < d`, `d ^ (r + 1) < m`, and any degree-`d` homogeneous-labelled
  form in `m` variables over `RatFunc k`; it returns a nonzero zero. The field
  may be finite, and the zero form and `r = 0` are included. Import
  `NormForms.RatFuncFormZeros` or `NormForms`; see the
  [guide](docs/RatFuncFormZeros.md) and
  [four ordinary-import examples](NormFormsTests/RatFuncFormZeros.lean).
- **A nontrivial zero over a finite-transcendence-degree extension.**
  `MvPolynomial.exists_nonzero_zero_of_trdeg_eq_of_single_form_bound` takes
  arbitrary fields `k → K` with transcendence degree `n`, a uniform
  all-positive-degree single-form bound `a ^ r < t` over `k`, and a
  homogeneous-label-`d` form over `K` with `0 < d` and strict
  `d ^ (r + n) < m`. It produces a nonzero `K`-point zero, including for
  zero forms and infinite algebraic remainders. Import
  `NormForms.FiniteTranscendenceFormZeros` or `NormForms`; see the
  [guide](docs/FiniteTranscendenceFormZeros.md) and
  [five ordinary-import examples](NormFormsTests/FiniteTranscendenceFormZeros.lean).

These interfaces let downstream developments express norm equations in
coordinates and transport them between bases. No separability or Galois
hypothesis is required; the definitions are noncomputable, not an executable
norm-calculation algorithm. Mathlib supplies the underlying field norm, bases,
characteristic polynomials and multivariable-polynomial machinery; this library
packages the coordinate norm form and proves the displayed coordinate laws. The
official `MultivariatePolynomials.IteratedBlockSubstitution` supplies finite
iteration of the base form. The existence theorem proves *unbounded attained
degrees*, not every prescribed degree or every sufficiently large degree; it
does not provide reduced norms or `C_i` theory. See the [historical six-module
native coordinate signatures](docs/API.md), [new theorem guide](docs/CoordinateNormIteration.md)
and [checked-use clients](NormFormsTests/CoordinateNormIteration.lean). The
universal tensor identity is separate from a rational-function field-extension
norm equivalence or a literal NSW cohomological recipe.

## Mathematical API

For fields `K`, `L`, an algebra structure `Algebra K L`, a finite index type `ι`
and `b : Basis ι K L`, `import NormForms` exposes:

- `coordinateNorm b`, the extension field norm in basis coordinates, its zero
  criterion and degree-`Fintype.card ι` scalar law;
- `coordinateNormPolynomial b`, the signed constant characteristic coefficient
  of left multiplication, with exact evaluation, homogeneous degree, nonzero,
  anisotropy and total-degree results;
- `coordinateChange b b'`, taking **new `b'`-coordinates to old `b`-coordinates**,
  and its norm and polynomial evaluation laws;
- `coordinateChangePolynomial b b'` and the **structural** `MvPolynomial.bind₁`
  change-of-basis identity; and polynomial variable renaming along a basis
  reindexing equivalence in its stated direction.
- `MvPolynomial.exists_anisotropic_homogeneous_of_not_isAlgClosed`, with the
  exact conclusion
  `∃ d p, bound < d ∧ p.IsHomogeneous d ∧ p.totalDegree = d ∧
  ∀ x, eval x p = 0 ↔ x = 0` for any field `K` and `¬ IsAlgClosed K`.

In namespace `Algebra`, `import NormForms.UniversalCoordinates` (or the
aggregate `NormForms`) additionally exposes `norm_coordinates_baseChange b x`
for `[CommRing R] [Ring B] [Algebra R B] [CommRing A] [Algebra R A]`, and
`norm_universalCoordinates b` for the genuine universal polynomial equality.
Both use a finite basis and `[Fintype ι]`, `[DecidableEq ι]`,
`[Module.Free R B]`, `[Module.Finite R B]`; the basis supplies the latter
two instances. At `R = K`, `B = L` for fields, the left side of the universal
theorem is **exactly the signed-coefficient expression defining** the existing
`NormForms.coordinateNormPolynomial b`, not a different polynomial. See the
[universal-coordinate guide](docs/UniversalCoordinateNorm.md) for tensor
orientation and finite/trivial cases; no wrapper definition is required.

The four named objects above are exposed noncomputable definitions, not merely
theorems. The library derives finite free-module instances from the basis without
extra separability, Galois, ambient finite-dimensional or nonempty-index
assumptions. The structural polynomial law is valid over finite fields: equal
evaluations there would not alone imply equal polynomials. The independent
coefficient, extension-field and basis-index universes are visible in the
[historical coordinate-only native signatures](docs/API.md). For a smaller import use
`import NormForms.Coordinate`, `import NormForms.CoordinateNormIteration`,
`import NormForms.UniversalCoordinates`, `import NormForms.PaddedSubstitution`,
`import NormForms.CommonZeroCompression`,
`import NormForms.AlgebraicExtensionFormZeros` or
`import NormForms.RatFuncFormZeros` or
`import NormForms.FiniteTranscendenceFormZeros`;
the reexport root is `NormForms.lean`.
The finite-transcendence theorem has no additional public tower helpers:
the field tower and equivalence transports are private. It combines the
existing algebraic-extension and rational-function single-form APIs without
adding a finite-generation or separability hypothesis.
The coordinate leaf's four private matrix/characteristic-polynomial helpers
and the universal leaf's two private helpers are not public API. For arbitrary
`σ`, `[Field K]`, `¬ IsAlgClosed K`, and `[Fintype ι]`, the two public
`MvPolynomial.exists_common_zero_polynomial` and
`MvPolynomial.exists_homogeneous_common_zero_polynomial` theorems describe
coefficient-field-point zeros; the latter requires a common `IsHomogeneous d`
input predicate and concludes `IsHomogeneous (d * m)`, **not** exact total
degree. The anisotropic-form choice remains private, but the general padding
evaluation and homogeneous-substitution laws are public. Neither theorem
claims equality of ideals, radicals, schemes or all-extension-point zero sets.

`coordinateNorm_coordinateChange` is a pre-simplification rule (`@[simp↓]`):
ordinary `simp` contracts the coordinate norm before simplifying its change-of-basis
argument. The forward `coordinateChange_apply` rule still expands bare coordinate
changes; `simp [coordinateChange_apply]`, `simp only` and `rw` remain available to
clients requesting the explicit coordinates. In the two private characteristic-
polynomial helpers, the finite basis index is reconstructed only over a nontrivial
coefficient ring; the subsingleton-ring case is discharged separately.

The checked-use client modules demonstrate the rational singleton norm, complex
sum of two squares and a nonidentity coordinate swap, as well as finite `ZMod 2`
examples with distinct `Unit`/`ULift.{1} (Fin 1)` indices in different universes.
The iteration ordinary-import private client uses `ZMod 2` and bound `100`;
the universal client also checks trivial `ZMod 1`. The compression client checks
empty and all-zero families, degree zero, empty/arbitrary variable types and
finite `ZMod 2`. The algebraic-extension client checks general, finite and
identity extensions, `r = 0`, `d = 1` and the zero form. These are tests, not
extra production theorems. The rational-function client additionally checks
minimal arity, zero forms and `r = 0`. The finite-transcendence client checks
the general theorem, minimal arity, zero forms, `n = 0`, and `r = 0` at
`d = 1`. This library does **not** supply
every-degree existence, normic order, `C_i` theory, reduced norms or cohomology;
no complete source-formalization claim is made here.

## Build and checks

This library pins Lean `v4.34.0-rc2`, mathlib
`83abb3e776bdefcbc447a1e44d0debe4010039e5` and official
`multivariate-polynomials` `6a04276766ad82d60702b24deb9a559a30a80007`.
For a fresh build, install the pinned toolchain, successfully fetch the matching
mathlib cache, then build **both** current roots from this repository root:

```sh
elan toolchain install "$(cat lean-toolchain)"
lake exe cache get
LEAN_NUM_THREADS=2 lake --wfail build NormForms NormFormsTests
```

These commands are reproduction instructions, not a new run by this
static transfer author. On 2026-09-28, ordinary native
run 823 succeeded on the previously accepted
`313612a372a8c55a4e2af2bd0461d302998b6217` with its historical Lean,
dependency and checker inputs, including `multivariate-polynomials`
`ec4906268f2a65a54e320ce9f3f44562e9d78c1e` (not the current `6a042767…`
pin): the matching mathlib cache was fetched and
verified before both aggregate roots built (2,068 jobs). The actual transitive
axiom audit covered 48 declarations across eight modules, including eight
private names and generated declarations, and found only `propext`,
`Classical.choice` and `Quot.sound` (owner intake 58689; PR #13 acceptance
58741). That eight-module evidence is historical: the accepted universal
contribution changed Lean source and both aggregate roots to ten modules,
requiring new current-graph evidence. The previous run 823 is **not** a
current-input certificate. The applicable native run 864 (UI 12, artifact
181363) on accepted `7a0fe210795b6b1ba26a0bdf272e69c156b123c0`
succeeded from 20:32:22 to 20:34:53 UTC on 2026-09-28. After a successful
matching-cache fetch it built both roots (2,070 jobs) and audited the actual
transitive axiom dependencies of 57 declarations across all ten modules,
including 15 private names; every set contains only the three allowed
axioms. Beacon retained the full run in
`a065951d8112e71aa6825fbebdb6c631fe8a26e6` (incubator issue #170,
record 59605). These are runner-specific total run timestamps, not a
project-only compilation benchmark or memory measurement. That earlier
universal-coordinate documentary preparation changed the complete input
digest but left its Lean/build/dependency/checker inputs unchanged.

The subsequent polynomial-compression transfer changed the production and test
roots and added two module leaves. Native run 864 applied only to the previous
ten-module graph; the isolated donor's focused checks did not certify the
destination graph. Its own native run 904 (UI 16, artifact 194981) succeeded
on exact C `4a803474814f73e7011c045c5f613f360024b1a5` from 22:57:18 to
23:00:18 UTC on 2026-09-28. Matching-cache fetch and verification preceded
the successful both-root build (2,072 jobs); the complete actual-origin
transitive audit covered all twelve Lean modules, 36 compiled parts and 62
declarations including 18 private origins and five new producer/client origins.
All axiom sets are subsets of `propext`, `Classical.choice` and `Quot.sound`
(owner intake incubator #175/60292). Fresh independent worker-a Task
`hive-request-23c96d626c3ec88ebbde46b9da9ade7cf64b5c9e` (UID
`2b20c511-56b9-488f-b807-263fab37cf68`) approved exact C in native review
4735; Beacon accepted C in PR #21/60312 and verified protected integration
in incubator #175/60316. That earlier documentary preparation changed the complete
input digest but not C's Lean/build/dependency/checker inputs. Its selected
axiom-print module requests 22 named production results and the same 11 named
client results; the additional iteration theorem makes 23 named public
production results overall. Those prints alone are not the complete
private/generated audit. No new proof run or benchmark is claimed here.

The subsequently accepted public padding-law extraction changes the Lean graph
to fourteen modules. Run 904 and its 22 selected production axiom prints apply
only to the preceding twelve-module release. Configured native run 939 (UI 20,
job 940, artifact 209763) succeeded on exact S
`34366b58f3e8448fdfba4210963690694b2e0042` on 2026-09-29 from
02:07:16 to 02:10:16 UTC: matching-cache fetch and verification preceded a
successful build of both roots (2,074 jobs), then complete transitive
standard-axiom audits of all 65 actual origins, including 18 private, across
fourteen modules and 42 compiled parts. All 68 recorded commands exited zero;
the only axioms were `propext`, `Classical.choice` and `Quot.sound` (owner
issue #25/61176; retained artifact at
`5c4af06efed8d7dc1ce69c5e25ba78432e97c7e9:evidence/padded-substitution-native939`).
That fourteen-module documentary update changed the full file-input digest,
**not** the Lean/build/dependency/checker inputs to which that earlier
evidence applied; it was not a new proof check. At that stage, the selected
print module requested 25 named
production results, including the three new laws, and 11 named client results;
the public iteration theorem is additional to those 25. Selected prints are
not a substitute for the full native audit, and no new benchmark is inferred.

The predecessor homogeneous-system release added another producer/client
pair (sixteen modules) and was separately published at official
`22413e8f4fa8409ba06b6242a67adbbc76733a02`. Its native predecessor
evidence does not certify this eighteen-module algebraic-extension transfer:
the new `multivariate-polynomials` pin, producer and ordinary-import client
change the checking inputs. An applicable both-root build and full actual
transitive standard-axiom audit including private/generated origins must be
obtained for the exact new graph; no such check is claimed by this author.

The following older e37 commands and observations are **historical** and apply
only to a separate checkout of the old six-module source and its old mathlib
`e37d88a26f3791ed5a93daa1f949af1021b8d103` Lake inputs; do not run them
against this new graph. Per-file and `leanchecker` runs are optional historical
reproduction, not additional release gates:

```sh
elan toolchain install "$(cat lean-toolchain)"
lake exe cache get
LEAN_NUM_THREADS=2 lake --wfail build NormForms NormFormsTests NormFormsTests.Axioms
for file in NormForms/Coordinate.lean NormForms.lean \
  NormFormsTests/Coordinate.lean NormFormsTests/DirectAPI.lean \
  NormFormsTests/Axioms.lean NormFormsTests.lean; do
  LEAN_NUM_THREADS=2 lake env lean "$file"
  LEAN_NUM_THREADS=2 lake env lean -T0 "$file"
done
LEAN_NUM_THREADS=2 lake env leanchecker -v NormForms.Coordinate NormForms \
  NormFormsTests.Coordinate NormFormsTests.DirectAPI \
  NormFormsTests.Axioms NormFormsTests
```

Fetch the matching mathlib cache **successfully before any build**; do not replace
a failed fetch by a silent full mathlib rebuild. Historically, the old test root
imported two client leaves and `NormFormsTests.Axioms`, which printed axioms for
18 public production declarations and 11 named client theorems. The
pre-transfer root also imported the iteration ZMod client; the ten-module root added
the universal clients. At that stage the selected print module had 20 production prints
(18 coordinate and two universal), plus 11 named client prints. The public
iteration theorem is additional, for 21 named production declarations overall.
Old prints and a separate
kernel replay do not certify all current private/generated/stored bodies: the
complete actual transitive audit on the ten-module historical graph came from
native run 864, not these selected prints. `-T0`
changes heartbeat behavior, not kernel assurance. Consult [historical native
documentation reproduction](docs/README.md) for the six-module doc-gen4 run,
raw-record retention and source-only replay.

**Historical observed cost, not a current-graph check or scheduler guarantee.**
In one 2026-09-26 checkout,
toolchain installation and the mandatory 8,892-file mathlib fetch began at
01:40:53 UTC, and successful cache completion was verified before the first
project build at 01:43:05 UTC. The log does not separately time the cache fetch.
The subsequent first `NormForms.Coordinate` build reported 2.3 s of compilation,
and the default roots/tests command ran from 01:43:47 to 01:43:53 UTC. These
project-build times use the installed toolchain and downloaded dependencies after
the cache fetch and do not predict a full dependency source build. The environment
reported a 15 GiB cgroup memory limit and a four-CPU quota; a sampled cgroup current value
was 13,565,493,248 bytes while cache/tool work overlapped (including other
processes and reclaimable page cache), **not** a peak or any child's RSS. One
observed `.lake` directory was approximately 7.7 GiB after cache extraction.
`LEAN_NUM_THREADS=2` limits Lean runtime threads, not all process concurrency or
memory; neither `lake -Kjobs` nor `LAKE_JOBS` is a verified total scheduler cap.
Serialize heavy checks and observe local memory pressure when resources differ.

## Attribution and lifecycle

The predecessor history below preserves its dated stage-specific language
through 2026-09-29; earlier uses of “present candidate” refer to the
then-current predecessor, not this rational-function transfer. The accepted
eighteen-module predecessor at main `ba4a2c3a7e71afe516ef4b91d6f373c1a0846e1c`
was separately reviewed, released and verified at official
`3e492c4684694e80bceacb43bf930fef5157048b` before the new transfer.

Original Formal Frontier mathematical proof expression is preserved in this
library. Beacon authored the coordinate-norm definition, zero/scalar laws and
the signed-characteristic-coefficient norm polynomial with its homogeneity,
evaluation, anisotropy, nonzero and degree proofs in source-nsw, accepted at
`3f8e50e8272911a16d625e1a9a6dde00cde5eb47` (originating at
`cce37e4118dc538f0f0c1d1e6eff6b8c50029f85` and
`29963e4c2eedbcc20822b51ffc4256144b46da04`). This is **expression reuse**,
not merely inspiration. Pooled worker-a Task
`hive-request-0c76c0ce0c8c2a7dd0e4d7e8ba3abec678c36684` assembled the
reusable library, adapted Beacon's code and contributed new structural
change-of-basis/reindexing and private matrix/characteristic-polynomial proofs.
Pooled worker-b contributed module-system migration and checked clients.
Independent pooled worker-b Task
`hive-request-1b8d956ab055379afc534e20cd82fdc44e966899` reviewed the
initial mathematical library; fresh pooled worker-a Task
`hive-request-ef3f24c1ae9c27b5a6cb3b7ff8e2b17a7eb8ae4d`
(UID `3cc66b9b-09c4-4b1e-94b7-5165abc1d373`) reviewed the ordinary-main
successor at `e1271e6961181f3e1e60392b339cf0b5a6c863e4` (review #2977,
full issue #1 record #40208 and narrow license addendum #40222). Beacon accepted
that exact successor in issue #1 record #40248; protected integration #40250
produced the accepted development-main revision above on 2026-09-25. These
dated, exact-version acceptance records remain external to the library and are
**not** inherited approval of a later generated-documentation candidate.

The original assembled existence theorem and its ordinary-import ZMod client
reuse the proof expression from isolated incubator revision
`edc6961da2dfee53dcfa8de0d6d8c41cc9a560ed`, authored by worker-b Task
`hive-request-f7fefa6fea31fecce0577537ebd9c88ff30c913f` (UID
`42fc0f36-5c45-4112-89c7-a007b636725a`). It extends Beacon's coordinate
norm using the official Multivariate finite iteration: generic block substitution
by worker-b Task `hive-request-7b6e0f04fc7e294c99c77638da5d6abb97b4be03`
(UID `0068e189-b29d-4cf7-9b0c-63cb34dab472`), finite iteration by worker-a
Task `hive-request-48b8f568eaec9f747a0528cb5fe8ae07ff507397` (UID
`580b0679-5109-43e3-8af0-05470fe31187`), transferred to the official
Multivariate library by worker-b Task
`hive-request-2deb4fea21bdf1e8bfd734175d5bf8c681d288c7` (UID
`f641b493-3b74-49f4-bc2d-bb46824a4fa5`). Worker-a Task
`hive-request-a4ccd90e846e995a5a3279bd28c75f97b0b7ac27` (UID
`28f9c532-c101-4340-8ae2-b8b5be19bfbc`) independently reviewed, and Beacon
accepted, **only** the isolated input. Worker-b Task
`hive-request-c088ae9d9a0d3444007ff4f1ee1775bb56d3650a` (UID
`2bffa995-8832-471d-860b-2c8fd6b4a328`) prepared this standalone
destination transfer without donor commit ancestry. Independent worker-a Task
`hive-request-fcb0935dba04fc17d06ffa0ee41e9e620a7af414` (UID
`df5947c5-96ed-4503-bb64-3081612cd20c`) reviewed exact destination H
(review 4631); native run 823 succeeded on H, and Beacon accepted and
integrated H (PR #13, 58741/58744). Worker-b Task
`hive-request-f1a3c9d387b0214bb0518f8a08d4fb053d20085f` (UID
`e7750ec2-a10d-4c6c-b465-5fc6b292c285`) prepared this subsequent
documentation-only release candidate, not its independent release review.

The separately pinned mathlib supplies the field norm, characteristic-polynomial,
basis and multivariable polynomial interfaces; the exact official
`multivariate-polynomials` revision supplies finite block iteration.
Neukirch–Schmidt–Wingberg,
*Cohomology of Number Fields*, Chapter VI, is mathematical background, not
reproduced book expression or a claim of complete source coverage. Project
contributions use [Apache-2.0](LICENSE). Authors: Formal Frontier Agents.
No individual copyright holder is invented. The pinned LICENSE is
11,357 bytes, SHA-256 `b40930bbcf80744c86c46a12bc9da056641d722716c378f5659b9e555ef833e1`;
its exact text is not changed here. The source-repository expression and
metadata are distinct from rights clearance for third-party material. Neither
original-project licensing authority nor ordinary-main acceptance by itself
clears generated artifacts, dependency notices or proposed public history.

Release acceptance is recorded separately for an exact artifact. Its computational
checks are an applicable successful pinned build and a complete actual transitive
axiom audit, including private/generated declarations and their dependencies,
allowing only `propext`, `Classical.choice` and `Quot.sound`. The ordinary build
checks proofs; separate stored-proof replay, a fresh documentation-generation run
and repeated consumer builds are not additional release gates. Reuse successful
evidence for unchanged checking inputs; changed inputs require applicable renewed
checks. The documentation commands and dated observations above remain historical
reproduction information, not a requirement to rerun them for each release.

Mathematics, API claims, documentation, metadata, rights, provenance and public
history receive lightweight exact-candidate independent non-author review, followed
by maintainer acceptance and authorized protected internal/public promotion. Verify
the exact published commit and destination, and keep source-coverage decisions
separate. The previous coordinate Q publication at
`db29d765e132d995bfed69f4424cf6a0261e95ac` and subsequent
universal-coordinate P publication at
`e1cb91e0f25b663ef6d2439c77946602c8eae8e7` are complete. The
polynomial-compression official Q publication at
`5fe9ff797f65d19f174f903774e660130ccf682d` is also complete. The new
padding-law code/API passed native run 939 and fresh independent worker-a
review 4782 by Task `hive-request-3d69bea9eb1999955d5963026e068f620c77d09e`
(UID `4b70d28c-ab1d-4812-bb82-dde3465979c5`); Beacon accepted exact S
in PR #26/61186 and verified its protected integration in issue #25/61199.
At its earlier static documentary preparation, that same-tree public artifact
still required independent release review, Beacon's separate stage acceptance
and verified official GitHub publication; previous code approval did not
transfer to those stages. Those predecessor stages later completed, with the
sixteen-module homogeneous-system release officially published at
`22413e8f4fa8409ba06b6242a67adbbc76733a02`.
Tags remain deferred, not a release-preparation requirement. `formalization.yaml`
retains scope and historical review without upgrading source-level milestones.
The preceding universal-coordinate transfer is by worker-b Hive Task
`hive-request-8d86211aac37fbfbacde1cff6292e2c8a00e2629` (UID
`5daebbc8-1ee0-4dff-99c9-44d0a3e9bf9a`), reusing the proof expression,
five private clients and guide from isolated H
`b09f3c187eb6c9a17b1b08f2add69c081f04945f`, authored by worker-b Task
`hive-request-d2dad13a497343a75e6182e409c383b3aa2a14d9` (UID
`47d468b5-b70e-4340-8f05-bb4ea48acc79`). H was independently reviewed
by worker-a Task `hive-request-ad3bc257117d6035b4fdd0e632d083c6cac12ccd`
(UID `017291c6-f001-42b7-8151-de0c74eeade7`) and accepted by Beacon
in incubator issue #170/59476 **as isolated code only**. That review and
acceptance do not certify this destination graph, any source coverage, or
third-party rights. Fresh worker-a Task
`hive-request-434d90f78f1d94c51d15a45962e8aea3da037e5b` (UID
`61738d70-2bad-4bdd-a1c0-058d0339589d`) independently reviewed exact
destination C; Beacon accepted it in PR #17/59647 and verified protected
integration in incubator issue #170/59660. This later documentary release
preparation is by worker-b Task
`hive-request-847f8a2c7a0441d60d269b58583877aebf2e5b66` (UID
`50282a97-7767-4038-959e-f2b067f06160`), not a self-review or release
acceptance.

The earlier polynomial compression expression and private client were authored
in isolated incubator H `272d5abe773245829435be9b3cc4318f6b7505eb`
by worker-b Task `hive-request-8306ff75faa6638080e54d36d849222c7ac1948a`
(UID `03f7d2d8-159f-4715-a179-413c704b5507`). Worker-a Task
`hive-request-cee92f392eeacba31bce30072ea79308ee41a539` (UID
`1af91b4f-4d05-4a1c-aaa3-a57ecb10a627`) independently approved exact
isolated H and Beacon accepted that isolated scope. Worker-b Task
`hive-request-7fa01782d4333fb52b06189a0cb7b7047745b74c` (UID
`13a94950-58fd-4d63-83f8-56f57e0e4c8c`) transfers the mathematical
expression and representative client to this destination without incubator
ancestry. Native run 904 checked the exact destination graph, fresh worker-a
Task `hive-request-23c96d626c3ec88ebbde46b9da9ade7cf64b5c9e` (UID
`2b20c511-56b9-488f-b807-263fab37cf68`) reviewed exact C, and Beacon
accepted/integrated it in PR #21/60312 and incubator #175/60316. At that
earlier transfer's preparation, its own reviewed release and official
publication were still pending; both were later completed at
`5fe9ff797f65d19f174f903774e660130ccf682d`. The bounded static
documentary preparation is by worker-b Task
`hive-request-9d6cb244757d207017694ca539c971c47be480aa` (UID
`e5f3b774-1939-4a87-a020-42e43ac815c1`), not its proof author, reviewer
or release approver. Source correspondence and coverage remain separate
decisions, and no other party's copyright is inferred.

The preceding compression contribution was subsequently published at official
`5fe9ff797f65d19f174f903774e660130ccf682d`. This separate public-law
extraction, consumer refactor, ordinary-import tests and guide are by worker-b
Hive Task `hive-request-87ff0e576db2df1f58dd28051b6af90d850a3eaa` (UID
`7c3de02d-f84f-4e5a-9077-b7d90c89c9ad`), adapting the credited original
proof. At the S code-review stage, exact S received independent review 4782
and Beacon's code acceptance, not a release or source-coverage decision; its
reviewed publication later completed. That static release documentation
is prepared by worker-b Task `hive-request-81ff4f8ed4e54e710826db01b99d3f8b6e66719e`
(UID `57b7bdad-4de2-40e5-b222-fb4e1ab53c8f`), not a proof author,
independent reviewer or release approver.

The present eighteen-module candidate reuses the accepted incubator
algebraic-extension producer and six ordinary-import examples from original
worker-b Task `hive-request-96f1dca1b4a17c56caa8ca7f8b8d518f14944536`
(UID `04300275-f025-45ca-8cab-6a198698424e`), with distinct original
isolated worker-a review and subsequent assembly credited in
`formalization.yaml`. Worker-b Task
`hive-request-7b6e9279b48464263e0c3cf4204d661927b773af` (UID
`ab6641b6-10f3-495f-93a6-8879acd6c835`) performs only this destination
static transfer, not mathematical authorship, independent review, acceptance
or release. This candidate changes the pinned MP graph and has no inherited
new-graph build/axiom or destination review; selected-source coverage and
third-party rights remain separate decisions.

The rational-function proof and four ordinary-import examples were originally
authored by worker-b Task
`hive-request-2cef48b41c07b09925370673ed34c399f4e5cd3a` (UID
`21ba059a-7155-468f-a088-ed904d1d29fe`) and subsequently accepted into
incubator main at `1d4559379957b0ce3ebc213cd644269e1244146e` after separate
review and checks. Worker-b Task
`hive-request-93e49bdef50daa6fb22fb8cc27768ee64799ec47` (UID
`c96ea3cc-7f67-4c87-b215-0c1e2f3c9311`) transfers their unchanged proof/client
content with project headers and an original guide, without importing incubator
history. This Task is neither the original proof author nor an independent
reviewer or release approver. At preparation on 2026-09-29, before destination
review and acceptance, this transfer still needed its own checks, review,
responsible-maintainer acceptance and reviewed publication;
its Apache-2.0 project expression does not imply third-party rights clearance.
