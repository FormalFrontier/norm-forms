# Native API reference

Pinned Lean `v4.34.0-rc2`, mathlib `e37d88a26f3791ed5a93daa1f949af1021b8d103`
and separately pinned doc-gen4 `97d4ecdfc8e09e7f511724c25e303d448de6a3db`. Full displayed signatures
retain implicit binders, typeclasses and universe parameters.

The six shipped Lean modules have 18 production entries (four exposed
noncomputable definitions and 14 theorems) and 11 checked-use client
theorems. The reexport root, axiom-print module and test root have zero
new native rows. There are no named/generated/anonymous instance rows
in these filtered native records. Private helpers and compiler-generated
proof bodies are **not** enumerated here; this is not an axiom census,
proof recheck, rights clearance, source-coverage or release certificate.
[Reproduction and limitations](README.md).

Each entry reproduces its **original native source docstring** and has a
relative anchor into the analyzed `.lean` source. No catalogue prose
is substituted for missing documentation; these records have none.

## Production API (18 entries)

### NormForms.coordinateNorm

Kind: `def`.

```lean
noncomputable def NormForms.coordinateNorm {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} [Fintype ι] (b : Module.Basis ι K L) (x : ι → K) : K
```

**Native source docstring:** The field norm in the coordinates supplied by a finite basis.

