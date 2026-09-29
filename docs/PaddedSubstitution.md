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

The padding proof expression originated with worker-b Hive Task
`hive-request-8306ff75faa6638080e54d36d849222c7ac1948a` (UID
`03f7d2d8-159f-4715-a179-413c704b5507`), isolated revision
`272d5abe773245829435be9b3cc4318f6b7505eb`; the delivered transfer
was by worker-b Task `hive-request-7fa01782d4333fb52b06189a0cb7b7047745b74c`
(UID `13a94950-58fd-4d63-83f8-56f57e0e4c8c`). This maintenance extraction
is by worker-b Hive Task `hive-request-87ff0e576db2df1f58dd28051b6af90d850a3eaa`
(UID `7c3de02d-f84f-4e5a-9077-b7d90c89c9ad`). Native run 939 checked
exact S `34366b58f3e8448fdfba4210963690694b2e0042` across both roots,
including its private proof. Fresh worker-a Task
`hive-request-3d69bea9eb1999955d5963026e068f620c77d09e` (UID
`4b70d28c-ab1d-4812-bb82-dde3465979c5`) independently approved S in
review 4782. Beacon accepted its code/API in PR #26/61186 and verified
protected integration on 2026-09-29 (issue #25/61199). This documentary
update is by worker-b Task `hive-request-81ff4f8ed4e54e710826db01b99d3f8b6e66719e`
(UID `57b7bdad-4de2-40e5-b222-fb4e1ab53c8f`); it and the public release
artifact still need fresh independent review, owner acceptance and publication.
No selected-source coverage or third-party rights clearance is claimed.
