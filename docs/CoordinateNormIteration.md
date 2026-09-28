# Iterated coordinate norms

Import `NormForms.CoordinateNormIteration` (or `NormForms`) for
`MvPolynomial.exists_anisotropic_homogeneous_of_not_isAlgClosed`. For any
`K : Type u` with `[Field K]` and `hK : ¬ IsAlgClosed K`, and every
`bound : ℕ`, the theorem has the following conclusion:

```lean
∃ (d : ℕ) (p : MvPolynomial (Fin d) K),
  bound < d ∧ p.IsHomogeneous d ∧ p.totalDegree = d ∧
    ∀ x : Fin d → K, MvPolynomial.eval x p = 0 ↔ x = 0
```

The construction needs **one**, not a family of, finite field extensions.
Contraposing `IsAlgClosed.of_exists_root` yields an irreducible polynomial
`f : Polynomial K` without a root in `K`. Its natural degree `n` is positive;
if it were one, `Polynomial.exists_root_of_degree_eq_one` would contradict the
choice of `f`. Thus `1 < n`. The irreducible-polynomial instance makes
`AdjoinRoot f` a field, and `AdjoinRoot.powerBasis` gives a basis indexed by
`Fin n`. `NormForms.coordinateNormPolynomial` of this basis is homogeneous
of degree `n` and vanishes exactly at the zero vector. No separability or
Galois hypothesis is used.

The official `MultivariatePolynomials.IteratedBlockSubstitution` API iterates
the base form on variables `Fin r → Fin n`, preserves both homogeneity of
degree `n ^ r` and the zero-locus equivalence, and proves the **actual** total
degrees of the iterates exceed each bound. The cardinality of this function
index is `n ^ r`; `Fintype.equivOfCardEq` reindexes it to `Fin (n ^ r)`.
Mathlib's structural `rename`, `eval_rename`, `rename_isHomogeneous`, and
`totalDegree_renameEquiv` transfer the three properties. This does not
infer polynomial equality from equality of evaluations over a finite field.

For example, the private ordinary-import client
`NormFormsTests.CoordinateNormIteration` instantiates the
result at `ZMod 2` and bound `100`, then extracts a degree and zero-locus
consequence. Every finite field is non-algebraically-closed, since the
mathlib `IsAlgClosed` instance implies `Infinite`; the client uses the
contradiction with the finite type `ZMod 2`.

These are *attained* degrees `n ^ r`, not all prescribed degrees or every
sufficiently large degree. This extension of the coordinate norm API does not
introduce a general finite-extension wrapper, a `C_i`/`dd` abstraction,
source-passage correspondence, or a source-coverage decision. On 2026-09-28,
native run 823 passed the pinned-graph both-root build and complete actual
transitive standard-axiom audit; worker-a review 4631 approved exact destination
`313612a372a8c55a4e2af2bd0461d302998b6217`, and Beacon accepted and
integrated it in PR #13 (58741/58744). This subsequent readiness revision
still requires separate independent release review, acceptance and publication;
this guide does not certify a new release.

This library uses Lean `v4.34.0-rc2`, direct mathlib
`83abb3e776bdefcbc447a1e44d0debe4010039e5`, and the exact official
`multivariate-polynomials` revision
`ec4906268f2a65a54e320ce9f3f44562e9d78c1e`. The latter supplies the
public `MultivariatePolynomials.IteratedBlockSubstitution` leaf; neither an
incubator checkout nor a source-research repository is a dependency. When
validating this library from its root, first fetch the matching mathlib cache:

```sh
elan toolchain install leanprover/lean4:v4.34.0-rc2
lake exe cache get
lake build NormForms NormFormsTests
```

This build recipe is not a substitute for a complete actual transitive axiom
audit, including private/generated declarations, on the destination graph;
run 823 supplies that historical exact-input evidence without a new run here.

The original coordinate-norm mathematics was authored by Beacon; its
source-independent NormForms library was assembled and extended by worker-a
Task `hive-request-0c76c0ce0c8c2a7dd0e4d7e8ba3abec678c36684`.
The generic block-substitution contributor was worker-b Task
`hive-request-7b6e0f04fc7e294c99c77638da5d6abb97b4be03` (UID
`0068e189-b29d-4cf7-9b0c-63cb34dab472`); the finite-iteration contributor
was worker-a Task `hive-request-48b8f568eaec9f747a0528cb5fe8ae07ff507397`
(UID `580b0679-5109-43e3-8af0-05470fe31187`), transferred to the official
library by worker-b Task `hive-request-2deb4fea21bdf1e8bfd734175d5bf8c681d288c7`
(UID `f641b493-3b74-49f4-bc2d-bb46824a4fa5`). This isolated composition
was authored by worker-b Task `hive-request-f7fefa6fea31fecce0577537ebd9c88ff30c913f`
(UID `42fc0f36-5c45-4112-89c7-a007b636725a`). Worker-a Task
`hive-request-a4ccd90e846e995a5a3279bd28c75f97b0b7ac27` (UID
`28f9c532-c101-4340-8ae2-b8b5be19bfbc`) independently reviewed, and Beacon
accepted, that *isolated* input only. Worker-b Task
`hive-request-c088ae9d9a0d3444007ff4f1ee1775bb56d3650a` (UID
`2bffa995-8832-471d-860b-2c8fd6b4a328`) transferred its expression,
private client and guide into the destination contribution. Independent
worker-a Task `hive-request-fcb0935dba04fc17d06ffa0ee41e9e620a7af414`
(UID `df5947c5-96ed-4503-bb64-3081612cd20c`) reviewed exact destination H;
Beacon accepted and integrated H on 2026-09-28. Worker-b Task
`hive-request-f1a3c9d387b0214bb0518f8a08d4fb053d20085f` (UID
`e7750ec2-a10d-4c6c-b465-5fc6b292c285`) prepared this subsequent
documentation-only release candidate. Beacon retains the separate release
decisions; neither review nor integration establishes source coverage.