[Source](../NormForms/Coordinate.lean#L40) (native source start line).

### NormForms.coordinateNorm_eq_zero_iff

Kind: `theorem`.

```lean
theorem NormForms.coordinateNorm_eq_zero_iff {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} [Fintype ι] (b : Module.Basis ι K L) (x : ι → K) : coordinateNorm b x = 0 ↔ x = 0
```

**Native source docstring:** A coordinate norm vanishes exactly at the zero coordinate vector.

[Source](../NormForms/Coordinate.lean#L45) (native source start line).

### NormForms.coordinateNorm_smul

Kind: `theorem`.

```lean
theorem NormForms.coordinateNorm_smul {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} [Fintype ι] (b : Module.Basis ι K L) (a : K) (x : ι → K) : coordinateNorm b (a • x) = a ^ Fintype.card ι * coordinateNorm b x
```

**Native source docstring:** The coordinate norm is homogeneous under scalar multiplication.

[Source](../NormForms/Coordinate.lean#L51) (native source start line).

### NormForms.coordinateChange

Kind: `def`.

```lean
noncomputable def NormForms.coordinateChange {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} {κ : Type w'} [Fintype ι] [Fintype κ] (b : Module.Basis ι K L) (b' : Module.Basis κ K L) : (κ → K) ≃ₗ[K] ι → K
```

**Native source docstring:** Convert coordinates in `b'` to coordinates in `b`.

[Source](../NormForms/Coordinate.lean#L57) (native source start line).

### NormForms.coordinateChange_apply

Kind: `theorem`.

```lean
theorem NormForms.coordinateChange_apply {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} {κ : Type w'} [Fintype ι] [Fintype κ] (b : Module.Basis ι K L) (b' : Module.Basis κ K L) (x : κ → K) : (coordinateChange b b') x = b.equivFun (b'.equivFun.symm x)
```

**Native source docstring:** Converting coordinates does not change the represented element.

[Source](../NormForms/Coordinate.lean#L63) (native source start line).

### NormForms.coordinateNorm_coordinateChange

Kind: `theorem`.

```lean
theorem NormForms.coordinateNorm_coordinateChange {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} {κ : Type w'} [Fintype ι] [Fintype κ] (b : Module.Basis ι K L) (b' : Module.Basis κ K L) (x : κ → K) : coordinateNorm b ((coordinateChange b b') x) = coordinateNorm b' x
```

**Native source docstring:** The coordinate norm is independent of the chosen coordinates.

[Source](../NormForms/Coordinate.lean#L69) (native source start line).

### NormForms.coordinateNormPolynomial

Kind: `def`.

```lean
noncomputable def NormForms.coordinateNormPolynomial {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} [Fintype ι] (b : Module.Basis ι K L) : MvPolynomial ι K
```

**Native source docstring:** The signed constant characteristic coefficient giving the coordinate norm form.

[Source](../NormForms/Coordinate.lean#L76) (native source start line).

### NormForms.coordinateNormPolynomial_isHomogeneous

Kind: `theorem`.

```lean
theorem NormForms.coordinateNormPolynomial_isHomogeneous {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} [Fintype ι] (b : Module.Basis ι K L) : (coordinateNormPolynomial b).IsHomogeneous (Fintype.card ι)
```

**Native source docstring:** The coordinate norm polynomial is homogeneous of degree equal to the basis cardinality.

[Source](../NormForms/Coordinate.lean#L85) (native source start line).

### NormForms.coordinateNormPolynomial_eval

Kind: `theorem`.

```lean
theorem NormForms.coordinateNormPolynomial_eval {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} [Fintype ι] (b : Module.Basis ι K L) (x : ι → K) : (MvPolynomial.eval x) (coordinateNormPolynomial b) = coordinateNorm b x
```

**Native source docstring:** Evaluation of the coordinate norm polynomial is the field norm in those coordinates.

[Source](../NormForms/Coordinate.lean#L96) (native source start line).

### NormForms.coordinateNormPolynomial_eval_eq_zero_iff

Kind: `theorem`.

```lean
theorem NormForms.coordinateNormPolynomial_eval_eq_zero_iff {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} [Fintype ι] (b : Module.Basis ι K L) (x : ι → K) : (MvPolynomial.eval x) (coordinateNormPolynomial b) = 0 ↔ x = 0
```

**Native source docstring:** The coordinate norm polynomial has no nontrivial zero.

[Source](../NormForms/Coordinate.lean#L111) (native source start line).

### NormForms.coordinateNormPolynomial_ne_zero

Kind: `theorem`.

```lean
theorem NormForms.coordinateNormPolynomial_ne_zero {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} [Fintype ι] (b : Module.Basis ι K L) : coordinateNormPolynomial b ≠ 0
```

**Native source docstring:** A coordinate norm polynomial is nonzero.

[Source](../NormForms/Coordinate.lean#L116) (native source start line).

### NormForms.coordinateNormPolynomial_totalDegree

Kind: `theorem`.

```lean
theorem NormForms.coordinateNormPolynomial_totalDegree {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} [Fintype ι] (b : Module.Basis ι K L) : (coordinateNormPolynomial b).totalDegree = Fintype.card ι
```

**Native source docstring:** The exact total degree of a coordinate norm polynomial.

[Source](../NormForms/Coordinate.lean#L127) (native source start line).

### NormForms.coordinateNormPolynomial_eval_coordinateChange

Kind: `theorem`.

```lean
theorem NormForms.coordinateNormPolynomial_eval_coordinateChange {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} {κ : Type w'} [Fintype ι] [Fintype κ] (b : Module.Basis ι K L) (b' : Module.Basis κ K L) (x : κ → K) : (MvPolynomial.eval ((coordinateChange b b') x)) (coordinateNormPolynomial b) = (MvPolynomial.eval x) (coordinateNormPolynomial b')
```

**Native source docstring:** Evaluation after a change of coordinates gives the norm in the new coordinates.

[Source](../NormForms/Coordinate.lean#L133) (native source start line).

### NormForms.coordinateNormPolynomial_reindex

Kind: `theorem`.

```lean
theorem NormForms.coordinateNormPolynomial_reindex {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} {κ : Type w'} [Fintype ι] [Fintype κ] (b : Module.Basis ι K L) (e : ι ≃ κ) : coordinateNormPolynomial (b.reindex e) = (MvPolynomial.rename ⇑e) (coordinateNormPolynomial b)
```

**Native source docstring:** Reindexing a basis renames the variables of its coordinate norm polynomial.

[Source](../NormForms/Coordinate.lean#L208) (native source start line).

### NormForms.coordinateNorm_reindex

Kind: `theorem`.

```lean
theorem NormForms.coordinateNorm_reindex {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} {κ : Type w'} [Fintype ι] [Fintype κ] (b : Module.Basis ι K L) (e : ι ≃ κ) (x : κ → K) : coordinateNorm (b.reindex e) x = coordinateNorm b (x ∘ ⇑e)
```

**Native source docstring:** Reindexing coordinates acts by precomposition with the indexing equivalence.

[Source](../NormForms/Coordinate.lean#L221) (native source start line).

### NormForms.coordinateChangePolynomial

Kind: `def`.

```lean
noncomputable def NormForms.coordinateChangePolynomial {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} {κ : Type w'} [Fintype ι] [Fintype κ] (b : Module.Basis ι K L) (b' : Module.Basis κ K L) (i : ι) : MvPolynomial κ K
```

**Native source docstring:** The linear polynomials expressing `b`-coordinates in terms of `b'`-coordinates.

[Source](../NormForms/Coordinate.lean#L228) (native source start line).

### NormForms.coordinateChangePolynomial_eval

Kind: `theorem`.

```lean
theorem NormForms.coordinateChangePolynomial_eval {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} {κ : Type w'} [Fintype ι] [Fintype κ] (b : Module.Basis ι K L) (b' : Module.Basis κ K L) (x : κ → K) (i : ι) : (MvPolynomial.eval x) (coordinateChangePolynomial b b' i) = (coordinateChange b b') x i
```

**Native source docstring:** The coordinate-change polynomials evaluate to the coordinate-change linear equivalence.

[Source](../NormForms/Coordinate.lean#L235) (native source start line).

### NormForms.coordinateNormPolynomial_changeBasis

Kind: `theorem`.

```lean
theorem NormForms.coordinateNormPolynomial_changeBasis {K : Type u} {L : Type v} [Field K] [Field L] [Algebra K L] {ι : Type w} {κ : Type w'} [Fintype ι] [Fintype κ] (b : Module.Basis ι K L) (b' : Module.Basis κ K L) : coordinateNormPolynomial b' = (MvPolynomial.bind₁ (coordinateChangePolynomial b b')) (coordinateNormPolynomial b)
```

**Native source docstring:** An arbitrary change of basis substitutes its coordinate linear forms into the norm form.

[Source](../NormForms/Coordinate.lean#L283) (native source start line).

## Checked-use clients (11 entries)

### NormFormsTests.rational_singleton_norm

Kind: `theorem`.

```lean
theorem NormFormsTests.rational_singleton_norm : (NormForms.coordinateNorm (Module.Basis.singleton Unit ℚ) fun (x : Unit) => 3) = 3
```

**Native source docstring:** A singleton rational basis gives the ordinary one-dimensional field norm.

[Source](../NormFormsTests/Coordinate.lean#L26) (native source start line).

### NormFormsTests.rational_singleton_polynomial

Kind: `theorem`.

```lean
theorem NormFormsTests.rational_singleton_polynomial : NormForms.coordinateNormPolynomial (Module.Basis.singleton Unit ℚ) = MvPolynomial.X ()
```

**Native source docstring:** The rational singleton norm form is the single coordinate variable.

[Source](../NormFormsTests/Coordinate.lean#L30) (native source start line).

### NormFormsTests.complex_norm_polynomial

Kind: `theorem`.

```lean
theorem NormFormsTests.complex_norm_polynomial : NormForms.coordinateNormPolynomial Complex.basisOneI = MvPolynomial.X 0 ^ 2 + MvPolynomial.X 1 ^ 2
```

**Native source docstring:** The standard complex norm form is the sum of two squares.

[Source](../NormFormsTests/Coordinate.lean#L37) (native source start line).

### NormFormsTests.complex_swap_coordinates

Kind: `theorem`.

```lean
theorem NormFormsTests.complex_swap_coordinates (x : Fin 2 → ℝ) : (NormForms.coordinateChange Complex.basisOneI (Complex.basisOneI.reindex (Equiv.swap 0 1))) x = x ∘ ⇑(Equiv.swap 0 1)
```

**Native source docstring:** Swapping a complex basis sends new coordinates to old coordinates in swap order.

[Source](../NormFormsTests/Coordinate.lean#L45) (native source start line).

### NormFormsTests.complex_reindex_polynomial

Kind: `theorem`.

```lean
theorem NormFormsTests.complex_reindex_polynomial : NormForms.coordinateNormPolynomial (Complex.basisOneI.reindex (Equiv.swap 0 1)) = (MvPolynomial.rename ⇑(Equiv.swap 0 1)) (NormForms.coordinateNormPolynomial Complex.basisOneI)
```

**Native source docstring:** Reindexing the standard complex basis renames the polynomial variables.

[Source](../NormFormsTests/Coordinate.lean#L52) (native source start line).

### NormFormsTests.complex_changeBasis_eval

Kind: `theorem`.

```lean
theorem NormFormsTests.complex_changeBasis_eval (b : Module.Basis (Fin 2) ℝ ℂ) (x : Fin 2 → ℝ) : (MvPolynomial.eval ((NormForms.coordinateChange Complex.basisOneI b) x)) (NormForms.coordinateNormPolynomial Complex.basisOneI) = (MvPolynomial.eval x) (NormForms.coordinateNormPolynomial b)
```

**Native source docstring:** Evaluating after an arbitrary complex basis change respects the norm.

[Source](../NormFormsTests/Coordinate.lean#L59) (native source start line).

### NormFormsTests.complex_changeBasis_polynomial

Kind: `theorem`.

```lean
theorem NormFormsTests.complex_changeBasis_polynomial (b : Module.Basis (Fin 2) ℝ ℂ) : NormForms.coordinateNormPolynomial b = (MvPolynomial.bind₁ (NormForms.coordinateChangePolynomial Complex.basisOneI b)) (NormForms.coordinateNormPolynomial Complex.basisOneI)
```

**Native source docstring:** An arbitrary complex basis change is structural polynomial substitution.

[Source](../NormFormsTests/Coordinate.lean#L66) (native source start line).

### NormFormsTests.finite_identity_norm_one

Kind: `theorem`.

```lean
theorem NormFormsTests.finite_identity_norm_one : (NormForms.coordinateNorm (Module.Basis.singleton Unit (ZMod 2)) fun (x : Unit) => 1) = 1
```

**Native source docstring:** Evaluating the one-dimensional norm on the nonzero point over a finite field.

[Source](../NormFormsTests/DirectAPI.lean#L28) (native source start line).

### NormFormsTests.finite_unequal_indices_eval

Kind: `theorem`.

```lean
theorem NormFormsTests.finite_unequal_indices_eval (x : ULift.{1, 0} (Fin 1) → ZMod 2) : (MvPolynomial.eval x) (NormForms.coordinateNormPolynomial ((Module.Basis.singleton Unit (ZMod 2)).reindex (Equiv.ofUnique Unit (ULift.{1, 0} (Fin 1))))) = NormForms.coordinateNorm ((Module.Basis.singleton Unit (ZMod 2)).reindex (Equiv.ofUnique Unit (ULift.{1, 0} (Fin 1)))) x
```

**Native source docstring:** The direct API evaluates the finite-field polynomial in new basis coordinates.

[Source](../NormFormsTests/DirectAPI.lean#L33) (native source start line).

### NormFormsTests.finite_unequal_indices_rename

Kind: `theorem`.

```lean
theorem NormFormsTests.finite_unequal_indices_rename : NormForms.coordinateNormPolynomial ((Module.Basis.singleton Unit (ZMod 2)).reindex (Equiv.ofUnique Unit (ULift.{1, 0} (Fin 1)))) = (MvPolynomial.rename ⇑(Equiv.ofUnique Unit (ULift.{1, 0} (Fin 1)))) (NormForms.coordinateNormPolynomial (Module.Basis.singleton Unit (ZMod 2)))
```

**Native source docstring:** The direct API renames polynomial variables across distinct index types.

[Source](../NormFormsTests/DirectAPI.lean#L44) (native source start line).

### NormFormsTests.finite_unequal_indices_substitution

Kind: `theorem`.

```lean
theorem NormFormsTests.finite_unequal_indices_substitution : NormForms.coordinateNormPolynomial ((Module.Basis.singleton Unit (ZMod 2)).reindex (Equiv.ofUnique Unit (ULift.{1, 0} (Fin 1)))) = (MvPolynomial.bind₁ (NormForms.coordinateChangePolynomial (Module.Basis.singleton Unit (ZMod 2)) ((Module.Basis.singleton Unit (ZMod 2)).reindex (Equiv.ofUnique Unit (ULift.{1, 0} (Fin 1)))))) (NormForms.coordinateNormPolynomial (Module.Basis.singleton Unit (ZMod 2)))
```

**Native source docstring:** A finite-field basis change is equality of polynomials by structural substitution.

[Source](../NormFormsTests/DirectAPI.lean#L53) (native source start line).
