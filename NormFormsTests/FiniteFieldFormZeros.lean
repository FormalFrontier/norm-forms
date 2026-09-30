/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

import NormForms.FiniteFieldFormZeros
import NormForms.FiniteTranscendenceFormZeros

set_option warningAsError true

namespace FiniteFieldFormZerosClient

open MvPolynomial

variable {k : Type*} [Field k] [Fintype k]

private theorem twoFormsDifferentLabels (m : ℕ) (hsize : 3 < m)
    (f : Fin 2 → MvPolynomial (Fin m) k)
    (hf : ∀ j, (f j).IsHomogeneous (if j = 0 then 1 else 2)) :
    ∃ x : Fin m → k, x ≠ 0 ∧ ∀ j, eval x (f j) = 0 := by
  have hlabels : (∑ j : Fin 2, if j = 0 then 1 else 2) < Fintype.card (Fin m) := by
    simpa [Fin.sum_univ_two] using hsize
  exact exists_nonzero_common_zero_of_sum_degrees_lt
    (fun j : Fin 2 => if j = 0 then 1 else 2)
    (by intro j; fin_cases j <;> decide) f hf hlabels

private theorem knownPoint (m : ℕ) (f : Fin 2 → MvPolynomial (Fin m) k)
    (hdegree : (∑ j, (f j).totalDegree) < m)
    (x₀ : Fin m → k) (hx₀ : ∀ j, eval x₀ (f j) = 0) :
    ∃ x : Fin m → k, x ≠ x₀ ∧ ∀ j, eval x (f j) = 0 :=
  exists_ne_common_zero_of_sum_totalDegree_lt f (by simpa using hdegree) x₀ hx₀

private theorem emptyFamily {σ : Type*} [Fintype σ] (hσ : 0 < Fintype.card σ)
    (x₀ : σ → k) : ∃ x : σ → k, x ≠ x₀ := by
  obtain ⟨x, hx, _⟩ := exists_ne_common_zero_of_sum_totalDegree_lt
    (f := fun i : Empty => i.elim) (by simpa using hσ) x₀ (by intro i; exact i.elim)
  exact ⟨x, hx⟩

private theorem zeroForm {σ : Type*} [Fintype σ] (hσ : 1 < Fintype.card σ) :
    ∃ x : σ → k, x ≠ 0 ∧ eval x (0 : MvPolynomial σ k) = 0 :=
  exists_nonzero_zero_of_isHomogeneous_of_degree_lt 1 (by decide) 0
    (isHomogeneous_zero σ k 1) hσ

variable {K : Type*} [Field K] [Algebra k K]

private theorem finiteTrdegExtension (n : ℕ) (htrdeg : Algebra.trdeg k K = (n : Cardinal))
    (d m : ℕ) (hd : 0 < d) (hsize : d ^ (1 + n) < m)
    (f : MvPolynomial (Fin m) K) (hf : f.IsHomogeneous d) :
    ∃ x : Fin m → K, x ≠ 0 ∧ eval x f = 0 := by
  apply exists_nonzero_zero_of_trdeg_eq_of_single_form_bound 1 n htrdeg
    (fun a t p ha hbound hp =>
      exists_nonzero_zero_of_isHomogeneous_of_degree_lt a ha p hp
        (by simpa only [pow_one, Fintype.card_fin] using hbound))
    d m hd hsize f hf

end FiniteFieldFormZerosClient
