/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

public import NormForms.RatFuncFormZeros
public import NormForms.AlgebraicExtensionFormZeros
public import Mathlib.FieldTheory.FinTrdeg
public import Mathlib.RingTheory.AlgebraicIndependent.AlgebraicClosure
public import Mathlib.FieldTheory.RatFunc.AsPolynomial
public import Mathlib.Tactic

/-!
# Single-form zeros over extensions of finite transcendence degree

Uniform positive-degree homogeneous-form zero bounds ascend by the transcendence degree.
-/

set_option warningAsError true

namespace MvPolynomial

private theorem bound_of_ringEquiv {F E : Type*} [Field F] [Field E]
    (equiv : F ≃+* E) (s : ℕ)
    (hbound : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) F),
      0 < a → a ^ s < t → p.IsHomogeneous a →
        ∃ x : Fin t → F, x ≠ 0 ∧ eval x p = 0) :
    ∀ (a t : ℕ) (p : MvPolynomial (Fin t) E),
      0 < a → a ^ s < t → p.IsHomogeneous a →
        ∃ x : Fin t → E, x ≠ 0 ∧ eval x p = 0 := by
  intro a t p ha ht hp
  obtain ⟨point, hpoint, hzero⟩ :=
    hbound a t (map equiv.symm.toRingHom p) ha ht (hp.map equiv.symm.toRingHom)
  refine ⟨equiv ∘ point, ?_, ?_⟩
  · intro h
    apply hpoint
    funext index
    have hz := congrFun h index
    apply equiv.injective
    simpa only [Function.comp_apply, Pi.zero_apply, map_zero] using hz
  · have heval := map_eval equiv.toRingHom point (map equiv.symm.toRingHom p)
    rw [hzero, map_zero] at heval
    rw [map_map] at heval
    have hcomp : equiv.toRingHom.comp equiv.symm.toRingHom = RingHom.id E := by
      ext x
      exact equiv.apply_symm_apply x
    rw [hcomp, map_id] at heval
    change (0 : E) = eval (equiv ∘ point) p at heval
    exact heval.symm

private noncomputable def fieldTower {k K : Type*} [Field k] [Field K] [Algebra k K]
    {n : ℕ} (generators : Fin n → K) (index : ℕ) : IntermediateField k K :=
  IntermediateField.adjoin k (generators '' {j : Fin n | j.val < index})

private theorem fieldTower_zero {k K : Type*} [Field k] [Field K] [Algebra k K]
    {n : ℕ} (generators : Fin n → K) : fieldTower (k := k) generators 0 = ⊥ := by
  simp [fieldTower, IntermediateField.adjoin_empty]

private theorem prefix_succ {n : ℕ} (index : ℕ) (hindex : index < n) :
    ({j : Fin n | j.val < index} : Set (Fin n)) ∪ {⟨index, hindex⟩} =
      {j : Fin n | j.val < index + 1} := by
  ext j
  simp only [Set.mem_union, Set.mem_ofPred_eq, Set.mem_singleton_iff]
  constructor
  · rintro (hj | hj)
    · omega
    · subst j; exact Nat.lt_succ_self index
  · intro hj
    by_cases h : j.val < index
    · exact Or.inl h
    · right
      have heq : j.val = index := by omega
      exact Fin.ext heq

private theorem fieldTower_succ {k K : Type*} [Field k] [Field K] [Algebra k K]
    {n : ℕ} (generators : Fin n → K) (index : ℕ) (hindex : index < n) :
    (IntermediateField.adjoin (fieldTower (k := k) generators index)
      ({generators ⟨index, hindex⟩} : Set K)).restrictScalars k =
        fieldTower (k := k) generators (index + 1) := by
  rw [fieldTower, IntermediateField.adjoin_adjoin_left]
  change IntermediateField.adjoin k
    (generators '' {j : Fin n | j.val < index} ∪ {generators ⟨index, hindex⟩}) =
      IntermediateField.adjoin k (generators '' {j : Fin n | j.val < index + 1})
  rw [← Set.image_singleton, ← Set.image_union, prefix_succ]

private noncomputable def fieldTower_succ_equiv {k K : Type*}
    [Field k] [Field K] [Algebra k K] {n : ℕ}
    (generators : Fin n → K) (index : ℕ) (hindex : index < n) :
    (IntermediateField.adjoin (fieldTower (k := k) generators index)
      ({generators ⟨index, hindex⟩} : Set K)) ≃+*
        fieldTower (k := k) generators (index + 1) := by
  let source : IntermediateField (fieldTower (k := k) generators index) K :=
    IntermediateField.adjoin (fieldTower (k := k) generators index)
      ({generators ⟨index, hindex⟩} : Set K)
  let target : IntermediateField k K := fieldTower (k := k) generators (index + 1)
  have hsets : (source : Set K) = (target : Set K) := by
    have heq := fieldTower_succ (k := k) generators index hindex
    simpa only [source, target, IntermediateField.coe_restrictScalars] using
      congrArg (fun field : IntermediateField k K => (field : Set K)) heq
  have hsub : source.toSubfield = target.toSubfield := SetLike.coe_injective hsets
  exact RingEquiv.subfieldCongr hsub

