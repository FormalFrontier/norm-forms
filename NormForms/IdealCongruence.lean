/-
SPDX-License-Identifier: Apache-2.0
Authors: Formal Frontier Agents
-/
module

public import Mathlib.RingTheory.Ideal.Maps
public import Mathlib.RingTheory.Norm.Defs
import Mathlib.Algebra.Module.LinearMap.Polynomial
import Mathlib.LinearAlgebra.Charpoly.BaseChange
import Mathlib.RingTheory.Ideal.Quotient.Defs

/-!
# Norm congruences for finite free commutative algebras

The regular norm of a finite free commutative algebra preserves congruence modulo
an extended ideal. The proof uses Mathlib's coordinate polynomial for the
characteristic polynomial of left multiplication: its signed constant coefficient
evaluates to the norm, and polynomial evaluation preserves coordinate congruence.
-/

@[expose] public section

universe u v

namespace Algebra

variable {R : Type u} {S : Type v} [CommRing R] [CommRing S] [Algebra R S]
  [Module.Free R S] [Module.Finite R S]

/-- The regular norm preserves congruence modulo the extension of an ideal of
the base ring in a finite free commutative algebra. -/
theorem norm_sub_norm_mem_ideal (I : Ideal R) {x y : S}
    (h : x - y ∈ I.map (algebraMap R S)) :
    Algebra.norm R x - Algebra.norm R y ∈ I := by
  classical
  cases subsingleton_or_nontrivial R with
  | inl hR =>
    let : Subsingleton R := hR
    have hzero : Algebra.norm R x - Algebra.norm R y = 0 := Subsingleton.elim _ _
    rw [hzero]
    exact I.zero_mem
  | inr hR =>
    let : Nontrivial R := hR
    let ι := Module.Free.ChooseBasisIndex R S
    let b : Module.Basis ι R S := Module.Free.chooseBasis R S
    let p : MvPolynomial ι R :=
      MvPolynomial.C ((-1 : R) ^ Module.finrank R S) *
        (LinearMap.polyCharpoly (Algebra.lmul R S).toLinearMap b).coeff 0
    have hnorm (z : S) :
        MvPolynomial.aeval (fun i => b.repr z i) p = Algebra.norm R z := by
      dsimp only [p]
      rw [map_mul, MvPolynomial.aeval_C, Algebra.norm_apply,
        LinearMap.det_eq_sign_charpoly_coeff]
      change (-1 : R) ^ Module.finrank R S *
          MvPolynomial.eval (b.repr z)
            ((LinearMap.polyCharpoly (Algebra.lmul R S).toLinearMap b).coeff 0) =
        (-1 : R) ^ Module.finrank R S *
          ((Algebra.lmul R S).toLinearMap z).charpoly.coeff 0
      rw [LinearMap.polyCharpoly_coeff_eval]
    have hsmul : x - y ∈ I • (⊤ : Submodule R S) := by
      rw [Ideal.smul_top_eq_map]
      exact (Submodule.restrictScalars_mem R (I.map (algebraMap R S)) (x - y)).2 h
    have hcoord (i : ι) : b.repr x i - b.repr y i ∈ I := by
      have hci : b.coord i (x - y) ∈ I • (⊤ : Submodule R R) :=
        (Submodule.smul_top_le_comap_smul_top I (b.coord i)) hsmul
      change b.coord i (x - y) ∈ I • (⊤ : Ideal R) at hci
      rw [Ideal.smul_eq_mul, Ideal.mul_top, map_sub] at hci
      change b.repr x i - b.repr y i ∈ I at hci
      exact hci
    let q : R →+* R ⧸ I := Ideal.Quotient.mk I
    have hqcoord : (fun i : ι => q (b.repr x i)) =
        (fun i : ι => q (b.repr y i)) := by
      funext i
      exact (Ideal.Quotient.eq (I := I)).2 (hcoord i)
    apply (Ideal.Quotient.eq (I := I)).1
    change q (Algebra.norm R x) = q (Algebra.norm R y)
    rw [← hnorm x, ← hnorm y, MvPolynomial.map_aeval, MvPolynomial.map_aeval]
    exact MvPolynomial.eval₂Hom_congr rfl hqcoord rfl

end Algebra
