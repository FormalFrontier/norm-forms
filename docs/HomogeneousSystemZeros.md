# Common nontrivial zeros of homogeneous systems

Import `NormForms.HomogeneousSystemZeros` (or `NormForms`) for
`MvPolynomial.exists_nonzero_common_zero_of_single_form_bound`. For **any**
field `K` and `r : ℕ`, supply the following direct premise uniformly over
**every positive degree** `a` and arity `t`:

```lean
∀ (a t : ℕ) (p : MvPolynomial (Fin t) K),
  0 < a → a ^ r < t → p.IsHomogeneous a →
    ∃ x : Fin t → K, x ≠ 0 ∧ MvPolynomial.eval x p = 0
```

For `d s n : ℕ`, `0 < d`, `s * d ^ r < n`, and
`f : Fin s → MvPolynomial (Fin n) K` satisfying
`∀ i, (f i).IsHomogeneous d`, the theorem concludes:

```lean
∃ x : Fin n → K, x ≠ 0 ∧
  ∀ i, MvPolynomial.eval x (f i) = 0
```

The strict inequality is on `s * d ^ r`, not a rounded degree bound.
`IsHomogeneous d` is a *label*, not an assertion of exact total degree;
the equations need not be nonzero or distinct. The empty family (`s = 0`),
zero or repeated equations, `r = 0` and `d = 1` are supported. The premise
remains uniformly quantified even when these boundary clients use only its
special cases; no field-invariant predicate or finiteness, perfection,
characteristic or separability condition is imposed. See the ordinary-import
examples in `NormFormsTests.HomogeneousSystemZeros` (also built by
`NormFormsTests`).

## Mathematical route

For an empty system, a nonzero coordinate vector supplies the result. For
nonempty systems over an algebraically closed field, the imported
`AlgebraicGroups.Algebra.AlgebraicallyClosedCommonZero` theorem applies since
the size bound gives `s < n`. Otherwise, suppose the equations have no
nonzero common zero. `NormForms.CoordinateNormIteration` supplies a fixed
attained-degree homogeneous form with only the origin as a zero, in sufficiently
many variables and without assuming every prescribed degree is attained.
Each iteration substitutes copies of all `s` equations in fresh blocks of
`n` variables into that form, setting unused outer slots to zero.
`NormForms.PaddedSubstitution` transfers homogeneity and the implication
that a zero of the substituted form forces each block to vanish.

If the starting arity and label are `e`, the iterative arity satisfies
`N₀ = e`, `Nₘ₊₁ = n * (Nₘ / s)` (natural division), while the labels are
`Dₘ = d ^ m * e`. The published
`Nat.DivisionGrowth.eventually_dominates`, imported from
`SequenceGrowth.Data.Nat.DivisionGrowth`, gives a
stage with `Nₘ > Dₘ ^ r` from `s * d ^ r < n` and the chosen seed
threshold. The single-form premise then supplies a nonzero zero of that
stage, contradicting the transferred zero condition. The block-construction
helper is private; the statement introduces no new public helper.

This is distinct from `NormForms.CommonZeroCompression`: that theorem
compresses a finite polynomial system to one polynomial with the **same
coefficient-field zero set** over a non-algebraically-closed field. Here
the all-positive-degree single-form premise and strict numerical bound
produce a **nonzero common zero** over any field. Neither theorem asserts
the other's conclusion or a claim about all extension-field points.

The dependency graph uses Lean `v4.34.0-rc2`, mathlib at
`83abb3e776bdefcbc447a1e44d0debe4010039e5`, and the official
`MultivariatePolynomials` `ec4906268f2a65a54e320ce9f3f44562e9d78c1e`,
`AlgebraicGroups` `6c7f4a5a38881573fd2bb735fc3dab1de53b83bf`, and
`SequenceGrowth` `c5c4dbfafc3a6b3fdc8c6ab9f3d336ae893d4f79`
releases. These published inputs and the pre-existing accepted mathematical
implementation do not themselves certify this destination's changed graph:
at construction on 2026-09-29, exact-destination build/axiom evidence,
independent review, maintainer acceptance and this contribution's release
were separate subsequent steps. This date-specific note does not assert
their later outcomes or any selected-source coverage.
