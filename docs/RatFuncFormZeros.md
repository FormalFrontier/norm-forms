# Homogeneous-form zeros over rational-function fields

Import `NormForms.RatFuncFormZeros` (or the aggregate `NormForms`) for
`MvPolynomial.exists_nonzero_zero_ratFunc_of_single_form_bound`. Fix an arbitrary
field `k` and `r : ℕ`. The theorem assumes a **direct single-form premise** over
`k`, uniform in every positive degree `a`, every arity `t` and every
homogeneous-label-`a` form:

```lean
∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
  0 < a → a ^ r < t → p.IsHomogeneous a →
    ∃ x : Fin t → k, x ≠ 0 ∧ MvPolynomial.eval x p = 0
```

For `0 < d` and the **strict** bound `d ^ (r + 1) < m`, each
`f : MvPolynomial (Fin m) (RatFunc k)` labelled homogeneous of degree `d`
has a nonzero zero:

```lean
∃ x : Fin m → RatFunc k, x ≠ 0 ∧ MvPolynomial.eval x f = 0
```

With `open MvPolynomial`, the direct call is

```lean
obtain ⟨x, hx, hfx⟩ :=
  exists_nonzero_zero_ratFunc_of_single_form_bound r hsingle d m hd hsize f hf
```

The label `IsHomogeneous d` does not assert that `f` has exact nonzero total
degree: the zero form is included. No assumption that `k` is infinite is
needed; finite fields, `r = 0` and the minimal permitted arity
`m = d ^ (r + 1) + 1` are covered. The four ordinary-import examples in
[`NormFormsTests.RatFuncFormZeros`](../NormFormsTests/RatFuncFormZeros.lean)
exercise the general theorem, minimal arity, zero form and `r = 0`; they
introduce no additional public theorem.

## Proof outline

The proof uses finite support to multiply the coefficients of `f` by a single
nonzero common polynomial denominator, obtaining a homogeneous form over
`k[X]`. Represent each prospective rational-function coordinate by a
polynomial whose coefficients are independent parameters over `k`. Substitute
these polynomials into the cleared form and interchange the polynomial and
multivariate-polynomial coefficient structures. This produces **actual
polynomial coefficient equations** over `k` for the vanishing of the
substituted expression, rather than equations checked only at evaluations.
They share homogeneous label `d` and have a finite degree bound.

Applying the existing equal-degree-system common-zero theorem
`MvPolynomial.exists_nonzero_common_zero_of_single_form_bound` from
`NormForms.HomogeneousSystemZeros` gives a nonzero assignment to the
coefficient parameters. With the proof's finite polynomial degree bound
`B`, it chooses polynomial-coordinate degree bound `s = (B + 1) * d ^ r`.
There are `(B + d * s + 1)` coefficient equations and
`m * (s + 1)` coefficient variables. The hypothesis
`d ^ (r + 1) < m` makes
`(B + d * s + 1) * d ^ r < m * (s + 1)`, the required system bound.
At least one reconstructed polynomial coordinate is nonzero; embedding
these coordinates into `RatFunc k` preserves nonzeroness. Vanishing of all
the coefficient polynomials gives a zero of the cleared form, and the
common denominator is nonzero, recovering a zero of `f`.

The denominator clearing and coefficient-parameter lemmas are private
implementation details. The public theorem is
`MvPolynomial.exists_nonzero_zero_ratFunc_of_single_form_bound`; its public
premise is supplied by the caller, not proved here. In particular this
result does not assert simultaneous zeros over `RatFunc k` or a converse or
sharpness of its strict bound.

## Build and ordinary clients

Use this repository's pinned Lean toolchain and official dependencies:

```sh
lake exe cache get
lake build NormForms NormFormsTests
```

The cache command must succeed before the build. To check the direct client
within the same project after fetching the cache, use
`lake build NormFormsTests.RatFuncFormZeros`. Ordinary imports of
`NormForms.RatFuncFormZeros` expose the theorem without importing tests or
the private proof helpers.
