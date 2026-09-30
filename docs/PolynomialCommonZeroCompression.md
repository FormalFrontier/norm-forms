# Finite polynomial-system zero-set compression

Import `NormForms.CommonZeroCompression` (or the aggregate `NormForms`) to
compress a finite family of multivariate polynomial equations over a field `K`
with `¬ IsAlgClosed K` into one equation. For `[Fintype ι]`, any variable type
`σ`, and `f : ι → MvPolynomial σ K`, the theorem
`MvPolynomial.exists_common_zero_polynomial` returns `g` with

```lean
∀ x : σ → K, MvPolynomial.eval x g = 0 ↔
  ∀ i, MvPolynomial.eval x (f i) = 0
```

For `hf : ∀ i, (f i).IsHomogeneous d`, use
`MvPolynomial.exists_homogeneous_common_zero_polynomial`. It also supplies an
`m` strictly greater than `Fintype.card ι` and proves `g.IsHomogeneous (d * m)`.
No positive-degree, nonempty-family, nonzero-polynomial, finite-variable,
separability, or infinite-field assumption is required. Empty and all-zero
families, degree-zero homogeneous inputs, empty variable types, and finite
coefficient fields are included. The ordinary-import client
`NormFormsTests.CommonZeroCompression` exercises these boundaries, including
`ZMod 2`, and is available through `import NormFormsTests` when checking examples.

The construction obtains an anisotropic homogeneous form in sufficiently many
coordinates from `NormForms.CoordinateNormIteration`, embeds the finite family
into those coordinates, pads unused coordinates by zero, and uses native
`MvPolynomial.aeval` to substitute the family. Its pointwise evaluation and
homogeneity follow from mathlib substitution theorems.
The now-public `MvPolynomial.eval_aeval_pad_eq_zero_iff` and
`MvPolynomial.IsHomogeneous.aeval_pad` isolate those two steps for arbitrary
commutative semirings and index types; the original private padding proof
and inlined homogeneity case split have been removed. The forward-only
`MvPolynomial.eval_aeval_pad_eq_zero_imp` additionally needs only the
forward outer zero condition. See the [padded-substitution guide](PaddedSubstitution.md)
and its [ordinary-import client](../NormFormsTests/PaddedSubstitution.lean).

This compression result concerns only **K-valued** common zeros; it asserts
neither equality of ideals, radicals,
or schemes nor equality of zero sets over arbitrary field extensions. The
homogeneous conclusion does **not** claim `g.totalDegree = d * m`: zero is
homogeneous at any degree, and even a nonzero polynomial over a finite field
can vanish at every `K`-point.

The construction reuses the anisotropic forms in this library and the
separately published block-substitution dependency; exact revisions are in
`lakefile.toml` and `lake-manifest.json`. Original project contributors
proved polynomial compression and its client; subsequent contributors
extracted the public padding laws. Later assembly, independent review and
release editing are distinct from original mathematical authorship.
Source-specific coverage is not asserted by this guide.