public section

/-- A uniform bound for nonzero zeros of homogeneous forms passes to a field extension
of finite transcendence degree, increasing the natural exponent by that degree. -/
theorem exists_nonzero_zero_of_trdeg_eq_of_single_form_bound
    {k K : Type*} [Field k] [Field K] [Algebra k K]
    (r n : ℕ) (htrdeg : Algebra.trdeg k K = (n : Cardinal))
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d m : ℕ) (hd : 0 < d) (hsize : d ^ (r + n) < m)
    (f : MvPolynomial (Fin m) K) (hf : f.IsHomogeneous d) :
    ∃ x : Fin m → K, x ≠ 0 ∧ eval x f = 0 := by
  classical
  have : FinTrdeg k K := FinTrdeg.of_trdeg (by
    rw [htrdeg]
    exact Cardinal.natCast_lt_aleph0)
  obtain ⟨basis, hbasis⟩ := exists_finset_isTranscendenceBasis k K
  have hcard : basis.card = n := by
    have hc : (basis.card : Cardinal) = (n : Cardinal) := by
      simpa only [Cardinal.mk_fintype, Fintype.card_coe] using
        hbasis.cardinalMk_eq_trdeg.trans htrdeg
    exact Nat.cast_injective hc
  let enumeration : Fin n ≃ basis := (Finset.equivFinOfCardEq hcard).symm
  let generators : Fin n → K := fun index => (enumeration index : K)
  have hgenerators : IsTranscendenceBasis k generators := by
    exact hbasis.comp_equiv enumeration
  have hfinal : Algebra.IsAlgebraic (fieldTower (k := k) generators n) K := by
    have hset : generators '' {j : Fin n | j.val < n} = Set.range generators := by
      ext element
      simp only [Set.mem_image, Set.mem_ofPred_eq, Set.mem_range]
      constructor
      · rintro ⟨index, _, rfl⟩
        exact ⟨index, rfl⟩
      · rintro ⟨index, rfl⟩
        exact ⟨index, index.isLt, rfl⟩
    change Algebra.IsAlgebraic
      (IntermediateField.adjoin k (generators '' {j : Fin n | j.val < n})) K
    rw [hset]
    exact hgenerators.isAlgebraic_field
  have hstage : ∀ index : ℕ, index ≤ n →
      ∀ (a t : ℕ) (p : MvPolynomial (Fin t) (fieldTower (k := k) generators index)),
        0 < a → a ^ (r + index) < t → p.IsHomogeneous a →
          ∃ x : Fin t → fieldTower (k := k) generators index,
            x ≠ 0 ∧ eval x p = 0 := by
    intro index
    induction index with
    | zero =>
      have hbase : ∀ (a t : ℕ)
          (p : MvPolynomial (Fin t) (fieldTower (k := k) generators 0)),
          0 < a → a ^ r < t → p.IsHomogeneous a →
            ∃ x : Fin t → fieldTower (k := k) generators 0,
              x ≠ 0 ∧ eval x p = 0 := by
        rw [fieldTower_zero (k := k) generators]
        exact bound_of_ringEquiv (IntermediateField.botEquiv k K).toRingEquiv.symm
          r hsingle
      intro _ a t p ha hsize hp
      exact hbase a t p ha (by simpa using hsize) hp
    | succ index inductionHypothesis =>
      intro hle
      have hindex : index < n := by omega
      have hprevious := inductionHypothesis (by omega)
      have htranscendental :
          Transcendental (fieldTower (k := k) generators index)
            (generators ⟨index, hindex⟩) := by
        apply (IntermediateField.transcendental_adjoin_iff).2
        exact hgenerators.1.transcendental_adjoin (s := {j : Fin n | j.val < index})
          (by simp)
      let equivalentFields : RatFunc (fieldTower (k := k) generators index) ≃+*
          fieldTower (k := k) generators (index + 1) :=
        (RatFunc.algEquivOfTranscendental (generators ⟨index, hindex⟩)
          htranscendental).toRingEquiv.trans
            (fieldTower_succ_equiv (k := k) generators index hindex)
      have hrational : ∀ (a t : ℕ)
          (p : MvPolynomial (Fin t) (RatFunc (fieldTower (k := k) generators index))),
          0 < a → a ^ ((r + index) + 1) < t → p.IsHomogeneous a →
            ∃ x : Fin t → RatFunc (fieldTower (k := k) generators index),
              x ≠ 0 ∧ eval x p = 0 := by
        intro a t p ha hsize hp
        exact exists_nonzero_zero_ratFunc_of_single_form_bound
          (r + index) hprevious a t ha hsize p hp
      have hnext := bound_of_ringEquiv equivalentFields ((r + index) + 1) hrational
      intro a t p ha hsize hp
      exact hnext a t p ha (by simpa only [Nat.add_assoc] using hsize) hp
  have : Algebra.IsAlgebraic (fieldTower (k := k) generators n) K := hfinal
  exact exists_nonzero_zero_of_isAlgebraic_of_single_form_bound
    (r + n) (hstage n le_rfl) d m hd hsize f hf

end

end MvPolynomial
