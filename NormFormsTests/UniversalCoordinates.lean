/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

import NormForms.UniversalCoordinates
import Mathlib.Data.ZMod.Basic

set_option warningAsError true

open Module MvPolynomial
open scoped TensorProduct

private theorem arbitraryAlgebra_client
    {R B A ι : Type*} [CommRing R] [Ring B] [Algebra R B]
    [CommRing A] [Algebra R A] [Fintype ι] [DecidableEq ι]
    [Module.Free R B] [Module.Finite R B]
    (b : Basis ι R B) (x : ι → A) :
    Algebra.norm A (∑ i, x i ⊗ₜ[R] b i : A ⊗[R] B) =
      aeval x (C ((-1 : R) ^ Module.finrank R B) *
        (LinearMap.polyCharpoly (Algebra.lmul R B).toLinearMap b).coeff 0) :=
  (Algebra.norm_coordinates_baseChange b x).symm

private theorem universalPolynomial_client
    {R B ι : Type*} [CommRing R] [Ring B] [Algebra R B]
    [Fintype ι] [DecidableEq ι] [Module.Free R B] [Module.Finite R B]
    (b : Basis ι R B) :
    Algebra.norm (MvPolynomial ι R)
        (∑ i, X i ⊗ₜ[R] b i : MvPolynomial ι R ⊗[R] B) =
      C ((-1 : R) ^ Module.finrank R B) *
        (LinearMap.polyCharpoly (Algebra.lmul R B).toLinearMap b).coeff 0 :=
  (Algebra.norm_universalCoordinates b).symm

private theorem finiteField_client (b : Basis (Fin 1) (ZMod 2) (ZMod 2))
    (x : Fin 1 → ZMod 2) :
    aeval x (C ((-1 : ZMod 2) ^ Module.finrank (ZMod 2) (ZMod 2)) *
      (LinearMap.polyCharpoly (Algebra.lmul (ZMod 2) (ZMod 2)).toLinearMap b).coeff 0) =
        Algebra.norm (ZMod 2)
          (∑ i, x i ⊗ₜ[ZMod 2] b i : ZMod 2 ⊗[ZMod 2] ZMod 2) :=
  Algebra.norm_coordinates_baseChange b x

private theorem trivialAlgebra_client (b : Basis (Fin 1) ℤ ℤ)
    (x : Fin 1 → ZMod 1) :
    aeval x (C ((-1 : ℤ) ^ Module.finrank ℤ ℤ) *
      (LinearMap.polyCharpoly (Algebra.lmul ℤ ℤ).toLinearMap b).coeff 0) =
        Algebra.norm (ZMod 1)
          (∑ i, x i ⊗ₜ[ℤ] b i : ZMod 1 ⊗[ℤ] ℤ) :=
  Algebra.norm_coordinates_baseChange b x

private theorem trivialAlgebra_value (b : Basis (Fin 1) ℤ ℤ)
    (x : Fin 1 → ZMod 1) :
    Algebra.norm (ZMod 1)
      (∑ i, x i ⊗ₜ[ℤ] b i : ZMod 1 ⊗[ℤ] ℤ) = 0 := by
  rw [← trivialAlgebra_client b x]
  exact Subsingleton.elim _ _
