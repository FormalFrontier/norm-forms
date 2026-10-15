/-
SPDX-License-Identifier: Apache-2.0
Authors: Formal Frontier Agents
-/
module

public import NormForms.SpectralNorm
public import Mathlib.FieldTheory.KummerPolynomial
public import Mathlib.NumberTheory.Padics.PadicNumbers
import Mathlib.Tactic.NormNum

/-!
# The ramified quadratic extension of the 5-adic numbers

The field `ℚ₅(√5)` is constructed as `AdjoinRoot (X² - 5)`. Its generator has
algebraic norm `-5` and spectral norm `√(1/5)`, strictly between zero and one.
The nonsquare calculation uses Mathlib's integer-valued 5-adic valuation, so the
field and degree do not depend on the norm-comparison theorem.

This is the standard ramified quadratic example of the finite-extension norm
formula. Mathlib supplies the `AdjoinRoot`, Kummer-polynomial, power-basis and
5-adic APIs used here.
-/

@[expose] public section

open Polynomial

namespace NormFormsTests.PadicFiveQuadratic

noncomputable section

instance : Fact (Nat.Prime 5) := ⟨Nat.prime_five⟩

/-- The polynomial defining the ramified quadratic extension of `ℚ₅`. -/
abbrev quadraticPolynomial : (ℚ_[5])[X] := X ^ 2 - C 5

private theorem quadraticPolynomial_irreducible : Irreducible quadraticPolynomial := by
  apply X_pow_sub_C_irreducible_of_prime Nat.prime_two
  intro b hb
  have h := congrArg Padic.valuation hb
  rw [Padic.valuation_pow,
    show (5 : ℚ_[5]) = ((5 : ℕ) : ℚ_[5]) by rfl, Padic.valuation_p] at h
  norm_num at h
  omega

instance : Fact (Irreducible quadraticPolynomial) :=
  ⟨quadraticPolynomial_irreducible⟩

/-- The standard field `ℚ₅(√5)`, represented by a polynomial quotient. -/
abbrev QuadraticExtension := AdjoinRoot quadraticPolynomial

instance : FiniteDimensional ℚ_[5] QuadraticExtension :=
  (AdjoinRoot.powerBasis quadraticPolynomial_irreducible.ne_zero).finite

/-- The class of `X`, a square root of `5` in `ℚ₅(√5)`. -/
abbrev quadraticGenerator : QuadraticExtension := AdjoinRoot.root quadraticPolynomial

private theorem quadraticPolynomial_monic : quadraticPolynomial.Monic :=
  monic_X_pow_sub_C _ (by norm_num)

/-- The ramified quadratic extension of `ℚ₅` has degree two. -/
theorem quadraticExtension_finrank : Module.finrank ℚ_[5] QuadraticExtension = 2 := by
  rw [(AdjoinRoot.powerBasis quadraticPolynomial_irreducible.ne_zero).finrank]
  exact natDegree_X_pow_sub_C

private theorem quadraticGenerator_minpoly :
    minpoly ℚ_[5] quadraticGenerator = quadraticPolynomial := by
  rw [AdjoinRoot.minpoly_root quadraticPolynomial_irreducible.ne_zero,
    quadraticPolynomial_monic.leadingCoeff, inv_one, map_one, mul_one]

/-- The algebraic norm of the chosen square root of `5` is `-5`. -/
theorem quadraticGenerator_norm :
    Algebra.norm ℚ_[5] quadraticGenerator = -5 := by
  have h := Algebra.PowerBasis.norm_gen_eq_coeff_zero_minpoly
    (AdjoinRoot.powerBasis quadraticPolynomial_irreducible.ne_zero)
  rw [AdjoinRoot.powerBasis_gen, AdjoinRoot.powerBasis_dim,
    quadraticGenerator_minpoly] at h
  simpa [quadraticPolynomial, coeff_X_pow] using h

/-- The generator of `ℚ₅(√5)` has spectral norm `√(1/5)`. -/
theorem quadraticGenerator_spectralNorm :
    spectralNorm ℚ_[5] QuadraticExtension quadraticGenerator = Real.sqrt (1 / 5) := by
  rw [spectralNorm.spectralNorm_eq_norm_coeff_zero_rpow,
    quadraticGenerator_minpoly]
  have hc : quadraticPolynomial.coeff 0 = (-5 : ℚ_[5]) := by
    norm_num [quadraticPolynomial, coeff_X_pow]
  rw [hc, norm_neg,
    show (5 : ℚ_[5]) = ((5 : ℕ) : ℚ_[5]) by rfl, Padic.norm_p,
    show quadraticPolynomial.natDegree = 2 from natDegree_X_pow_sub_C,
    Real.sqrt_eq_rpow]
  norm_num

-- The complete nonarchimedean base and the degree-two field extension are explicit.
example : CompleteSpace ℚ_[5] := inferInstance
example : IsUltrametricDist ℚ_[5] := inferInstance
example : Field QuadraticExtension := inferInstance

/-- The spectral norm of the quadratic generator lies strictly between zero and one. -/
theorem quadraticGenerator_spectralNorm_mem_Ioo :
    0 < spectralNorm ℚ_[5] QuadraticExtension quadraticGenerator ∧
      spectralNorm ℚ_[5] QuadraticExtension quadraticGenerator < 1 := by
  rw [quadraticGenerator_spectralNorm]
  constructor
  · positivity
  · exact (Real.sqrt_lt' (by norm_num)).mpr (by norm_num)

-- The comparison theorem applies without installing a norm on the extension.
/-- The field-norm comparison specializes to the ramified quadratic generator. -/
theorem quadraticGenerator_comparison : ‖Algebra.norm ℚ_[5] quadraticGenerator‖ =
    spectralNorm ℚ_[5] QuadraticExtension quadraticGenerator ^ 2 := by
  simpa only [quadraticExtension_finrank] using
    Algebra.norm_norm_eq_spectralNorm_pow_finrank (K := ℚ_[5]) quadraticGenerator

end

end NormFormsTests.PadicFiveQuadratic
