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

These are *attained* degrees `n ^ r`, not every prescribed or sufficiently
large degree. This API does not add a `C_i` classification or a general
finite-extension wrapper. Beacon contributed the original coordinate-norm
mathematics; other Formal Frontier contributors supplied block substitution,
finite iteration and the anisotropic-form composition. Their original work,
later assembly and independent review are distinct roles. The official
`multivariate-polynomials` dependency provides block iteration. Consult the
repository pins in `lakefile.toml` and `lake-manifest.json`; fetch the matching
mathlib cache before building.
