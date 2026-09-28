/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

public import NormForms.CoordinateNormIteration
import Mathlib.RingTheory.MvPolynomial.Homogeneous
import Mathlib.Algebra.MvPolynomial.Monad

/-!
# Compressing finite polynomial zero sets

Over a field that is not algebraically closed, the common zeros of any finite
family of multivariate polynomials at coefficient-field points are the zeros of
a single polynomial. A homogeneous family of degree `d` admits a homogeneous
compressing polynomial of degree `d * m` for some `m` exceeding its size.
-/

set_option warningAsError true

namespace MvPolynomial

universe u v w

variable {K : Type u} [Field K] {ι : Type v} [Fintype ι] {σ : Type w}

private theorem anisotropic_padding (hK : ¬ IsAlgClosed K) :
    ∃ (m : ℕ) (form : MvPolynomial (Fin m) K) (_inclusion : ι ↪ Fin m),
      Fintype.card ι < m ∧ form.IsHomogeneous m ∧
        ∀ values : Fin m → K, eval values form = 0 ↔ values = 0 := by
  obtain ⟨m, form, hcard, hhom, _, hzero⟩ :=
    exists_anisotropic_homogeneous_of_not_isAlgClosed K hK (Fintype.card ι)
  obtain ⟨inclusion⟩ : Nonempty (ι ↪ Fin m) :=
    Function.Embedding.nonempty_of_card_le (by simpa using hcard.le)
  exact ⟨m, form, inclusion, hcard, hhom, hzero⟩

private theorem eval_aeval_pad_eq_zero_iff (f : ι → MvPolynomial σ K)
    (inclusion : ι ↪ Fin m) (form : MvPolynomial (Fin m) K)
    (hform : ∀ values : Fin m → K, eval values form = 0 ↔ values = 0)
    (x : σ → K) :
    eval x (aeval (Function.extend inclusion f (fun _ => 0)) form) = 0 ↔
      ∀ i, eval x (f i) = 0 := by
  let padded := Function.extend (inclusion : ι → Fin m) f (fun _ => 0)
  have heval : eval x (aeval padded form) =
      eval (fun j => eval x (padded j)) form := by
    calc
      eval x (aeval padded form) = aeval x (bind₁ padded form) := by
        simp only [aeval_eq_eval, aeval_eq_bind₁]
      _ = aeval (fun j => aeval x (padded j)) form := aeval_bind₁ x padded form
      _ = eval (fun j => eval x (padded j)) form := by simp only [aeval_eq_eval]
  have hpadded : (fun j => eval x (padded j)) = 0 ↔
      ∀ i, eval x (f i) = 0 := by
    constructor
    · intro hz i
      have hi := congrFun hz (inclusion i)
      simpa only [Pi.zero_apply, padded, inclusion.injective.extend_apply] using hi
    · intro hz
      funext j
      by_cases hj : ∃ i, inclusion i = j
      · obtain ⟨i, rfl⟩ := hj
        simpa only [Pi.zero_apply, padded, inclusion.injective.extend_apply] using hz i
      · simp [padded, Function.extend_apply' _ _ _ hj]
  rw [heval, hform]
  exact hpadded

public section

/-- A finite system of polynomial equations over a non-algebraically-closed field
has the same coefficient-field solutions as one polynomial equation. -/
theorem exists_common_zero_polynomial (hK : ¬ IsAlgClosed K)
    (f : ι → MvPolynomial σ K) :
    ∃ g : MvPolynomial σ K,
      ∀ x : σ → K, eval x g = 0 ↔ ∀ i, eval x (f i) = 0 := by
  classical
  obtain ⟨m, form, inclusion, _, _, hzero⟩ := anisotropic_padding (ι := ι) hK
  exact ⟨aeval (Function.extend inclusion f (fun _ => 0)) form,
    eval_aeval_pad_eq_zero_iff f inclusion form hzero⟩

/-- A finite system of homogeneous equations of common degree `d` has one
homogeneous defining equation of degree `d * m` at coefficient-field points,
where `m` exceeds the number of equations. -/
theorem exists_homogeneous_common_zero_polynomial (hK : ¬ IsAlgClosed K)
    (f : ι → MvPolynomial σ K) (d : ℕ)
    (hf : ∀ i, (f i).IsHomogeneous d) :
    ∃ (m : ℕ) (g : MvPolynomial σ K),
      Fintype.card ι < m ∧ g.IsHomogeneous (d * m) ∧
        ∀ x : σ → K, eval x g = 0 ↔ ∀ i, eval x (f i) = 0 := by
  classical
  obtain ⟨m, form, inclusion, hcard, hhom, hzero⟩ := anisotropic_padding (ι := ι) hK
  let padded := Function.extend (inclusion : ι → Fin m) f (fun _ => 0)
  have hpad (j : Fin m) : (padded j).IsHomogeneous d := by
    by_cases hj : ∃ i, inclusion i = j
    · obtain ⟨i, rfl⟩ := hj
      simpa only [padded, inclusion.injective.extend_apply] using hf i
    · simpa only [padded, Function.extend_apply' _ _ _ hj] using
        (isHomogeneous_zero (σ := σ) (R := K) d)
  refine ⟨m, aeval padded form, hcard, hhom.aeval padded hpad, ?_⟩
  exact eval_aeval_pad_eq_zero_iff f inclusion form hzero

end

end MvPolynomial
