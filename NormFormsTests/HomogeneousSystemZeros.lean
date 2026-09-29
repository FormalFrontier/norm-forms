/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

import NormForms.HomogeneousSystemZeros

/-! Ordinary-import clients for the direct all-degree premise and boundary families. -/

set_option warningAsError true

open MvPolynomial

section

variable {K : Type*} [Field K] (r : ℕ)
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) K),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → K, x ≠ 0 ∧ eval x p = 0)

example (d s n : ℕ) (hd : 0 < d) (hsize : s * d ^ r < n)
    (f : Fin s → MvPolynomial (Fin n) K)
    (hf : ∀ i, (f i).IsHomogeneous d) :
    ∃ x : Fin n → K, x ≠ 0 ∧ ∀ i, eval x (f i) = 0 :=
  exists_nonzero_common_zero_of_single_form_bound r hsingle d s n hd hsize f hf

example (d n : ℕ) (hd : 0 < d) (hn : 0 < n) :
    ∃ x : Fin n → K, x ≠ 0 ∧
      ∀ _ : Fin 0, eval x (0 : MvPolynomial (Fin n) K) = 0 := by
  apply exists_nonzero_common_zero_of_single_form_bound r hsingle d 0 n hd
    (by simpa using hn) (fun _ => 0)
  exact fun i => i.elim0

example (d s n : ℕ) (hd : 0 < d) (hsize : s * d ^ r < n) :
    ∃ x : Fin n → K, x ≠ 0 ∧
      ∀ _ : Fin s, eval x (0 : MvPolynomial (Fin n) K) = 0 := by
  apply exists_nonzero_common_zero_of_single_form_bound r hsingle d s n hd hsize
    (fun _ => 0)
  intro _
  exact isHomogeneous_zero (σ := Fin n) (R := K) d

example (d n : ℕ) (hd : 0 < d) (hsize : 2 * d ^ r < n)
    (p : MvPolynomial (Fin n) K) (hp : p.IsHomogeneous d) :
    ∃ x : Fin n → K, x ≠ 0 ∧ ∀ _ : Fin 2, eval x p = 0 :=
  exists_nonzero_common_zero_of_single_form_bound r hsingle d 2 n hd hsize
    (fun _ => p) (fun _ => hp)

end

example {K : Type*} [Field K]
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) K),
      0 < a → a ^ 0 < t → p.IsHomogeneous a →
        ∃ x : Fin t → K, x ≠ 0 ∧ eval x p = 0)
    (d s n : ℕ) (hd : 0 < d) (hsize : s < n)
    (f : Fin s → MvPolynomial (Fin n) K)
    (hf : ∀ i, (f i).IsHomogeneous d) :
    ∃ x : Fin n → K, x ≠ 0 ∧ ∀ i, eval x (f i) = 0 :=
  exists_nonzero_common_zero_of_single_form_bound 0 hsingle d s n hd
    (by simpa using hsize) f hf

example {K : Type*} [Field K] (r s n : ℕ)
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) K),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → K, x ≠ 0 ∧ eval x p = 0)
    (hsize : s < n) (f : Fin s → MvPolynomial (Fin n) K)
    (hf : ∀ i, (f i).IsHomogeneous 1) :
    ∃ x : Fin n → K, x ≠ 0 ∧ ∀ i, eval x (f i) = 0 :=
  exists_nonzero_common_zero_of_single_form_bound r hsingle 1 s n (by omega)
    (by simpa using hsize) f hf
