# Homogeneous-form zeros over algebraic field extensions

Import `NormForms.AlgebraicExtensionFormZeros` (or the aggregate `NormForms`)
for `MvPolynomial.exists_nonzero_zero_of_isAlgebraic_of_single_form_bound`.
For fields `k`, `K` with `[Algebra k K]` and `[Algebra.IsAlgebraic k K]`,
fix `r : ℕ` and assume the following **direct premise over the base field**,
uniformly for *every* positive degree `a` and every eligible arity `t`:

```lean
∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
  0 < a → a ^ r < t → p.IsHomogeneous a →
    ∃ x : Fin t → k, x ≠ 0 ∧ MvPolynomial.eval x p = 0
```

Then for `d n : ℕ`, `0 < d`, the **strict** bound `d ^ r < n`, and any
`f : MvPolynomial (Fin n) K` with `f.IsHomogeneous d`, the theorem gives

```lean
∃ x : Fin n → K, x ≠ 0 ∧ MvPolynomial.eval x f = 0
```

With `open MvPolynomial`, the direct theorem call is:

```lean
obtain ⟨x, hx, hfx⟩ :=
  exists_nonzero_zero_of_isAlgebraic_of_single_form_bound r hsingle d n hd hbound f hf
```

`IsHomogeneous d` is a homogeneous **label**, not an exact nonzero total-degree
assertion: in particular, the zero form is allowed. The six ordinary-import
examples in [`NormFormsTests.AlgebraicExtensionFormZeros`](../NormFormsTests/AlgebraicExtensionFormZeros.lean)
exercise the general algebraic extension, a finite extension (which supplies
algebraicity), and the identity extension, as well as `r = 0`, `d = 1`, and
the zero polynomial. They retain the uniform all-positive-degree base-field
premise rather than inferring it from these boundary cases.

## Construction and dependencies

In the finite-dimensional case, choose a basis `b` of `K` over `k`, substitute
each extension-field variable with its linear combination of basis coordinates,
and take the **additive linear** coefficient map for each basis coordinate.
These coefficient maps are not ring homomorphisms. The imported
`MultivariatePolynomials.LinearCoefficientEvaluation` identifies evaluation
of each coordinate polynomial at a base-field point with the corresponding
basis coordinate of the substituted form's evaluation. The public
`NormForms.HomogeneousSystemZeros` theorem gives a common nonzero coordinate
point from the bound `t * d ^ r < n * t`, where `t` is the positive basis size;
the basis turns it into a nonzero extension-field zero.

For a general algebraic extension, the finitely many coefficients of `f`
generate a finite-dimensional intermediate field. Lift `f` coefficientwise
to that field, retaining its homogeneous label; apply the finite-dimensional
argument and transport the **constructed zero forward** through the injective
field inclusion. This does *not* descend arbitrary zeros over `K`.
The finite-extension helper remains private; only the displayed transfer theorem
is added to the public API. Its direct external module dependencies are the
official `MultivariatePolynomials.LinearCoefficientEvaluation` (from
`multivariate-polynomials` at `6a04276766ad82d60702b24deb9a559a30a80007`)
and `NormForms.HomogeneousSystemZeros`, alongside the pinned mathlib field,
basis, and polynomial APIs. The repository additionally declares official
`algebraic-groups` and `sequence-growth` dependencies used by the homogeneous-
system module. Consult `lakefile.toml` and `lake-manifest.json` for all pins.

The theorem assumes neither finite, separable nor perfect extensions; it does
not assume `f ≠ 0` or `r > 0`. It defines no least-field-dimension invariant
or `C_i` wrapper and proves no transcendental/Tsen or general differing-degree
extension theorem. For a fresh checkout with the pinned Lean toolchain, fetch
the matching mathlib cache successfully **before** building both roots:

```sh
elan toolchain install "$(cat lean-toolchain)"
lake exe cache get
LEAN_NUM_THREADS=2 lake --wfail build NormForms NormFormsTests
```

These are reproduction commands, not a claim that this contribution has
already passed the destination build, axiom audit or independent review.
