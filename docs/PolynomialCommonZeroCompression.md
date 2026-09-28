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
homogeneity follow from mathlib substitution theorems. This result concerns
only **K-valued** common zeros; it asserts neither equality of ideals, radicals,
or schemes nor equality of zero sets over arbitrary field extensions. The
homogeneous conclusion does **not** claim `g.totalDegree = d * m`: zero is
homogeneous at any degree, and even a nonzero polynomial over a finite field
can vanish at every `K`-point.

The dependency graph uses mathlib commit
`83abb3e776bdefcbc447a1e44d0debe4010039e5` and the officially published
`multivariate-polynomials` commit
`ec4906268f2a65a54e320ce9f3f44562e9d78c1e` under
`leanprover/lean4:v4.34.0-rc2`; there is no incubator dependency. The
anisotropic-form prerequisite is part of the already published NormForms
library. The polynomial compression expression and private client were
authored by worker-b Hive Task
`hive-request-8306ff75faa6638080e54d36d849222c7ac1948a` (UID
`03f7d2d8-159f-4715-a179-413c704b5507`) in isolated revision
`272d5abe773245829435be9b3cc4318f6b7505eb`. Worker-a Task
`hive-request-cee92f392eeacba31bce30072ea79308ee41a539` (UID
`1af91b4f-4d05-4a1c-aaa3-a57ecb10a627`) independently approved that
isolated expression; Beacon accepted it only in that isolated scope. This
destination transfer without donor ancestry is by worker-b Hive Task
`hive-request-7fa01782d4333fb52b06189a0cb7b7047745b74c` (UID
`13a94950-58fd-4d63-83f8-56f57e0e4c8c`). Native run 904 (UI 16, artifact
194981) successfully checked the current destination graph on 2026-09-28:
matching-cache-first two-root build (2,072 jobs) and complete standard-three
transitive audit of all 62 actual origins in twelve modules, including 18
private (incubator #175/60292). Fresh worker-a Task
`hive-request-23c96d626c3ec88ebbde46b9da9ade7cf64b5c9e` (UID
`2b20c511-56b9-488f-b807-263fab37cf68`) independently approved exact C
`4a803474814f73e7011c045c5f613f360024b1a5` in native review 4735;
Beacon accepted and protected-integrated its code/API in PR #21/60312 and
incubator #175/60316. This guide's documentary release preparation is by
worker-b Task `hive-request-9d6cb244757d207017694ca539c971c47be480aa`
(UID `e5f3b774-1939-4a87-a020-42e43ac815c1`), not its proof author or
reviewer. Separately reviewed official release and verified publication of
this contribution remain outstanding; no selected-source correspondence or
coverage is asserted.
