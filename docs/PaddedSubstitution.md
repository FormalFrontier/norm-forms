# Zero-padded substitution of a fixed polynomial

Import `NormForms.PaddedSubstitution` (or `NormForms`). Let `ι`, `κ` and `σ`
be arbitrary index types, `R` a commutative semiring,
`j : ι ↪ κ`, `f : ι → MvPolynomial σ R`, and
`p : MvPolynomial κ R`. The library uses the existing expression

```lean
MvPolynomial.aeval (Function.extend j f (fun _ => 0)) p
```

which substitutes `f i` at `j i` and zero elsewhere. There is no new
polynomial operation or finiteness requirement. The following laws are public:

- `MvPolynomial.eval_aeval_pad_eq_zero_imp j f p h x`: if
  `h : ∀ y : κ → R, MvPolynomial.eval y p = 0 → y = 0`, then
  `MvPolynomial.eval x (MvPolynomial.aeval (Function.extend j f (fun _ => 0)) p) = 0`
  implies `∀ i, MvPolynomial.eval x (f i) = 0`.
- `MvPolynomial.eval_aeval_pad_eq_zero_iff j f p h x`: if the outer zero
  condition instead is
  `h : ∀ y : κ → R, MvPolynomial.eval y p = 0 ↔ y = 0`, then the same
  two inner conditions are equivalent.
- `hp.aeval_pad j f hf`, for `hp : p.IsHomogeneous e` and
  `hf : ∀ i, (f i).IsHomogeneous d`, proves
  `(MvPolynomial.aeval (Function.extend j f (fun _ => 0)) p).IsHomogeneous (d * e)`.

To see the evaluation laws, evaluate the substituted polynomial at `x` using
mathlib's `aeval_bind₁`: the outer variable `k` receives
`MvPolynomial.eval x (Function.extend j f (fun _ => 0) k)`.
If this coordinate function is zero, so are all evaluations of `f i`.
Conversely, if all the `f i` vanish, it is zero at embedded and padded
coordinates. The reverse implication then needs `eval 0 p = 0`, supplied by
the outer **iff**, not by its forward half. For example, over `ℕ` the
constant outer polynomial `1` satisfies the forward zero condition
vacuously but does not vanish at zero; substituting an all-zero family
cannot yield the reverse implication.

For homogeneity, each embedded coordinate has degree `d` by `hf`, while
zero is homogeneous in **every** degree at unused coordinates. Mathlib's
`IsHomogeneous.aeval` then gives degree `d * e`. No nonzero conclusion or
exact-total-degree equality is implied, including at degree zero or over
the trivial semiring. Neither zero-set law asserts equality of ideals,
radicals, schemes or zero sets over all coefficient extensions.

The ordinary-import client `NormFormsTests.PaddedSubstitution` exercises
arbitrary semirings and index types, a *conditional* infinite-index law over
`ℕ` (not existence of an outer anisotropic polynomial), an empty family,
degree zero, and `ZMod 1`. The field/finitely indexed compression
application uses these laws in `NormForms.CommonZeroCompression`; see the
[compression guide](PolynomialCommonZeroCompression.md).

The original padding expression was contributed with the common-zero
compression work; later Formal Frontier contributors extracted these
independent public laws and adapted the client. The original contribution,
subsequent extraction and independent review remain distinct.
