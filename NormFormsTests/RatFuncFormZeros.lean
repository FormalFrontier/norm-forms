/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

import NormForms.RatFuncFormZeros

set_option warningAsError true

namespace RatFuncFormZerosClient

open MvPolynomial

variable {k : Type*} [Field k]

example (r : ℕ)
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d m : ℕ) (hd : 0 < d) (hsize : d ^ (r + 1) < m)
    (f : MvPolynomial (Fin m) (RatFunc k)) (hf : f.IsHomogeneous d) :
    ∃ x : Fin m → RatFunc k, x ≠ 0 ∧ eval x f = 0 :=
  exists_nonzero_zero_ratFunc_of_single_form_bound r hsingle d m hd hsize f hf

example (r : ℕ)
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d : ℕ) (hd : 0 < d)
    (f : MvPolynomial (Fin (d ^ (r + 1) + 1)) (RatFunc k))
    (hf : f.IsHomogeneous d) :
    ∃ x : Fin (d ^ (r + 1) + 1) → RatFunc k, x ≠ 0 ∧ eval x f = 0 :=
  exists_nonzero_zero_ratFunc_of_single_form_bound r hsingle d _ hd
    (Nat.lt_succ_self _) f hf

example (r : ℕ)
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d m : ℕ) (hd : 0 < d) (hsize : d ^ (r + 1) < m) :
    ∃ x : Fin m → RatFunc k, x ≠ 0 ∧ eval x (0 : MvPolynomial (Fin m) (RatFunc k)) = 0 :=
  exists_nonzero_zero_ratFunc_of_single_form_bound r hsingle d m hd hsize 0
    (isHomogeneous_zero (Fin m) (RatFunc k) d)

example
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ (0 : ℕ) < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d : ℕ) (hd : 0 < d)
    (f : MvPolynomial (Fin (d + 1)) (RatFunc k)) (hf : f.IsHomogeneous d) :
    ∃ x : Fin (d + 1) → RatFunc k, x ≠ 0 ∧ eval x f = 0 := by
  apply exists_nonzero_zero_ratFunc_of_single_form_bound 0 hsingle d (d + 1) hd
  · simp
  · exact hf

end RatFuncFormZerosClient
