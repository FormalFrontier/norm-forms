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

## Reproduction and credit

The tensor theorem and five public ordinary-import clients were contributed
as original Formal Frontier mathematics, then adapted into this library.
Original mathematical authorship, destination assembly, independent review
and documentation editing are distinct roles. The current code contains the
result; these commands are reproduction instructions, not acceptance evidence
for changed documentation:

```sh
lake exe cache get
lake build NormForms NormFormsTests
```

Fetch the matching cache successfully before building with the toolchain and
exact dependencies pinned in the root Lake files. [`API.md`](API.md) and
[`api-manifest.json`](api-manifest.json) remain historical six-module snapshots,
not the tensor API or a proof audit.
