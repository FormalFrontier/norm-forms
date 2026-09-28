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

The theorem proofs, five private clients and original guide derive from the
isolated incubator revision `b09f3c187eb6c9a17b1b08f2add69c081f04945f`,
authored by worker-b Hive Task
`hive-request-d2dad13a497343a75e6182e409c383b3aa2a14d9` (UID
`47d468b5-b70e-4340-8f05-bb4ea48acc79`). The mathematical route was
assessed by Tasks `hive-request-816ac77559f5852ec2c93e8bfb83d7a50aa20190`
(UID `f1dc54a3-fb88-4806-b9dc-885a09d845ad`) and
`hive-request-fa10fd03a100f15dcd58a8d228ba2f015f386785`
(UID `6d0a526a-97ec-4947-85c5-a03d153ed6b5`). A **fresh worker-a** Task
`hive-request-ad3bc257117d6035b4fdd0e632d083c6cac12ccd` (UID
`017291c6-f001-42b7-8151-de0c74eeade7`) independently reviewed that
isolated code, and Beacon accepted **only the isolated input** in incubator
issue #170 comment 59476. This destination transfer is by worker-b Task
`hive-request-8d86211aac37fbfbacde1cff6292e2c8a00e2629` (UID
`5daebbc8-1ee0-4dff-99c9-44d0a3e9bf9a`), not by copying donor ancestry.
The exact destination C `7a0fe210795b6b1ba26a0bdf272e69c156b123c0`
received its **own** complete ten-module, both-root native run 864 (UI 12,
artifact 181363; incubator issue #170/59605) and fresh independent worker-a
destination review by Task
`hive-request-434d90f78f1d94c51d15a45962e8aea3da037e5b` (UID
`61738d70-2bad-4bdd-a1c0-058d0339589d`). Beacon accepted that code/API
in PR #17/59647 on 2026-09-28 and verified protected main integration in
incubator issue #170/59660. Neither C's acceptance nor its proof evidence
approves this later documentation-only readiness or a proposed public
artifact; independent release review, stage acceptances and exact official
GitHub publication are separate and must be recorded against their own
revisions. Worker-b Task
`hive-request-847f8a2c7a0441d60d269b58583877aebf2e5b66` (UID
`50282a97-7767-4038-959e-f2b067f06160`) prepared these documentary
updates, not an independent review or source-coverage decision.
