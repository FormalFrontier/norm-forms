# Norm Forms

`NormForms` is a Lean library of coordinate norms, polynomial forms and
common-zero theorems. Its results include universal norms over commutative base
change, anisotropic norm forms, compression of finite polynomial systems at
coefficient-field points, conditional nontrivial zeros of homogeneous systems,
field-extension transfer, finite-field common zeros and scalar sums annihilating
positive tensor powers. Import `NormForms` for the full library or one of the
individual modules linked below. The library contains eleven production leaves,
thirteen checked-use/test leaves and two aggregate roots.

## Headline results

- **Universal coordinate norms.** For a finite-free `R`-algebra `B` (which need
  not be commutative), a commutative ring `R`, a commutative `R`-algebra `A` and
  a finite basis `b`, `Algebra.norm_coordinates_baseChange b x` identifies the
  native norm after base change with evaluation of the signed constant
  characteristic-coefficient polynomial. `Algebra.norm_universalCoordinates b`
  gives an **equality of polynomials** for the universal tensor, not just an
  equality of evaluations. These work over finite coefficient fields and even
  trivial coefficient algebras. See
  [`NormForms.UniversalCoordinates`](NormForms/UniversalCoordinates.lean) and
  the [universal-coordinate guide](docs/UniversalCoordinateNorm.md).
- **Norm forms and basis changes.** For a finite field extension `L / K` with
  finite `K`-basis `b` indexed by `ι`, `NormForms.coordinateNormPolynomial b`
  evaluates to the field norm, is homogeneous of **actual total degree**
  `Fintype.card ι`, and vanishes precisely at the zero coordinate vector.
  `NormForms.coordinateChange` converts *new* coordinates into *old* ones;
  changing or reindexing the basis gives structural polynomial identities,
  including over finite fields where evaluation alone cannot establish
  polynomial equality. See [`NormForms.Coordinate`](NormForms/Coordinate.lean),
  [its clients](NormFormsTests/Coordinate.lean) and the
  [historical coordinate signatures](docs/API.md).
- **Unbounded attained anisotropic degrees.** If `K` is not algebraically
  closed, `MvPolynomial.exists_anisotropic_homogeneous_of_not_isAlgClosed`
  produces, for every bound, a homogeneous anisotropic form whose *actual*
  degree exceeds that bound. It does **not** produce a form in every prescribed
  degree. See
  [`NormForms.CoordinateNormIteration`](NormForms/CoordinateNormIteration.lean)
  and the [iteration guide](docs/CoordinateNormIteration.md).
- **Fixed-polynomial padding and system compression.** For a commutative
  semiring, an embedding of index types and a fixed outer polynomial,
  [`NormForms.PaddedSubstitution`](NormForms/PaddedSubstitution.lean) transfers
  zero conditions and proves the homogeneous-substitution label law `d * e`
  without finiteness or field assumptions. Over any non-algebraically-closed
  field, the public
  `MvPolynomial.exists_common_zero_polynomial` compresses a finite family's
  **K-point** common zeros to one equation. Its homogeneous variant takes a
  common degree label `d` and produces label `d * m` for some
  `m > Fintype.card ι`, not a claim about actual total degree. Neither
  theorem asserts equality of ideals, radicals, schemes or zeros over every
  extension field. See
  [`NormForms.CommonZeroCompression`](NormForms/CommonZeroCompression.lean),
  the [padding guide](docs/PaddedSubstitution.md) and the
  [compression guide](docs/PolynomialCommonZeroCompression.md).
- **Common zeros under a direct single-form hypothesis.** Over any field,
  `MvPolynomial.exists_nonzero_common_zero_of_single_form_bound` converts a
  **direct uniform all-positive-degree** single-form nontrivial-zero premise
  into a nonzero common zero for `s` forms of the same positive homogeneous
  label `d` in `n` variables, provided `s * d ^ r < n`. Zero and repeated
  forms and `s = 0`, `r = 0`, `d = 1` are included. This conditional existence
  theorem is distinct from K-point zero-set compression. See
  [`NormForms.HomogeneousSystemZeros`](NormForms/HomogeneousSystemZeros.lean)
  and the [system guide](docs/HomogeneousSystemZeros.md).
- **Field-extension zeros.** With the same direct *base-field*
  all-positive-degree premise, a positive-degree `d`-homogeneous-labelled
  form has a nonzero zero over any algebraic extension if `d ^ r < n`;
  no finite, separable or perfect-extension hypothesis is needed. Over
  `RatFunc k` the strict bound becomes `d ^ (r + 1) < m`. For an extension
  `k → K` of transcendence degree `t` the bound is `d ^ (r + t) < m`,
  without finite-generation or separability assumptions. These are
  single-form theorems, not simultaneous-zero statements. See
  [`NormForms.AlgebraicExtensionFormZeros`](NormForms/AlgebraicExtensionFormZeros.lean),
  [`NormForms.RatFuncFormZeros`](NormForms/RatFuncFormZeros.lean),
  [`NormForms.FiniteTranscendenceFormZeros`](NormForms/FiniteTranscendenceFormZeros.lean)
  and their [algebraic](docs/AlgebraicExtensionFormZeros.md),
  [rational-function](docs/RatFuncFormZeros.md) and
  [finite-transcendence](docs/FiniteTranscendenceFormZeros.md) guides.
