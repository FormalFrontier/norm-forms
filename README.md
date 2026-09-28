# Norm Forms

`NormForms` is a source-independent Lean library for universal coordinate norms
under commutative base change, coordinate norm forms of field extensions, and
unbounded attained-degree anisotropic homogeneous forms over
non-algebraically-closed fields. It depends
directly on mathlib and the exact official `multivariate-polynomials` release.
An earlier
mathematical input was accepted for ordinary development on 2026-09-25 at
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
`import NormForms.Coordinate`, `import NormForms.CoordinateNormIteration` or
`import NormForms.UniversalCoordinates`; the reexport root is `NormForms.lean`.
The coordinate leaf's four private matrix/characteristic-polynomial helpers
and the universal leaf's two private helpers are not public API.

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
the universal client also checks trivial `ZMod 1`. These
are tests, not extra production theorems. This library does **not** supply
every-degree existence, normic order, `C_i` theory, reduced norms or cohomology;
no complete source-formalization claim is made here.

## Build and checks

This library pins Lean `v4.34.0-rc2`, mathlib
`83abb3e776bdefcbc447a1e44d0debe4010039e5` and official
`multivariate-polynomials` `ec4906268f2a65a54e320ce9f3f44562e9d78c1e`.
For a fresh build, install the pinned toolchain, successfully fetch the matching
mathlib cache, then build **both** current roots from this repository root:

```sh
elan toolchain install "$(cat lean-toolchain)"
lake exe cache get
LEAN_NUM_THREADS=2 lake --wfail build NormForms NormFormsTests
```

These commands are reproduction instructions, not a new run by this
documentation-only preparer. On 2026-09-28, ordinary native
run 823 succeeded on the previously accepted
`313612a372a8c55a4e2af2bd0461d302998b6217` with these exact Lean,
dependency and checker inputs: the matching mathlib cache was fetched and
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
project-only compilation benchmark or memory measurement. Documentation-only
changes here leave Lean/build/dependency/checker inputs unchanged, although
they change the complete input digest.

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
pre-transfer root also imported the iteration ZMod client; this new root adds
the universal clients. The selected print module now has 20 production prints
(18 coordinate and two universal), plus 11 named client prints. The public
iteration theorem is additional, for 21 named production declarations overall.
Old prints and a separate
kernel replay do not certify all current private/generated/stored bodies: the
complete actual transitive audit on the current graph comes from native run
864, not these selected prints. `-T0`
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
separate. The completed previous Q release does not approve the separate
universal-coordinate release artifact, even though its code contribution at C
was accepted on 2026-09-28. This documentary readiness and its temporary
public candidate still need their own independent artifact review and Beacon's
separate release-stage acceptances; exact-artifact records, not this
preparation-time prose, determine eventual publication.
Tags remain deferred, not a release-preparation requirement. `formalization.yaml`
retains scope and historical review without upgrading source-level milestones.
The present universal-coordinate transfer is by worker-b Hive Task
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
