/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

public import NormForms
public import Mathlib.Algebra.MvPolynomial.Funext
public import Mathlib.RingTheory.Complex

/-!
# Coordinate norm-form clients

Seven named examples use the public `NormForms` root import to check singleton and
two-dimensional complex norms, reindexing, and arbitrary change of basis.
-/

set_option warningAsError true

namespace NormFormsTests

public section

open Module MvPolynomial NormForms

/-- A singleton rational basis gives the ordinary one-dimensional field norm. -/
theorem rational_singleton_norm : coordinateNorm (Basis.singleton Unit ℚ) (fun _ => 3) = 3 := by
  simp [coordinateNorm]

/-- The rational singleton norm form is the single coordinate variable. -/
theorem rational_singleton_polynomial :
    coordinateNormPolynomial (Basis.singleton Unit ℚ) = X () := by
  apply MvPolynomial.funext fun x => by
    rw [coordinateNormPolynomial_eval]
    simp [coordinateNorm]

/-- The standard complex norm form is the sum of two squares. -/
theorem complex_norm_polynomial :
    coordinateNormPolynomial Complex.basisOneI = X 0 ^ 2 + X 1 ^ 2 := by
  apply MvPolynomial.funext fun x => by
    rw [coordinateNormPolynomial_eval]
    simp [coordinateNorm, Algebra.norm_complex_apply, Complex.normSq_apply]
    ring

/-- Swapping a complex basis sends new coordinates to old coordinates in swap order. -/
theorem complex_swap_coordinates (x : Fin 2 → ℝ) :
    coordinateChange Complex.basisOneI
      (Complex.basisOneI.reindex (Equiv.swap 0 1)) x = x ∘ Equiv.swap 0 1 := by
  ext i
  fin_cases i <;> simp [coordinateChange]

/-- Reindexing the standard complex basis renames the polynomial variables. -/
theorem complex_reindex_polynomial :
    coordinateNormPolynomial (Complex.basisOneI.reindex (Equiv.swap 0 1)) =
      MvPolynomial.rename (Equiv.swap 0 1)
        (coordinateNormPolynomial Complex.basisOneI) :=
  coordinateNormPolynomial_reindex _ _

/-- Evaluating after an arbitrary complex basis change respects the norm. -/
theorem complex_changeBasis_eval (b : Basis (Fin 2) ℝ ℂ) (x : Fin 2 → ℝ) :
    MvPolynomial.eval (coordinateChange Complex.basisOneI b x)
      (coordinateNormPolynomial Complex.basisOneI) =
      MvPolynomial.eval x (coordinateNormPolynomial b) :=
  coordinateNormPolynomial_eval_coordinateChange _ _ _

/-- An arbitrary complex basis change is structural polynomial substitution. -/
theorem complex_changeBasis_polynomial (b : Basis (Fin 2) ℝ ℂ) :
    coordinateNormPolynomial b =
      MvPolynomial.bind₁ (coordinateChangePolynomial Complex.basisOneI b)
        (coordinateNormPolynomial Complex.basisOneI) :=
  coordinateNormPolynomial_changeBasis _ _

end

end NormFormsTests