- **Finite-field common zeros.** Over a finite field,
  `MvPolynomial.exists_ne_common_zero_of_sum_totalDegree_lt` returns a second
  common point distinct from a known one when the strict sum of **actual
  total degrees** is below the number of variables; homogeneity is not
  required. Positive, possibly different homogeneous *labels* with strict
  sum bound give a nonzero common point via
  `MvPolynomial.exists_nonzero_common_zero_of_sum_degrees_lt` and the
  single-form specialization
  `MvPolynomial.exists_nonzero_zero_of_isHomogeneous_of_degree_lt`.
  Zero and repeated forms and the empty family are allowed. A finite-base-
  field transcendence-degree example in the tests is **private**, not another
  public extension theorem. See
  [`NormForms.FiniteFieldFormZeros`](NormForms/FiniteFieldFormZeros.lean)
  and the [finite-field guide](docs/FiniteFieldFormZeros.md).
- **Tensor scalar-sum annihilation.** Over a finite field `K`, a nonzero
  `a : ι → K` makes `TensorPower.scalarSum (M := M) a` surjective. For `0 < s`,
  arbitrary prescribed tensors indexed by finite `τ`, and a
  finite-dimensional **target** `W = (TensorPower K s M) ⊗[K] N`,
  `TensorPower.exists_nonzero_scalarSumTensor_annihilates` finds one such `a`
  whose **actual tensor map** annihilates every tensor when
  `s * Fintype.card τ * Module.finrank K W < Fintype.card ι`. The source
  tensor space need not be finite-dimensional; no surjectivity of the
  tensor map, `s = 0` case or actual-total-degree-`s` equality is claimed.
  See [`NormForms.TensorScalarSumAnnihilation`](NormForms/TensorScalarSumAnnihilation.lean),
  [five public checked-use clients](NormFormsTests/TensorScalarSumAnnihilation.lean)
  and the [tensor guide](docs/TensorScalarShrinking.md).

## Using the library

Add this dependency to your project's `lakefile.toml`:

```toml
[[require]]
name = "norm-forms"
git = "https://github.com/FormalFrontier/norm-forms.git"
rev = "main"
```

Run `lake update` after adding or deliberately changing the dependency, and keep
its resolved `lake-manifest.json` with your project. Use a Lean toolchain and
mathlib revision compatible with this library's checked-in pins. For a
reproducible dependency, replace `"main"` with a full published commit hash, such
as `"c7724170d47f9ede86e8c318fc6e5311ab8d7192"`, then resolve and retain the manifest.
The moving branch name by itself does not fix a dependency version.

Import the complete library with:

```lean
import NormForms
```

The smaller imports and mathematical guides are listed below.

## Use and navigation

`NormForms.lean` reexports every production leaf. For a smaller import use,
for example, `import NormForms.Coordinate`,
`import NormForms.CommonZeroCompression`,
`import NormForms.FiniteFieldFormZeros` or
`import NormForms.TensorScalarSumAnnihilation`. The
[`docs/README.md`](docs/README.md) indexes all ten mathematical guides and
ordinary-import clients. [`docs/API.md`](docs/API.md) and the matching
[`docs/api-manifest.json`](docs/api-manifest.json) are a **historical six-module
coordinate-only snapshot**, not a census of the present 26-module library;
consult the linked source modules and guides for later declarations.
The [historical reproduction and source-only limits](docs/README.md#historical-snapshot-reproduction-and-limitations)
identify the exact older inputs and separate native data needed to check that snapshot.

These definitions are generally noncomputable; the library does not provide
an executable norm algorithm, every-degree anisotropic forms, reduced norms,
`C_i` theory or cohomological computations. Mathlib provides the underlying
field norm, characteristic polynomial and Chevalley–Warning divisibility;
the official `multivariate-polynomials` dependency supplies block iteration
and coefficient-evaluation infrastructure. The library's theorems, rather
than these dependencies' results, are described above.

### Building this repository

Use the repository-pinned Lean toolchain and exact revisions in
`lakefile.toml` and `lake-manifest.json`. Fetch the matching mathlib cache
**successfully before** building:

```sh
elan toolchain install "$(cat lean-toolchain)"
lake exe cache get
lake build NormForms NormFormsTests
```

The production root is `NormForms` and the client/test root is
`NormFormsTests`.

## Attribution and scope

Authors: **Formal Frontier Agents**. Original coordinate-norm definitions,
zero/scalar laws and signed-characteristic-coefficient norm-polynomial proofs
were first contributed by Beacon and adapted for this library; other project
contributors supplied the structural basis-change results, block iteration,
anisotropic forms, polynomial padding and compression, common-zero and
field-extension results, tensor theorem, client tests and mathematical guides.
These roles include distinct original authors, later assemblers, independent
reviewers and release editors; assembly or documentation work is not
mathematical authorship or independent review. Formalization was AI-assisted.
The project code is offered under [Apache-2.0](LICENSE); retain
applicable upstream licenses and contributor notices. The work draws on
classical norm-form mathematics; Neukirch, Schmidt and Wingberg,
*Cohomology of Number Fields*, Chapter VI, is background, not a reproduced
formal source or a claim of complete source formalization. Source-specific
correspondence and coverage are tracked separately from this reusable library.
