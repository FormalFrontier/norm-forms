# Norm Forms

`NormForms` is a source-independent Lean library for coordinate norm forms of field
extensions supplied with a finite basis. It depends only on mathlib. An earlier
mathematical input was accepted for ordinary development on 2026-09-25 at
`a87e5d0691a76d2118fbe8de864a5d02a38596bc` (tree
`a9e3d910f11de2ba3412e20fc758e66d2249f510`). The lint repair analyzed by
the native reference comes from subsequent code commit
`54accffeba182bea1f6969c2f6d67a96a43dc6f7`, which was unaccepted when
the native runs were recorded on 2026-09-26. Neither the earlier acceptance
nor the Lake package version `0.1.0` designates a release. Exact-artifact review
and publication records identify any subsequently accepted release; the repair
and documentation do not inherit the historical mathematical review.
Beacon is responsible for this unit, with shared source-maintainer stewardship.

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

The four named objects above are exposed noncomputable definitions, not merely
theorems. The library derives finite free-module instances from the basis without
extra separability, Galois, ambient finite-dimensional or nonempty-index
assumptions. The structural polynomial law is valid over finite fields: equal
evaluations there would not alone imply equal polynomials. The independent
coefficient, extension-field and basis-index universes are visible in the
[complete native signatures](docs/API.md). For a smaller import use
`import NormForms.Coordinate`; the reexport root is `NormForms.lean`. Four private
matrix/characteristic-polynomial proof helpers are not public API.

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
They are tests, not extra production theorems. This library does **not** supply
general forms, normic order, `C_i` theory, reduced norms or cohomology; no
complete source-formalization claim is made here.

## Build and checks

Use the pinned Lean `v4.34.0-rc2` toolchain and mathlib
`e37d88a26f3791ed5a93daa1f949af1021b8d103`. From this repository root:

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
a failed fetch by a silent full mathlib rebuild. The built test root imports the
two client leaves and `NormFormsTests.Axioms`, which prints axioms for 18 public
production declarations and 11 named client theorems. Those prints and a separate
kernel replay do not certify all private/generated/stored bodies: the full
release-wide audit is a separate requirement. `-T0` changes heartbeat behavior,
not kernel assurance. Consult [native documentation reproduction](docs/README.md)
for the six-module doc-gen4 run, raw-record retention and source-only replay.

**Observed cost, not a scheduler guarantee.** In one 2026-09-26 checkout,
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

The separately pinned mathlib supplies the field norm, characteristic-polynomial,
basis and multivariable polynomial interfaces. Neukirch–Schmidt–Wingberg,
*Cohomology of Number Fields*, Chapter VI, is mathematical background, not
reproduced book expression or a claim of complete source coverage. Project
contributions use [Apache-2.0](LICENSE). Authors: Formal Frontier Agents.
No individual copyright holder is invented. The pinned LICENSE is
11,357 bytes, SHA-256 `b40930bbcf80744c86c46a12bc9da056641d722716c378f5659b9e555ef833e1`;
its exact text is not changed here. The source-repository expression and
metadata are distinct from rights clearance for third-party material. Neither
original-project licensing authority nor ordinary-main acceptance by itself
clears generated artifacts, dependency notices or proposed public history.

Release acceptance is recorded separately for an exact artifact and requires an
all-shipped, private/generated and stored-body proof audit, lint disposition,
actual documentation run and
version-bound records, exact-candidate mathematical/API/rights review, maintainer
acceptance, authorized internal preparation/promotion and separate public-root,
consumer and mirror verification, with independent non-author review. The recorded
native-documentation runs and historical reviews above are evidence within those
gates, not a declaration that every gate is complete. Tags are deferred,
**not required to prepare the first release**. `formalization.yaml` records scope and historical review
without asserting that those gates or source-level milestone decisions are done.
