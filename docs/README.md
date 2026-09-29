# Mathematical guide and historical native reference

The [homogeneous-system common-zero guide](HomogeneousSystemZeros.md) covers
the direct all-positive-degree single-form premise, arbitrary fields, positive
homogeneous label `d`, strict `s * d ^ r < n`, and zero, repeated and empty
families. Its `NormForms.HomogeneousSystemZeros` import and
`NormFormsTests.HomogeneousSystemZeros` client add one producer/client pair
to the earlier fourteen-module graph. This is distinct from the coefficient-
field-point [compression theorem](PolynomialCommonZeroCompression.md).
The historical counts and dated stage evidence below describe their stated
older revisions, not a build, review or release of this later transfer.

The [iterated coordinate-norm guide](CoordinateNormIteration.md) documents its
theorem, precise hypotheses and attained-degree conclusion, its
`NormForms.CoordinateNormIteration` import and its ordinary-import test client.
The [universal-coordinate norm guide](UniversalCoordinateNorm.md) documents
the arbitrary-commutative-base polynomial equality, direct
`NormForms.UniversalCoordinates` import and private finite/trivial-algebra
clients. The [finite polynomial-system zero-set compression guide](PolynomialCommonZeroCompression.md)
describes its `NormForms.CommonZeroCompression` direct import (or the
`NormForms` aggregate), homogeneous refinement, K-point-only limitations and
ordinary-import `NormFormsTests.CommonZeroCompression` boundary clients. These
three guides accompanied the twelve-Lean-module library. The
[zero-padded substitution guide](PaddedSubstitution.md) now documents three
general public laws with direct-import examples in
`NormFormsTests.PaddedSubstitution`, bringing the accepted main graph to
four current guides and fourteen Lean modules. None is a native
documentation regeneration or a proof-integrity receipt. The third guide and
changed roots were checked in native run 904 on exact C
`4a803474814f73e7011c045c5f613f360024b1a5` (both roots, 2,072 jobs;
62 actual origins including 18 private, standard-three transitive axioms),
independently reviewed by worker-a Task
`hive-request-23c96d626c3ec88ebbde46b9da9ade7cf64b5c9e` (UID
`2b20c511-56b9-488f-b807-263fab37cf68`, native review 4735), and accepted
by Beacon in PR #21/60312 with protected integration recorded in incubator
#175/60316 on 2026-09-28. That later documentary/public release artifact
was separately reviewed and published at official
`5fe9ff797f65d19f174f903774e660130ccf682d` (same tree as ordinary main
`f3f4e616920c163fa2a8bdd2b92ed42d419c4813`). The new extraction was
separately checked by native run 939 (UI 20, artifact 209763): matching-cache-
first both-root build and actual transitive standard-three audit of all 65
origins including 18 private across fourteen modules and 42 compiled parts.
Fresh independent worker-a review 4782 approved exact S
`34366b58f3e8448fdfba4210963690694b2e0042`; Beacon accepted its code/API
in PR #26/61186 and verified protected `main` integration in issue #25/61199
on 2026-09-29. Its documentary successor and same-tree public artifact
still need independent release review, separate owner acceptance and publication.

