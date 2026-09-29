/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

public import NormForms.AlgebraicExtensionFormZeros

/-!
# Ordinary-import clients for algebraic-extension homogeneous-form zeros
-/

set_option warningAsError true
set_option linter.style.haveILetI false

namespace AlgebraicExtensionFormZerosClient

open MvPolynomial

section Algebraic

variable {k K : Type*} [Field k] [Field K] [Algebra k K]
  [Algebra.IsAlgebraic k K]

example (r : ℕ)
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d n : ℕ) (hd : 0 < d) (hbound : d ^ r < n)
    (f : MvPolynomial (Fin n) K) (hf : f.IsHomogeneous d) :
    ∃ x : Fin n → K, x ≠ 0 ∧ eval x f = 0 :=
  exists_nonzero_zero_of_isAlgebraic_of_single_form_bound r hsingle d n hd hbound f hf

example (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ 0 < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d n : ℕ) (hd : 0 < d) (hbound : 1 < n)
    (f : MvPolynomial (Fin n) K) (hf : f.IsHomogeneous d) :
    ∃ x : Fin n → K, x ≠ 0 ∧ eval x f = 0 := by
  apply exists_nonzero_zero_of_isAlgebraic_of_single_form_bound 0 hsingle d n
    hd (by simpa using hbound) f hf

example (r n : ℕ)
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (hbound : 1 < n)
    (f : MvPolynomial (Fin n) K) (hf : f.IsHomogeneous 1) :
    ∃ x : Fin n → K, x ≠ 0 ∧ eval x f = 0 := by
  apply exists_nonzero_zero_of_isAlgebraic_of_single_form_bound r hsingle 1 n
    (by omega) (by simpa using hbound) f hf

example (r d n : ℕ)
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (hd : 0 < d) (hbound : d ^ r < n) :
    ∃ x : Fin n → K, x ≠ 0 ∧ eval x (0 : MvPolynomial (Fin n) K) = 0 := by
  exact exists_nonzero_zero_of_isAlgebraic_of_single_form_bound r hsingle d n
    hd hbound 0 (isHomogeneous_zero (Fin n) K d)

end Algebraic

section Finite

variable {k E : Type*} [Field k] [Field E] [Algebra k E]
  [FiniteDimensional k E]

example (r : ℕ)
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d n : ℕ) (hd : 0 < d) (hbound : d ^ r < n)
    (f : MvPolynomial (Fin n) E) (hf : f.IsHomogeneous d) :
    ∃ x : Fin n → E, x ≠ 0 ∧ eval x f = 0 := by
  letI : Algebra.IsAlgebraic k E := Algebra.IsAlgebraic.of_finite k E
  exact exists_nonzero_zero_of_isAlgebraic_of_single_form_bound r hsingle d n
    hd hbound f hf

end Finite

section Identity

variable {k : Type*} [Field k]

example (r : ℕ)
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d n : ℕ) (hd : 0 < d) (hbound : d ^ r < n)
    (f : MvPolynomial (Fin n) k) (hf : f.IsHomogeneous d) :
    ∃ x : Fin n → k, x ≠ 0 ∧ eval x f = 0 :=
  exists_nonzero_zero_of_isAlgebraic_of_single_form_bound r hsingle d n hd hbound f hf

end Identity

end AlgebraicExtensionFormZerosClient
