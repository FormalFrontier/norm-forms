/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

public import NormForms.Coordinate
public import Mathlib.Algebra.Field.ZMod

/-!
# Direct coordinate API clients

These clients import the coordinate module directly (not the root). The identity
extension of `ZMod 2` supplies a nonvacuous finite field; reindexing its singleton
basis from `Unit` to `ULift.{1} (Fin 1)` exercises unequal index types in
different universes and structural
polynomial substitution without relying on finite-field evaluation extensionality.
-/

set_option warningAsError true

namespace NormFormsTests

public section

open Module MvPolynomial NormForms

/-- Evaluating the one-dimensional norm on the nonzero point over a finite field. -/
theorem finite_identity_norm_one :
    coordinateNorm (Basis.singleton Unit (ZMod 2)) (fun _ => 1) = 1 := by
  simp [coordinateNorm]

/-- The direct API evaluates the finite-field polynomial in new basis coordinates. -/
theorem finite_unequal_indices_eval (x : ULift.{1} (Fin 1) → ZMod 2) :
    MvPolynomial.eval x
        (coordinateNormPolynomial
          ((Basis.singleton Unit (ZMod 2)).reindex
            (Equiv.ofUnique Unit (ULift.{1} (Fin 1))))) =
      coordinateNorm
        ((Basis.singleton Unit (ZMod 2)).reindex
          (Equiv.ofUnique Unit (ULift.{1} (Fin 1)))) x :=
  coordinateNormPolynomial_eval _ _

/-- The direct API renames polynomial variables across distinct index types. -/
theorem finite_unequal_indices_rename :
    coordinateNormPolynomial
        ((Basis.singleton Unit (ZMod 2)).reindex
          (Equiv.ofUnique Unit (ULift.{1} (Fin 1)))) =
      MvPolynomial.rename (Equiv.ofUnique Unit (ULift.{1} (Fin 1)))
        (coordinateNormPolynomial (Basis.singleton Unit (ZMod 2))) :=
  coordinateNormPolynomial_reindex _ _

/-- A finite-field basis change is equality of polynomials by structural substitution. -/
theorem finite_unequal_indices_substitution :
    coordinateNormPolynomial
        ((Basis.singleton Unit (ZMod 2)).reindex
          (Equiv.ofUnique Unit (ULift.{1} (Fin 1)))) =
      MvPolynomial.bind₁
        (coordinateChangePolynomial (Basis.singleton Unit (ZMod 2))
          ((Basis.singleton Unit (ZMod 2)).reindex
            (Equiv.ofUnique Unit (ULift.{1} (Fin 1)))))
        (coordinateNormPolynomial (Basis.singleton Unit (ZMod 2))) :=
  coordinateNormPolynomial_changeBasis _ _

end

end NormFormsTests
