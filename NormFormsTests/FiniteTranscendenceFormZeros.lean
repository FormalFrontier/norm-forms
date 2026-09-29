/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

import NormForms.FiniteTranscendenceFormZeros

set_option warningAsError true

namespace FiniteTranscendenceFormZerosClient

open MvPolynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

example (r n : ℕ) (htrdeg : Algebra.trdeg k K = (n : Cardinal))
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d m : ℕ) (hd : 0 < d) (hsize : d ^ (r + n) < m)
    (f : MvPolynomial (Fin m) K) (hf : f.IsHomogeneous d) :
    ∃ x : Fin m → K, x ≠ 0 ∧ eval x f = 0 :=
  exists_nonzero_zero_of_trdeg_eq_of_single_form_bound
    r n htrdeg hsingle d m hd hsize f hf

example (r n : ℕ) (htrdeg : Algebra.trdeg k K = (n : Cardinal))
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d : ℕ) (hd : 0 < d)
    (f : MvPolynomial (Fin (d ^ (r + n) + 1)) K) (hf : f.IsHomogeneous d) :
    ∃ x : Fin (d ^ (r + n) + 1) → K, x ≠ 0 ∧ eval x f = 0 :=
  exists_nonzero_zero_of_trdeg_eq_of_single_form_bound
    r n htrdeg hsingle d _ hd (Nat.lt_succ_self _) f hf

example (r n : ℕ) (htrdeg : Algebra.trdeg k K = (n : Cardinal))
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d m : ℕ) (hd : 0 < d) (hsize : d ^ (r + n) < m) :
    ∃ x : Fin m → K, x ≠ 0 ∧ eval x (0 : MvPolynomial (Fin m) K) = 0 :=
  exists_nonzero_zero_of_trdeg_eq_of_single_form_bound
    r n htrdeg hsingle d m hd hsize 0 (isHomogeneous_zero (Fin m) K d)

example (r : ℕ) (htrdeg : Algebra.trdeg k K = (0 : Cardinal))
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ r < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (d : ℕ) (hd : 0 < d)
    (f : MvPolynomial (Fin (d ^ r + 1)) K) (hf : f.IsHomogeneous d) :
    ∃ x : Fin (d ^ r + 1) → K, x ≠ 0 ∧ eval x f = 0 := by
  apply exists_nonzero_zero_of_trdeg_eq_of_single_form_bound r 0 htrdeg hsingle
    d (d ^ r + 1) hd
  · exact Nat.lt_succ_self (d ^ r)
  · exact hf

example (n : ℕ) (htrdeg : Algebra.trdeg k K = (n : Cardinal))
    (hsingle : ∀ (a t : ℕ) (p : MvPolynomial (Fin t) k),
      0 < a → a ^ (0 : ℕ) < t → p.IsHomogeneous a →
        ∃ x : Fin t → k, x ≠ 0 ∧ eval x p = 0)
    (f : MvPolynomial (Fin 2) K) (hf : f.IsHomogeneous 1) :
    ∃ x : Fin 2 → K, x ≠ 0 ∧ eval x f = 0 := by
  apply exists_nonzero_zero_of_trdeg_eq_of_single_form_bound 0 n htrdeg hsingle
    1 2 (by decide)
  · simp
  · exact hf

end FiniteTranscendenceFormZerosClient
