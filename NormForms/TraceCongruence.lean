/-
SPDX-License-Identifier: Apache-2.0
Authors: Formal Frontier Agents
-/
module

public import Mathlib.RingTheory.Norm.Defs
public import Mathlib.RingTheory.Trace.Defs
public import Mathlib.RingTheory.Ideal.Maps
import Mathlib.Algebra.Polynomial.Eval.Degree

/-!
# First-order norm–trace congruence

The norm of `1 + x` agrees with `1 + trace x` modulo the square of any base
ideal whose extension contains `x`.

The proof uses Mathlib's characteristic-polynomial ideal-power bound and its
norm and trace comparisons with the matrix of left multiplication. The matrix
argument evaluates the characteristic polynomial of the negative matrix at one;
its top two coefficients are one and the trace.

## References

The source motivation is the unramified norm–trace theory in Fesenko and
Vostokov, *Local Fields and Their Extensions*. The proof uses Mathlib's
norm/trace formalization by Anne Baanen, its characteristic-polynomial
coefficient theory by Aaron Anderson, Jalex Stark and Slava Naprienko,
characteristic-polynomial evaluation by Kim Morrison, polynomial evaluation by
Chris Hughes, Johannes Hölzl, Kim Morrison and Jens Wagemaker, and ideal
operations by Kenny Lau.
-/

@[expose] public section

universe u v w

open Module

private theorem linearMap_mem_ideal_of_mem_map
    {R : Type u} {S : Type v} [CommRing R] [CommRing S] [Algebra R S]
    (I : Ideal R) (f : S →ₗ[R] R) {x : S}
    (hx : x ∈ I.map (algebraMap R S)) : f x ∈ I := by
  have hx' : x ∈ I • (⊤ : Submodule R S) := by
    rw [Ideal.smul_top_eq_map]
    exact hx
  have hle : I • (⊤ : Submodule R S) ≤ Submodule.comap f I := by
    apply Submodule.smul_le.mpr
    intro r hr s _
    change f (r • s) ∈ I
    rw [f.map_smul, smul_eq_mul]
    exact I.mul_mem_right (f s) hr
  exact hle hx'

private theorem det_one_add_sub_one_sub_trace_mem_ideal_sq
    {R : Type u} [CommRing R] {n : Type w} [Fintype n] [DecidableEq n]
    (I : Ideal R) (M : Matrix n n R) (hM : ∀ i j, M i j ∈ I) :
    (1 + M).det - 1 - M.trace ∈ I ^ 2 := by
  classical
  nontriviality R
  by_cases hn : Fintype.card n = 0
  · have : IsEmpty n := Fintype.card_eq_zero_iff.mp hn
    simp [Matrix.trace]
  · have : Nonempty n := Fintype.card_pos_iff.mp (Nat.pos_of_ne_zero hn)
    obtain ⟨m, hm⟩ := Nat.exists_eq_succ_of_ne_zero hn
    have hdegree : (-M).charpoly.natDegree = m + 1 := by
      rw [Matrix.charpoly_natDegree_eq_dim, hm]
    have htop : (-M).charpoly.coeff (m + 1) = 1 := by
      rw [← hdegree]
      exact (-M).charpoly_monic.coeff_natDegree
    have htrace : (-M).charpoly.coeff m = M.trace := by
      have h := Matrix.trace_eq_neg_charpoly_coeff (-M)
      rw [hm, Nat.succ_sub_one] at h
      simpa using (congrArg Neg.neg h).symm
    have heval : (1 + M).det =
        ∑ k ∈ Finset.range (m + 2), (-M).charpoly.coeff k := by
      have h := Polynomial.eval_eq_sum_range (p := (-M).charpoly) (1 : R)
      rw [Matrix.eval_charpoly] at h
      simpa [hdegree] using h
    have hsum : ∑ k ∈ Finset.range m, (-M).charpoly.coeff k ∈ I ^ 2 := by
      apply Submodule.sum_mem
      intro k hk
      apply Ideal.pow_le_pow_right (show 2 ≤ Fintype.card n - k by
        rw [hm]
        have := Finset.mem_range.mp hk
        omega)
      exact Matrix.coeff_charpoly_mem_ideal_pow (fun i j ↦ I.neg_mem (hM i j)) k
    rw [heval, show m + 2 = (m + 1) + 1 from rfl,
      Finset.sum_range_succ, Finset.sum_range_succ, htop, htrace]
    simpa using hsum

namespace Algebra

/-- The norm agrees to first order with one plus the trace along any extended ideal.
For finite-free algebras this uses the usual norm and trace. If there is no finite
basis, Mathlib's norm is one and its trace is zero, so the remainder is zero. -/
public theorem norm_one_add_sub_one_sub_trace_mem_ideal_sq
    {R : Type u} {S : Type v} [CommRing R] [CommRing S] [Algebra R S]
    (I : Ideal R) {x : S} (hx : x ∈ I.map (algebraMap R S)) :
    Algebra.norm R (1 + x) - 1 - Algebra.trace R S x ∈ I ^ 2 := by
  classical
  by_cases h : ∃ s : Finset S, Nonempty (Basis s R S)
  · obtain ⟨s, ⟨b⟩⟩ := h
    rw [Algebra.norm_eq_matrix_det b, Algebra.trace_eq_matrix_trace b,
      map_add, map_one]
    apply det_one_add_sub_one_sub_trace_mem_ideal_sq
    intro i j
    let f : S →ₗ[R] R :=
      { toFun := fun y ↦ Algebra.leftMulMatrix b y i j
        map_add' := by intro y z; simp
        map_smul' := by intro r y; simp }
    exact linearMap_mem_ideal_of_mem_map I f hx
  · rw [Algebra.norm_eq_one_of_not_exists_basis R h,
      Algebra.trace_eq_zero_of_not_exists_basis R h]
    simp

end Algebra
