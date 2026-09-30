/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

public import NormForms.TensorScalarSumAnnihilation
import Mathlib.LinearAlgebra.PiTensorProduct.Finite
import Mathlib.RingTheory.TensorProduct.Finite

/-! Ordinary-import clients of scalar-sum annihilation for arbitrary selected tensors. -/

set_option warningAsError true

@[expose] public section

namespace TensorPowerScalarSumClient

open scoped TensorProduct

variable {K ι M N τ : Type*} [Field K] [Fintype K] [Fintype ι] [Fintype τ]
  [AddCommGroup M] [Module K M] [AddCommGroup N] [Module K N]

/-- The conclusion uses the actual tensor product map, not an evaluation on pure tensors. -/
theorem prescribed_native_tensors (s : ℕ)
    [FiniteDimensional K ((TensorPower K s M) ⊗[K] N)]
    (hs : 0 < s) (z : τ → (TensorPower K s (ι → M)) ⊗[K] N)
    (h : s * Fintype.card τ * Module.finrank K ((TensorPower K s M) ⊗[K] N) <
      Fintype.card ι) :
    ∃ a : ι → K, a ≠ 0 ∧ Function.Surjective (TensorPower.scalarSum (M := M) a) ∧
      ∀ j : τ,
        ((PiTensorProduct.map (fun _ : Fin s => TensorPower.scalarSum (M := M) a)).rTensor N)
          (z j) = 0 :=
  TensorPower.exists_nonzero_scalarSumTensor_annihilates s hs z h

/-- Finite-dimensional factors give the standard convenient special case. -/
theorem finite_factors (s : ℕ) [FiniteDimensional K M] [FiniteDimensional K N]
    (hs : 0 < s) (z : τ → (TensorPower K s (ι → M)) ⊗[K] N)
    (h : s * Fintype.card τ * Module.finrank K ((TensorPower K s M) ⊗[K] N) <
      Fintype.card ι) :
    ∃ a : ι → K, a ≠ 0 ∧ Function.Surjective (TensorPower.scalarSum (M := M) a) ∧
      ∀ j : τ, TensorPower.scalarSumTensor (M := M) s a (z j) = 0 := by
  have : FiniteDimensional K (TensorPower K s M) := inferInstance
  have : FiniteDimensional K ((TensorPower K s M) ⊗[K] N) := inferInstance
  exact TensorPower.exists_nonzero_scalarSumTensor_annihilates s hs z h

/-- The empty equation family still yields a nonzero, surjective scalar sum. -/
theorem empty_family (s : ℕ) [FiniteDimensional K ((TensorPower K s M) ⊗[K] N)]
    (hs : 0 < s) (hι : 0 < Fintype.card ι)
    (z : Fin 0 → (TensorPower K s (ι → M)) ⊗[K] N) :
    ∃ a : ι → K, a ≠ 0 ∧ Function.Surjective (TensorPower.scalarSum (M := M) a) ∧
      ∀ j : Fin 0, TensorPower.scalarSumTensor (M := M) s a (z j) = 0 := by
  have h : s * Fintype.card (Fin 0) *
      Module.finrank K ((TensorPower K s M) ⊗[K] N) < Fintype.card ι := by
    simpa using hι
  exact TensorPower.exists_nonzero_scalarSumTensor_annihilates s hs z h

/-- When the tensor target has rank zero, the strict bound only needs one parameter. -/
theorem zero_rank_target (s : ℕ)
    [FiniteDimensional K ((TensorPower K s M) ⊗[K] N)]
    (hs : 0 < s) (hzero : Module.finrank K ((TensorPower K s M) ⊗[K] N) = 0)
    (hι : 0 < Fintype.card ι)
    (z : τ → (TensorPower K s (ι → M)) ⊗[K] N) :
    ∃ a : ι → K, a ≠ 0 ∧ Function.Surjective (TensorPower.scalarSum (M := M) a) ∧
      ∀ j : τ, TensorPower.scalarSumTensor (M := M) s a (z j) = 0 := by
  apply TensorPower.exists_nonzero_scalarSumTensor_annihilates s hs z
  simpa [hzero] using hι

/-- A zero second tensor factor supplies a concrete zero-rank target, with
arbitrary prescribed tensors in the source. -/
theorem zero_tensor_target (s : ℕ) (hs : 0 < s) (hι : 0 < Fintype.card ι)
    (z : τ → (TensorPower K s (ι → M)) ⊗[K] (Fin 0 → K)) :
    ∃ a : ι → K, a ≠ 0 ∧ Function.Surjective (TensorPower.scalarSum (M := M) a) ∧
      ∀ j : τ, TensorPower.scalarSumTensor (M := M) s a (z j) = 0 := by
  have : FiniteDimensional K ((TensorPower K s M) ⊗[K] (Fin 0 → K)) := inferInstance
  apply zero_rank_target s hs (Module.finrank_zero_of_subsingleton) hι z

end TensorPowerScalarSumClient

end
