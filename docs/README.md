# Mathematical guides

The production root [`NormForms`](../NormForms.lean) reexports eleven leaves;
[`NormFormsTests`](../NormFormsTests.lean) imports thirteen checked-use leaves.
The [main README](../README.md#headline-results) introduces the results and
their hypotheses. These guides explain the mathematics and the corresponding
Lean declarations in more detail:

| Topic | Guide | Producer and ordinary-import clients |
| --- | --- | --- |
| Field coordinate norms and basis changes | [Native coordinate signatures](API.md) | [`NormForms.Coordinate`](../NormForms/Coordinate.lean), [clients](../NormFormsTests/Coordinate.lean) and [direct API](../NormFormsTests/DirectAPI.lean) |
| Universal norms and base change | [Universal-coordinate norm](UniversalCoordinateNorm.md) | [`NormForms.UniversalCoordinates`](../NormForms/UniversalCoordinates.lean), [clients](../NormFormsTests/UniversalCoordinates.lean) |
| Unbounded anisotropic degrees | [Iterated coordinate norms](CoordinateNormIteration.md) | [`NormForms.CoordinateNormIteration`](../NormForms/CoordinateNormIteration.lean), [client](../NormFormsTests/CoordinateNormIteration.lean) |
| Padding and substitution | [Zero-padded substitution](PaddedSubstitution.md) | [`NormForms.PaddedSubstitution`](../NormForms/PaddedSubstitution.lean), [client](../NormFormsTests/PaddedSubstitution.lean) |
| Coefficient-field common zero sets | [Polynomial-system compression](PolynomialCommonZeroCompression.md) | [`NormForms.CommonZeroCompression`](../NormForms/CommonZeroCompression.lean), [clients](../NormFormsTests/CommonZeroCompression.lean) |
| Conditional homogeneous systems | [Common nontrivial zeros](HomogeneousSystemZeros.md) | [`NormForms.HomogeneousSystemZeros`](../NormForms/HomogeneousSystemZeros.lean), [clients](../NormFormsTests/HomogeneousSystemZeros.lean) |
| Algebraic extensions | [Algebraic-extension form zeros](AlgebraicExtensionFormZeros.md) | [`NormForms.AlgebraicExtensionFormZeros`](../NormForms/AlgebraicExtensionFormZeros.lean), [clients](../NormFormsTests/AlgebraicExtensionFormZeros.lean) |
| Rational-function fields | [Rational-function form zeros](RatFuncFormZeros.md) | [`NormForms.RatFuncFormZeros`](../NormForms/RatFuncFormZeros.lean), [clients](../NormFormsTests/RatFuncFormZeros.lean) |
| Finite-transcendence extensions | [Finite-transcendence form zeros](FiniteTranscendenceFormZeros.md) | [`NormForms.FiniteTranscendenceFormZeros`](../NormForms/FiniteTranscendenceFormZeros.lean), [clients](../NormFormsTests/FiniteTranscendenceFormZeros.lean) |
| Finite-field common points | [Finite-field form zeros](FiniteFieldFormZeros.md) | [`NormForms.FiniteFieldFormZeros`](../NormForms/FiniteFieldFormZeros.lean), [private clients](../NormFormsTests/FiniteFieldFormZeros.lean) |
| Positive tensor powers | [Scalar-sum tensor annihilation](TensorScalarShrinking.md) | [`NormForms.TensorScalarSumAnnihilation`](../NormForms/TensorScalarSumAnnihilation.lean), [five public clients](../NormFormsTests/TensorScalarSumAnnihilation.lean) |

[`API.md`](API.md) and [`api-manifest.json`](api-manifest.json) are a generated
**historical six-module coordinate-only snapshot** from an earlier Lean/mathlib
pin. Their 18 production entries and 11 client entries are not a census of
this 26-module library, and the snapshot is not a proof, axiom or release
certificate. Later APIs are documented by the guides and producer modules.
The generated `API.md` matches the manifest's `api_sha256`; its 29 displayed
source anchors still identify the documented source docstrings.

### Historical snapshot: reproduction and limitations

The manifest and [`scripts/generate_api.py`](../scripts/generate_api.py) bind
six Lean sources and three toolchain/Lake inputs by SHA-256. All **nine** exact
files appear in the earlier public-release history at commit
`c4e1f302a4f4e9aa5cb84584ada022b9eb1ba73b`, an ancestor of the current
official release. Its generated API, manifest and adapter scripts are also
present. A reader with access to the official GitHub mirror can check out
that exact commit in a **separate** checkout; the mirror remains private until
the project authorizes public access. An equivalent source-only archive must
contain byte-identical files. The manifest's analyzed revision
`54accffeba182bea1f6969c2f6d67a96a43dc6f7` and tree
`c7dbbf39c7acf315ada65f18f84f0ed276c73151` identify the original
development input, **not** an official GitHub-fetchable commit. Neither the
current 26-module roots nor their newer mathlib and deliverable pins satisfy
the frozen generator's input hashes.

From that historical checkout or exact source-only archive, compare the nine
file hashes against `docs/api-manifest.json` before attempting reproduction.
To build the old six-module graph, install its pinned Lean toolchain and
**successfully fetch its matching precompiled mathlib cache first**:

```sh
elan toolchain install "$(cat lean-toolchain)"
lake exe cache get
LEAN_NUM_THREADS=2 lake --wfail build NormForms NormFormsTests NormFormsTests.Axioms
```

The separate core-only `leanprover/doc-gen4` tool is pinned to
`97d4ecdfc8e09e7f511724c25e303d448de6a3db` (tree
`ebf77f3e174c145c9ca2db0df1c18a78ae87c93b`) and is **not** a library
dependency. Its six raw `declaration-data-<module>.bmp` records, native
`api.db` and run receipts are external, **not** supplied by the GitHub source
history or this repository. With those six independently retained records in
`/path/to/native-input`, the unchanged adapter can compare both shipped
generated files without writing to them:

```sh
python3 -B scripts/test_generate_api.py --native-data /path/to/native-input
python3 -B scripts/generate_api.py --native-data /path/to/native-input \
  --source-revision 54accffeba182bea1f6969c2f6d67a96a43dc6f7 \
  --docgen-revision 97d4ecdfc8e09e7f511724c25e303d448de6a3db --check
```

These commands need the **exact** retained native record bytes or a separate
run of that pinned doc-gen4 against the old input; they do not manufacture
the external records or certify current proofs. A source-only archive need
not retain the original development Git commit: include the nine hashed
inputs, generator and tests, generated API and manifest, and supply the six
native records separately if running the adapter. The checks bind historical
source, pin and record bytes; they do not authenticate the native run,
enumerate private proof bodies, certify all transitive axioms or attest to
release acceptance. See the [current build instructions](#build) for the
present library; do not use the frozen commands as its proof audit.

## Build

From the repository root, install the pinned toolchain and fetch the matching
mathlib cache successfully **before** compilation:

```sh
elan toolchain install "$(cat lean-toolchain)"
lake exe cache get
lake build NormForms NormFormsTests
```

The exact official dependency revisions are recorded in `lakefile.toml` and
`lake-manifest.json`. These instructions are for reproduction, not evidence
for any changed documentation, mathematical code or release.
