# Norms from universal coordinates

Import `NormForms.UniversalCoordinates` directly, or `NormForms` for the
aggregate library. For a commutative ring `R`, a possibly noncommutative
`R`-algebra `B` with a finite basis `b : Basis ι R B`, and **any** commutative
`R`-algebra `A`, `Algebra.norm_coordinates_baseChange b x` identifies, for
every `x : ι → A`, evaluation at `x` of the native polynomial

```text
C ((-1 : R) ^ Module.finrank R B) *
  (LinearMap.polyCharpoly (Algebra.lmul R B).toLinearMap b).coeff 0
```

with `Algebra.norm A (∑ i, x i ⊗ₜ[R] b i : A ⊗[R] B)`.
The **left** tensor factor contains coordinates in `A`; the right contains
basis vectors in `B`. The theorem explicitly requires `[Fintype ι]`,
`[DecidableEq ι]`, `[Module.Free R B]` and `[Module.Finite R B]` for the
native characteristic-polynomial API. The basis gives the two module
instances, and decidable equality is available classically for a finite
index type. No field, injective scalar map, or nontriviality hypothesis on
`A` is required.

`Algebra.norm_universalCoordinates b` is an **equality of polynomials**:
the signed characteristic coefficient above equals

```text
Algebra.norm (MvPolynomial ι R)
  (∑ i, MvPolynomial.X i ⊗ₜ[R] b i : MvPolynomial ι R ⊗[R] B)
```

It specializes the base-change theorem to `A = MvPolynomial ι R` and
`x = MvPolynomial.X`; it does not infer polynomial equality solely from
field-valued evaluations. In particular, the theorem also applies over a
finite field such as `ZMod 2`. The private ordinary-import client
[`NormFormsTests/UniversalCoordinates.lean`](../NormFormsTests/UniversalCoordinates.lean)
checks both the arbitrary-`A` equation and the universal polynomial equation,
as well as evaluation at `ZMod 2`, evaluation in the **trivial** coefficient
algebra `ZMod 1` over `ℤ`, and the resulting zero value. The proof first
handles trivial `A`; only the nontrivial branch compares basis ranks and
uses the induced nontriviality of `R`.

The proof compares the full multiplication families on pure tensors by
tensor induction, transports characteristic-polynomial coefficients under
`aeval`, and uses the tensor-product basis and the signed constant-coefficient
determinant identity to identify the norm. Its two technical helper lemmas
remain private in
[`NormForms/UniversalCoordinates.lean`](../NormForms/UniversalCoordinates.lean).
For fields `K`, `L` and `b : Basis ι K L`, the left side of
`Algebra.norm_universalCoordinates b` at `R = K`, `B = L` is **exactly**
the signed-coefficient expression defining the existing
[`NormForms.coordinateNormPolynomial b`](../NormForms/Coordinate.lean);
the basis supplies its finite-free instances. Thus its right side gives a
genuine universal-tensor-norm expression for that existing field polynomial,
without introducing a second definition or requiring a bridge wrapper.

This tensor norm does not by itself identify the norm inside a
rational-function field extension: that would require a separate algebra
equivalence preserving coefficients and variable generators. Nor is it a
literal Neukirch–Schmidt–Wingberg cohomological recipe or a selected-source
coverage decision; that book is background, and those comparisons are separate.

The universal-coordinate proofs, five private ordinary-import clients and
initial mathematical guide were contributed as original Formal Frontier work.
Subsequent destination assembly, independent review and release editing were
separate work; none changes the hypotheses or the distinction between the
universal polynomial identity and a rational-function field-extension norm.
