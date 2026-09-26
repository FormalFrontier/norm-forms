# Native reference and reproducibility

The [public/native API](API.md) and [machine-readable manifest](api-manifest.json)
document **all six shipped Lean modules** from analyzed repair input
`54accffeba182bea1f6969c2f6d67a96a43dc6f7` (tree
`c7dbbf39c7acf315ada65f18f84f0ed276c73151`), which was unaccepted when
the native runs were recorded on 2026-09-26. Exact-artifact acceptance records,
not this historical input label, determine later lifecycle status. The production leaf has
18 named rows (four exposed noncomputable definitions, 14 theorems); the two
checked-use leaves have seven and four named theorem rows. The public reexport
root, axiom-print module and test root have zero new native rows. The pinned
native declaration and instance tables have **no** generated/anonymous/instance
rows here. All 29 rows have actual source docstrings matched to their source
start lines; no surrogate catalogue prose or missing-docstring lint gap is
hidden. Full displayed signatures retain implicit universe/field/index binders.

This is a **filtered public/native** reference, not an enumeration of four
private proof helpers, compiler-generated bodies, all proof fields or transitive
axioms. It does not certify formal source coverage, source interpretation,
kernel replay, third-party rights or any release. The historical 43 distinct
ordinary `#print axioms` results (18 public, 11 clients, four private, ten
generated/equations) are not a complete stored-body release audit; the
responsible maintainer owns that separate task. No dependency docstrings,
doc-gen4 website, HTML, JS, fonts or raw `.bmp` records are shipped.

## Frozen inputs and tool

The six analyzed `.lean` and three toolchain/Lake input SHA-256 hashes are fixed
in [`scripts/generate_api.py`](../scripts/generate_api.py) and in the
[manifest](api-manifest.json). The analyzed revision/tree label the source of
the **mathematical input**, not the future documentation commit: replay needs
only those exact bytes, not the historical Git object. Independently check the
separate core-only `leanprover/doc-gen4` tool at
`97d4ecdfc8e09e7f511724c25e303d448de6a3db` (tree
`ebf77f3e174c145c9ca2db0df1c18a78ae87c93b`); it is compatible with the
project's Lean `v4.34.0-rc2` and is **not a library dependency**.

Fetch the matching mathlib cache successfully before building this project:

```sh
elan toolchain install "$(cat lean-toolchain)"
lake exe cache get
LEAN_NUM_THREADS=2 lake --wfail build NormForms NormFormsTests NormFormsTests.Axioms
```

In a **separate checkout**, build the pinned doc-gen4 tool with
`lake build doc-gen4` (no mathlib dependency). If `cc` is absent, prepend
`$(dirname "$(elan which lean)")` to that tool build's `PATH`. With `TOOL`
pointing to that exact binary and `OUT` an empty external directory, run from
this repository root:

```sh
TOOL=/path/to/doc-gen4/.lake/build/bin/doc-gen4
OUT=/path/to/fresh/native-output
REV=54accffeba182bea1f6969c2f6d67a96a43dc6f7
mkdir -p "$OUT/build" "$OUT/render" "$OUT/native-input"
for module in NormForms.Coordinate NormForms NormFormsTests.Coordinate \
              NormFormsTests.DirectAPI NormFormsTests.Axioms NormFormsTests; do
  path="${module//.//}.lean"
  LEAN_NUM_THREADS=2 lake env "$TOOL" single --build "$OUT/build" "$module" \
    "$OUT/build/api.db" "https://example.invalid/commit/$REV/$path"
done
"$TOOL" bibPrepass --build "$OUT/render" --none
"$TOOL" fromDb --build "$OUT/render" --manifest "$OUT/render/manifest.json" \
  "$OUT/build/api.db" NormForms.Coordinate NormForms \
  NormFormsTests.Coordinate NormFormsTests.DirectAPI \
  NormFormsTests.Axioms NormFormsTests
for module in NormForms.Coordinate NormForms NormFormsTests.Coordinate \
              NormFormsTests.DirectAPI NormFormsTests.Axioms NormFormsTests; do
  cp "$OUT/render/doc-data/declaration-data-$module.bmp" "$OUT/native-input/"
done
python3 -B scripts/test_generate_api.py --native-data "$OUT/native-input"
python3 -B scripts/generate_api.py --native-data "$OUT/native-input" \
  --source-revision "$REV" \
  --docgen-revision 97d4ecdfc8e09e7f511724c25e303d448de6a3db --check
```

`example.invalid` is an inert identity label inside the external raw native
records, **not** a functioning source URL. Generated/shipped Markdown uses
only relative links to the analyzed source. Retain native `api.db`, six
raw declaration records, their hashes, command streams and warnings **outside
the shipped tree** for independent intake. Copy only the six named records,
not any extra dependency module records produced by the native tool.

The adapter checks fixed source/pin hashes, exact native module/name/kind and
instance inventories, source line and source docstring identity, revision and
path, displayed declaration identity, selected crucial implicit binders, and
every raw native byte hash. The manifest also hashes normalized sorted-key
UTF-8 JSON records without dropping fields; matching raw and normalized digests
in this run are an observed coincidence, not a version-independent rule.
Active HTML is refused. Optimized Python (`-O`, `-OO`) is refused before writing;
`--check` compares both generated files without modifying them. These checks
bind retained native data to fixed source bytes; the adapter is **not** a general
Lean parser, independent native-run authenticator or proof checker.

For source-only archives and an isolated parentless same-tree commit, keep the
six Lean sources, three pins, generator, generated docs and separately retained
native records. Replay does not require Git or the original analyzed commit
object. Independent final candidate binding and native rerun determinism are
separate checks from this adapter's data-only corruption tests.

## Rights and attribution

Original project source docstrings and this catalogue text are project
Apache-2.0 contributions with no invented individual rights holder; see
[`LICENSE`](../LICENSE). The generator and tests adapt the accepted
finite-group-tate-cohomology expression at
`61577f7cf2e02715f621a724aa692921ab6bbad9`, which credits the accepted
polynomial-root-stability generator at
`95ac896f81a3190b2634a4246a3e924d2a267a61` and Anchor's
ideal-completion recipe at `f0c8c34386109116e4912fb425a8ad15d9dc42a4`.
The present adaptation is by pooled worker-b Hive Task
`hive-request-5c7bd446c48d132f4495f7d4938f573615d879bc`, UID
`df7a8fff-69fa-45c0-8013-325ac009ffbb`. Type signatures refer to external
Lean/mathlib APIs, not copied dependency comments. The lint repair and native
re-binding are by worker-b Hive Task
`hive-request-6ad3c27b74cd1653d514075bbba1c3a93d649ce1`, UID
`e99a00fc-dbd5-4e6f-b6d6-cbfab82da92f`. The separate upstream tool
and excluded website assets retain their own upstream notices; this project's
license cannot clear another party's material. Independent exact-artifact
rights and provenance assessment remains a release prerequisite.
