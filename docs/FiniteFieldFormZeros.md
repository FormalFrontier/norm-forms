# Common zeros of forms over finite fields

Import `NormForms.FiniteFieldFormZeros` (or `NormForms`) for three results in
the `MvPolynomial` namespace. Let `K` be a field with `[Fintype K]`, and let
`σ` and `ι` be finite types of variable and equation indices. There is no
public `CharP`, `DecidableEq`, field-size inequality, or nonzero-form premise.

## Results

- `MvPolynomial.exists_ne_common_zero_of_sum_totalDegree_lt` takes
  `f : ι → MvPolynomial σ K`, a known common zero `x₀ : σ → K`, and the
  **strict actual-total-degree sum**
  `∑ i, (f i).totalDegree < Fintype.card σ`. It gives another common zero
  `x ≠ x₀`. No homogeneity assumption is needed.
- `MvPolynomial.exists_nonzero_common_zero_of_sum_degrees_lt` takes positive,
  potentially different labels `d : ι → ℕ`, equations homogeneous with their
  respective labels, and `∑ i, d i < Fintype.card σ`. It gives a nonzero
  common zero. Each label bounds the actual total degree; zero forms may carry
  positive labels, and equality of label and actual degree is not assumed.
- `MvPolynomial.exists_nonzero_zero_of_isHomogeneous_of_degree_lt` is the
  one-form specialization: `0 < d`, `f.IsHomogeneous d`, and
  `d < Fintype.card σ` give a nonzero zero, even when `f = 0`.

The empty equation family is permitted: its sum is zero and the strict bound
requires at least one variable. Repeated forms are also permitted. For a known
point, mathlib's Chevalley–Warning theorem makes the number of common zeros
divisible by the prime characteristic; a unique common zero would make that
number one. For positive-label homogeneous equations the origin supplies the
known point, because every constant coefficient vanishes. This proves the
varying-label result by bounding actual degrees with the labels.

## Ordinary-import clients and extensions

[`NormFormsTests.FiniteFieldFormZeros`](../NormFormsTests/FiniteFieldFormZeros.lean)
contains five **private** named checked-use clients: two forms with different
labels, a specified common point, an empty family, a zero form, and a finite-
base-field extension. The last combines the finite-field single-form result
uniformly in positive degrees with the existing
`MvPolynomial.exists_nonzero_zero_of_trdeg_eq_of_single_form_bound` at exponent
`1`. For a finite base field `k`, a field extension `K/k` with
`Algebra.trdeg k K = (n : Cardinal)`, `0 < d`, and a degree-`d` homogeneous
form in `m` variables, `d ^ (1 + n) < m` gives a nonzero zero over `K`
**without an extra single-form premise**. This is a private use of the
[generic finite-transcendence theorem](FiniteTranscendenceFormZeros.md), not a
new public extension theorem. These results assert neither an equality/sharpness
case nor an arbitrary-field Lang theorem.

## Reproduction and status

Use the repository-pinned Lean `v4.34.0-rc2`, mathlib
`83abb3e776bdefcbc447a1e44d0debe4010039e5` and official pinned
dependencies. Fetch the matching precompiled mathlib cache successfully from
this project root **before** future compilation:

```sh
lake exe cache get
lake build NormForms NormFormsTests
```

At preparation on 2026-09-30 this destination transfer is unreviewed,
unaccepted and unreleased; the isolated donor's checks do not certify these
aggregate roots. The historical [`API.md`](API.md) and
[`api-manifest.json`](api-manifest.json) remain a six-module snapshot, not a
current API inventory or proof-integrity receipt. No selected-source coverage
is asserted. Original mathematical proof and five clients: Formal Frontier
worker-b Task `hive-request-9ca31ded7b7bb0dad24f583f3e2d24e5801c6559`
(UID `eda88ebc-c4b7-4570-8565-6d668be42130`). Separate destination
transfer, guide and licensed headers: worker-b Task
`hive-request-1608a48153c3e49c3e743e649953d894ed900e8e`
(UID `eb6b3ab3-b099-47b7-85b0-84c515c7ac7a`). Project license:
Apache-2.0; this credit makes no third-party rights claim.
