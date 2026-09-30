/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

public import Mathlib.FieldTheory.ChevalleyWarning
public import Mathlib.RingTheory.MvPolynomial.Homogeneous

/-!
# Common zeros of forms over finite fields

Chevalley–Warning gives a second zero of a finite polynomial system whenever a
first zero is known and the sum of the actual total degrees is smaller than the
number of variables. Positive-degree homogeneous equations supply the known zero
at the origin, even when some of the forms are zero.
-/

set_option warningAsError true
set_option linter.style.haveILetI false
set_option maxHeartbeats 200000

public section

namespace MvPolynomial

variable {K σ ι : Type*} [Field K] [Fintype K] [Fintype σ] [Fintype ι]

/-- A common zero is not unique when the sum of the actual total degrees is
strictly smaller than the number of variables. The equations need not be
homogeneous and the indexing type may be empty. -/
theorem exists_ne_common_zero_of_sum_totalDegree_lt
    (f : ι → MvPolynomial σ K)
    (hdegree : (∑ i, (f i).totalDegree) < Fintype.card σ)
    (x₀ : σ → K) (hx₀ : ∀ i, eval x₀ (f i) = 0) :
    ∃ x : σ → K, x ≠ x₀ ∧ ∀ i, eval x (f i) = 0 := by
  classical
  obtain ⟨p, hp⟩ := CharP.exists K
  letI : CharP K p := hp
  have hchar : p ∣
      Fintype.card {x : σ → K // ∀ i, eval x (f i) = 0} :=
    @char_dvd_card_solutions_of_fintype_sum_lt K σ ι _ _ _
      (Classical.decEq σ) (Classical.decEq K) p hp _ f hdegree
  have hprime : p.Prime := CharP.char_is_prime K p
  by_contra hnone
  push Not at hnone
  letI : Unique {x : σ → K // ∀ i, eval x (f i) = 0} :=
    { default := ⟨x₀, hx₀⟩
      uniq := by
        rintro ⟨x, hx⟩
        apply Subtype.ext
        by_contra hneq
        obtain ⟨i, hnonzero⟩ := hnone x hneq
        exact hnonzero (hx i) }
  exact hprime.not_dvd_one (by simpa only [Fintype.card_unique] using hchar)

/-- A finite family of homogeneous forms with *positive, possibly different*
degree labels has a nonzero common zero if the sum of the labels is smaller
than the number of variables. The labels only bound the actual degrees: zero
forms and an empty family are permitted. -/
theorem exists_nonzero_common_zero_of_sum_degrees_lt
    (d : ι → ℕ) (hd : ∀ i, 0 < d i) (f : ι → MvPolynomial σ K)
    (hf : ∀ i, (f i).IsHomogeneous (d i))
    (hdegree : (∑ i, d i) < Fintype.card σ) :
    ∃ x : σ → K, x ≠ 0 ∧ ∀ i, eval x (f i) = 0 := by
  classical
  have hsum : (∑ i, (f i).totalDegree) < Fintype.card σ :=
    lt_of_le_of_lt (Finset.sum_le_sum (fun i _ => (hf i).totalDegree_le)) hdegree
  have horigin : ∀ i, eval (0 : σ → K) (f i) = 0 := by
    intro i
    have hconst : (f i).coeff 0 = 0 := by
      exact (hf i).coeff_eq_zero (by simpa using (hd i).ne'.symm)
    simpa only [eval_zero, constantCoeff_eq] using hconst
  exact exists_ne_common_zero_of_sum_totalDegree_lt f hsum 0 horigin

/-- A positive-degree homogeneous form in more variables than its degree
has a nonzero zero over any finite field, including when the form is zero. -/
theorem exists_nonzero_zero_of_isHomogeneous_of_degree_lt
    (d : ℕ) (hd : 0 < d) (f : MvPolynomial σ K)
    (hf : f.IsHomogeneous d) (hdegree : d < Fintype.card σ) :
    ∃ x : σ → K, x ≠ 0 ∧ eval x f = 0 := by
  have hsum : (∑ _ : Unit, d) < Fintype.card σ := by simpa using hdegree
  obtain ⟨x, hx, hzero⟩ :=
    exists_nonzero_common_zero_of_sum_degrees_lt
      (ι := Unit) (fun _ => d) (fun _ => hd) (fun _ => f)
      (fun _ => hf) hsum
  exact ⟨x, hx, hzero ()⟩

end MvPolynomial

end
