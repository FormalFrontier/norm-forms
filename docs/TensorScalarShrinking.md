# Scalar sums annihilating tensor powers

Import `NormForms.TensorScalarSumAnnihilation` or `NormForms`. Let `K` be a
finite field, `ι` a finite parameter type, `M` and `N` arbitrary `K`-modules,
and `s > 0`. The native linear map
`TensorPower.scalarSum (M := M) a : (ι → M) →ₗ[K] M` sends a tuple `v` to
`∑ i, a i • v i`. A nonzero coefficient function `a` makes this map
surjective; no finite-dimensionality assumption is required for that fact.

The map `TensorPower.scalarSumTensor (M := M) s a` is *actually*
`(PiTensorProduct.map (fun _ : Fin s => scalarSum a)).rTensor N`, from
`(TensorPower K s (ι → M)) ⊗[K] N` into
`W = (TensorPower K s M) ⊗[K] N`. Its argument can be any tensor, not only
a pure tensor. Given a finite family
`z : τ → (TensorPower K s (ι → M)) ⊗[K] N`, the theorem
`TensorPower.exists_nonzero_scalarSumTensor_annihilates` assumes only that
**`W` is finite-dimensional** and that

```text
s * Fintype.card τ * Module.finrank K W < Fintype.card ι.
```

It returns one `a ≠ 0` for which the scalar sum is surjective and
`scalarSumTensor s a (z j) = 0` for **every** `j : τ`. Neither a separate
dimension assumption on `M` or `N`, nor one on the source tensor space, is
required. This does *not* assert surjectivity of `scalarSumTensor`.

## Why the dimension bound works

The proof is multilinear **on the actual source tensors**: evaluation at `z`
postcomposes `PiTensorProduct.mapMultilinear` with
`LinearMap.rTensorHom N`, and a finite expansion expresses the image as a
sum indexed by `Fin s → ι`. The coefficient of each index tuple is the
product of its `s` parameters. Coordinates in a finite basis of `W` give
explicit multivariate polynomials, one per selected tensor and target-basis
coordinate. Polynomial evaluation agrees with the native tensor map. The
products of `s` variables are homogeneous with **label** `s`, even when
variables repeat or coefficients vanish or cancel: equality of that label
with the actual total degree is not assumed. The existing
`MvPolynomial.exists_nonzero_common_zero_of_sum_degrees_lt` in
`NormForms.FiniteFieldFormZeros` provides a nonzero common zero; basis
coordinates then recover zero tensors. No equality of polynomial functions
is used to infer polynomial equality over the finite field.

## Ordinary-import clients

[`NormFormsTests.TensorScalarSumAnnihilation`](../NormFormsTests/TensorScalarSumAnnihilation.lean)
contains **five public named checked-use theorems** in the
`TensorPowerScalarSumClient` namespace:

- `prescribed_native_tensors` applies the actual `PiTensorProduct.map` and
  `rTensor` map to arbitrary prescribed source tensors.
- `finite_factors` supplies finite-dimensionality of `W` from finite-dimensional
  factors `M` and `N`; the general theorem itself does not require this.
- `empty_family` still produces a nonzero coefficient function and surjective
  scalar sum when there are no equations and `Fintype.card ι > 0`.
- `zero_rank_target` only requires a nonempty parameter type when `W` has
  rank zero.
- `zero_tensor_target` realizes the zero-rank case with second factor
  `Fin 0 → K`, while keeping arbitrary prescribed source tensors.

The exponent condition cannot be dropped: the zeroth tensor power has an
identity-like map independent of `a`, and a prescribed nonzero target tensor
need not be annihilated. This library proves neither compatibility with a
commuting group action nor a direct-sum or eventual-rank shrinking theorem;
source-specific correspondence and coverage belong in source repositories.

## Reproduction and status

The 26-module destination code was accepted by Beacon and integrated into
protected `main` at `822416081cd75ebec2ba6f678f2afa61efb67b6a` on
2026-09-30 03:08:17 UTC, following independent exact-destination
mathematical/API/provenance review. Original destination native run 1257
successfully built both roots and audited all 160 origins (94 private),
with only `propext`, `Classical.choice` and `Quot.sound` as transitive axioms.
The Lean, roots, dependencies and checker inputs of this documentary release
candidate are unchanged; this run does not review the revised documentation
or metadata. The release candidate and separate public-lineage snapshot were
**unreviewed, unaccepted as releases and unpublished at preparation**.
The previously published 24-module official release is
`e41278ba08ea5c8b41cea90595f0f07db441e9a5`. These dated statements
describe preparation, not a prediction about later publication.

Use the repository-pinned Lean `v4.34.0-rc2`, mathlib
`83abb3e776bdefcbc447a1e44d0debe4010039e5` and exact official pinned
dependencies. Before any future compilation fetch the matching precompiled
mathlib cache successfully from this project root:

```sh
lake exe cache get
lake build NormForms NormFormsTests
```

At the earlier 2026-09-30 destination-branch preparation, this transfer was
**unreviewed, unaccepted and unreleased**. Its incubator donor had completed
independent review, original registered native checks, Beacon acceptance and
protected integration. That earlier account claimed no destination compilation
or complete transitive axiom audit; the later original destination run 1257
is described above. The historical [`API.md`](API.md)
and [`api-manifest.json`](api-manifest.json) are a six-module snapshot, not a
current API inventory or proof-integrity receipt. No selected-source coverage
or blanket third-party rights conclusion follows from this preparation.

The original mathematical proof, five public clients and donor guide were
contributed by worker-b Task
`hive-request-00add797a4e4cdad8e5f28cd39c5c9e328d31af5` (UID
`b1b582ac-fbe9-4d6f-87c3-2bdb59e3bc0a`), following the plan by worker-b
Task `hive-request-8f66e2ffaba94e90d48cf88c4ac68a030a2b55f2`
(UID `207a718a-58ed-4173-9cf4-2a742055193c`). This destination-only
transfer, adaptation of the guide and standard Apache-2.0/Authors headers
are by worker-b Task
`hive-request-cb505aca61504146437d8d0fb49ab3df386e720f` (UID
`65cfc1eb-360f-4671-8563-ac89ab8f2f35`), not the original author,
independent reviewer, responsible accepting maintainer or release approver.
This later documentary release preparation alone is by worker-b Task
`hive-request-a26a15a8d87bcf395ef6411066086698e7844cda` (UID
`7900c153-7f1d-436b-8511-26c7e8dbc50c`), not the mathematical
author, independent release reviewer or accepting maintainer.