The [public/native API](API.md) and [machine-readable manifest](api-manifest.json)
document **all six historical Lean modules**, not the eight later-added modules
(the iteration, universal, compression and padding producer/client pairs),
from analyzed repair input
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
generated/equations) are not the earlier eight-module audit. The separate
historical native run 823 on accepted main revision
`313612a372a8c55a4e2af2bd0461d302998b6217` successfully audited all
48 actual-origin transitive declarations, including eight private names and
generated declarations, on the earlier pinned eight-module graph. The subsequent
ten-module contribution changed checking inputs. Native run 864 (UI 12,
artifact 181363) on accepted C `7a0fe210795b6b1ba26a0bdf272e69c156b123c0`
successfully built both roots and audited all 57 actual-origin transitive
declarations across ten modules, including 15 private names, with only the
three standard allowed axioms (incubator issue #170/59605). The later
twelve-module contribution changed both roots, so run 864 is historical for
the old inputs. Native run 904 (UI 16, artifact 194981), successful 2026-09-28
22:57:18–23:00:18 UTC, separately built both then-current roots (2,072 jobs) after
matching-cache verification and audited all 62 actual-origin declarations,
including 18 private, in twelve modules and 36 compiled parts. All transitive
axiom sets use only the three standard axioms (incubator #175/60292). The later
padding-law S changes the roots, so 904 is historical for the previous graph;
the applicable run is 939 above. These documentary changes alter the complete
input digest but not S's Lean/build/dependency/checker inputs; they are not
a new proof check. No
dependency docstrings, doc-gen4 website, HTML, JS, fonts or raw `.bmp` records
are shipped.

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

All reproduction commands below refer **only** to the six-module analyzed
source/tree above, the exact old direct mathlib pin
`e37d88a26f3791ed5a93daa1f949af1021b8d103` and its matching old Lake
inputs. Use a separate checkout (or byte-identical source archive) of those
frozen files. The previous twelve-module release changes aggregate imports and
pins mathlib at `83abb3e776bdefcbc447a1e44d0debe4010039e5` plus the
official Multivariate dependency; it cannot satisfy the unchanged native
generator's old source/pin hashes. Do not treat these older commands or their
historical output as checks of the new theorem or its destination graph. The
subsequent fourteen-module graph changes Lean input again, so historical native
run 904 cannot audit the padding-law extraction either; native run 939 does.

In that separate historical checkout, fetch the matching old mathlib cache
successfully before building:

```sh
elan toolchain install "$(cat lean-toolchain)"
lake exe cache get
LEAN_NUM_THREADS=2 lake --wfail build NormForms NormFormsTests NormFormsTests.Axioms
```

In a **separate checkout**, build the pinned doc-gen4 tool with
`lake build doc-gen4` (no mathlib dependency). If `cc` is absent, prepend
`$(dirname "$(elan which lean)")` to that tool build's `PATH`. With `TOOL`
pointing to that exact binary and `OUT` an empty external directory, run from
the **historical** project root:

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
rights and provenance assessment was part of the separately completed earlier
P release; the historical destination acceptance alone did not review those
documentation corrections. The universal-coordinate guide and its exact-C
destination contribution received independent provenance review from worker-a
Task `hive-request-434d90f78f1d94c51d15a45962e8aea3da037e5b` (UID
`61738d70-2bad-4bdd-a1c0-058d0339589d`) and Beacon's code acceptance
(PR #17/59647). The universal-coordinate release is complete at official
`e1cb91e0f25b663ef6d2439c77946602c8eae8e7`, separately reviewed and
published after its own documentary preparation. The new compression code/API
was independently reviewed (native 4735) and accepted/integrated in PR
#21/60312 and incubator #175/60316. Its later documentary artifact and
public history were separately reviewed and published as official
`5fe9ff797f65d19f174f903774e660130ccf682d`; no source-coverage or
general third-party rights decision follows. The historical static preparation
was by worker-b Task
`hive-request-9d6cb244757d207017694ca539c971c47be480aa` (UID
`e5f3b774-1939-4a87-a020-42e43ac815c1`), not an independent review.
The subsequent padded-substitution guide and initial documentation edits are by
worker-b Task `hive-request-87ff0e576db2df1f58dd28051b6af90d850a3eaa`
(UID `7c3de02d-f84f-4e5a-9077-b7d90c89c9ad`); exact S was independently
reviewed by worker-a Task `hive-request-3d69bea9eb1999955d5963026e068f620c77d09e`
(UID `4b70d28c-ab1d-4812-bb82-dde3465979c5`) in review 4782 and accepted
by Beacon in PR #26/61186. This later static documentary preparation is by
worker-b Task `hive-request-81ff4f8ed4e54e710826db01b99d3f8b6e66719e`
(UID `57b7bdad-4de2-40e5-b222-fb4e1ab53c8f`), not the proof author or an
independent release reviewer. No selected-source coverage or blanket
third-party rights clearance follows.
