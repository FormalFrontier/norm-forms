/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

import NormForms.CoordinateNormIteration
import Mathlib.Algebra.Field.ZMod

set_option warningAsError true
set_option linter.style.haveILetI false

private instance : Fact (Nat.Prime 2) := ⟨by decide⟩

private theorem zmodTwo_not_isAlgClosed : ¬ IsAlgClosed (ZMod 2) := by
  intro h
  letI : IsAlgClosed (ZMod 2) := h
  exact Fintype.false (inferInstance : Fintype (ZMod 2))

example : ∃ (d : ℕ) (p : MvPolynomial (Fin d) (ZMod 2)),
    100 < d ∧ p.IsHomogeneous d ∧ p.totalDegree = d ∧
      ∀ x : Fin d → ZMod 2, MvPolynomial.eval x p = 0 ↔ x = 0 :=
  MvPolynomial.exists_anisotropic_homogeneous_of_not_isAlgClosed
    (ZMod 2) zmodTwo_not_isAlgClosed 100

example : ∃ (d : ℕ) (p : MvPolynomial (Fin d) (ZMod 2)),
    100 < d ∧ p.totalDegree = d ∧
      ∀ x : Fin d → ZMod 2, MvPolynomial.eval x p = 0 → x = 0 := by
  obtain ⟨d, p, hbound, _, hdegree, hzero⟩ :=
    MvPolynomial.exists_anisotropic_homogeneous_of_not_isAlgClosed
      (ZMod 2) zmodTwo_not_isAlgClosed 100
  exact ⟨d, p, hbound, hdegree, fun x => (hzero x).mp⟩
