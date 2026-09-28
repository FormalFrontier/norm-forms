/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

import NormForms.CommonZeroCompression
public import Mathlib.Algebra.Field.ZMod

set_option warningAsError true
set_option linter.style.haveILetI false

namespace CommonZeroCompressionClient

private theorem zmod_two_not_isAlgClosed : ¬ IsAlgClosed (ZMod 2) := by
  intro h
  haveI : IsAlgClosed (ZMod 2) := h
  exact (Finite.not_infinite (inferInstance : Finite (ZMod 2))) inferInstance

example (K : Type*) [Field K] (hK : ¬ IsAlgClosed K)
    (f : Empty → MvPolynomial Empty K) :
    ∃ g : MvPolynomial Empty K,
      ∀ x : Empty → K, MvPolynomial.eval x g = 0 ↔
        ∀ i, MvPolynomial.eval x (f i) = 0 :=
  MvPolynomial.exists_common_zero_polynomial hK f

example {σ : Type*} :
    ∃ g : MvPolynomial σ (ZMod 2),
      ∀ x : σ → ZMod 2, MvPolynomial.eval x g = 0 ↔
        ∀ _i : Fin 3, MvPolynomial.eval x
          (1 : MvPolynomial σ (ZMod 2)) = 0 := by
  exact MvPolynomial.exists_common_zero_polynomial zmod_two_not_isAlgClosed
    (fun _ : Fin 3 => (1 : MvPolynomial σ (ZMod 2)))

example :
    ∃ (m : ℕ) (g : MvPolynomial Empty (ZMod 2)),
      Fintype.card (Fin 2) < m ∧ g.IsHomogeneous (0 * m) ∧
        ∀ x : Empty → ZMod 2, MvPolynomial.eval x g = 0 ↔
          ∀ _i : Fin 2, MvPolynomial.eval x
            (1 : MvPolynomial Empty (ZMod 2)) = 0 := by
  exact MvPolynomial.exists_homogeneous_common_zero_polynomial
    zmod_two_not_isAlgClosed (fun _ : Fin 2 => (1 : MvPolynomial Empty (ZMod 2))) 0
    (fun _ => MvPolynomial.isHomogeneous_one (σ := Empty) (R := ZMod 2))

example {σ : Type*} (K : Type*) [Field K] (hK : ¬ IsAlgClosed K) (d : ℕ) :
    ∃ (m : ℕ) (g : MvPolynomial σ K),
      Fintype.card (Fin 2) < m ∧ g.IsHomogeneous (d * m) ∧
        ∀ x : σ → K, MvPolynomial.eval x g = 0 ↔
          ∀ _i : Fin 2, MvPolynomial.eval x (0 : MvPolynomial σ K) = 0 := by
  exact MvPolynomial.exists_homogeneous_common_zero_polynomial hK
    (fun _ : Fin 2 => (0 : MvPolynomial σ K)) d
    (fun _ => MvPolynomial.isHomogeneous_zero (σ := σ) (R := K) d)

end CommonZeroCompressionClient
