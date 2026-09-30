/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

import NormForms.PaddedSubstitution
import Mathlib.Data.ZMod.Basic

/-!
# Direct-import clients for zero-padded substitution

These examples use the public leaf without importing the compression theorem.
-/

set_option warningAsError true

namespace PaddedSubstitutionClient

universe u v w z

variable {ι : Type u} {κ : Type v} {σ : Type w}
  {R : Type z} [CommSemiring R]

example (j : ι ↪ κ) (f : ι → MvPolynomial σ R)
    (p : MvPolynomial κ R)
    (hp : ∀ y : κ → R, MvPolynomial.eval y p = 0 → y = 0)
    (x : σ → R) :
    MvPolynomial.eval x
      (MvPolynomial.aeval (Function.extend j f (fun _ => 0)) p) = 0 →
        ∀ i, MvPolynomial.eval x (f i) = 0 :=
  MvPolynomial.eval_aeval_pad_eq_zero_imp j f p hp x

example (j : ℕ ↪ ℕ) (f : ℕ → MvPolynomial σ ℕ)
    (p : MvPolynomial ℕ ℕ)
    (hp : ∀ y : ℕ → ℕ, MvPolynomial.eval y p = 0 ↔ y = 0)
    (x : σ → ℕ) :
    MvPolynomial.eval x
      (MvPolynomial.aeval (Function.extend j f (fun _ => 0)) p) = 0 ↔
        ∀ i, MvPolynomial.eval x (f i) = 0 :=
  MvPolynomial.eval_aeval_pad_eq_zero_iff j f p hp x

example (j : ι ↪ κ) (f : ι → MvPolynomial σ R)
    (p : MvPolynomial κ R) (e d : ℕ)
    (hp : p.IsHomogeneous e) (hf : ∀ i, (f i).IsHomogeneous d) :
    (MvPolynomial.aeval (Function.extend j f (fun _ => 0)) p).IsHomogeneous
      (d * e) :=
  hp.aeval_pad j f hf

example (j : Empty ↪ κ) (f : Empty → MvPolynomial σ R)
    (p : MvPolynomial κ R) (hp : p.IsHomogeneous 0) :
    (MvPolynomial.aeval (Function.extend j f (fun _ => 0)) p).IsHomogeneous
      (0 * 0) :=
  hp.aeval_pad j f (fun i => i.elim)

example (j : Empty ↪ Empty) (f : Empty → MvPolynomial Empty (ZMod 1))
    (p : MvPolynomial Empty (ZMod 1)) (x : Empty → ZMod 1) :
    MvPolynomial.eval x
      (MvPolynomial.aeval (Function.extend j f (fun _ => 0)) p) = 0 ↔
        ∀ i, MvPolynomial.eval x (f i) = 0 := by
  apply MvPolynomial.eval_aeval_pad_eq_zero_iff j f p
  intro y
  constructor
  · intro _
    exact Subsingleton.elim _ _
  · intro _
    exact Subsingleton.elim _ _

end PaddedSubstitutionClient
