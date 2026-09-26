#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
# Authors: Formal Frontier Agents
"""Corruption/replay checks over retained actual native records, not Lean substitutes.

Adapted by worker-b Hive Task hive-request-5c7bd446c48d132f4495f7d4938f573615d879bc
(UID df7a8fff-69fa-45c0-8013-325ac009ffbb) from the accepted
finite-group-tate-cohomology tests 61577f7cf2e02715f621a724aa692921ab6bbad9,
after polynomial-root-stability 95ac896f81a3190b2634a4246a3e924d2a267a61.
"""

import argparse
import copy
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

import generate_api as api


ROOT = Path(__file__).resolve().parent.parent
PARSER = argparse.ArgumentParser(description=__doc__)
PARSER.add_argument("--native-data", type=Path, required=True)


class NativeControls(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.sources = {path: (ROOT / path).read_bytes() for path in api.SOURCE_INPUT_SHA256}
        cls.original = {
            module: (ARGS.native_data / ("declaration-data-" + module + ".bmp")).read_bytes()
            for module in api.MODULES
        }
        cls.records = {module: json.loads(raw) for module, raw in cls.original.items()}
        api.check_snapshot(api.SOURCE, cls.sources)
        api.validate(cls.records, cls.original, cls.sources, api.SOURCE)

    def corrupt(self, modify, expected):
        records = copy.deepcopy(self.records)
        sources = dict(self.sources)
        modify(records, sources)
        raw = {module: json.dumps(record, ensure_ascii=False, sort_keys=True,
                                  separators=(",", ":")).encode("utf-8")
               for module, record in records.items()}
        with self.assertRaisesRegex(ValueError, expected):
            api.render(records, raw, sources, api.SOURCE)

    def test_actual_native_records_and_shipped_manifest(self):
        markdown, manifest_raw = api.render(self.records, self.original, self.sources, api.SOURCE)
        manifest = json.loads(manifest_raw)
        self.assertEqual(len(manifest["production_declarations"]), 18)
        self.assertEqual(len(manifest["public_client_declarations"]), 11)
        self.assertEqual(set(manifest["exposed_definitions"]), api.DEFINITIONS)
        self.assertEqual(manifest["instance_declarations"], [])
        self.assertEqual(manifest["undocumented_count"], 0)
        self.assertEqual(markdown.count(b"\n### "), 29)
        self.assertEqual(manifest["native_record_sha256"], api.NATIVE_RECORD_SHA256)
        self.assertEqual(manifest["inputs"], api.SOURCE_INPUT_SHA256)
        self.assertEqual(manifest["api_sha256"], api.digest(markdown))
        self.assertEqual((ROOT / "docs/API.md").read_bytes(), markdown)
        self.assertEqual((ROOT / "docs/api-manifest.json").read_bytes(), manifest_raw)
        self.assertNotIn(b"example.invalid", markdown + manifest_raw)
        self.assertNotIn(b"https://", markdown + manifest_raw)
        self.assertFalse(manifest["proof_certification"] or manifest["release_acceptance"])

    def test_missing_extra_duplicate_name_kind_and_instance_rows(self):
        production, client = api.MODULES[0], api.MODULES[2]
        controls = [
            ("missing/extra native declaration", lambda records, sources: records[production]["declarations"].pop()),
            ("missing/extra native declaration", lambda records, sources: records[production]["declarations"].append(
                copy.deepcopy(records[production]["declarations"][0]))),
            ("duplicate native declaration", lambda records, sources: records[production]["declarations"].__setitem__(
                1, copy.deepcopy(records[production]["declarations"][0]))),
            ("native module name differs", lambda records, sources: records[production].__setitem__("name", "Other")),
            ("wrong native name/kind", lambda records, sources: records[production]["declarations"][0]["info"].__setitem__(
                "kind", "axiom")),
            ("native self link differs", lambda records, sources: records[client]["declarations"][0]["info"].__setitem__(
                "name", "NormFormsTests.imaginary")),
            ("unexpected native instance/import surface", lambda records, sources: records[production]["instances"].append(
                dict(name="NormForms.generated", className="Field", typeNames=[]))),
        ]
        for diagnostic, change in controls:
            with self.subTest(diagnostic=diagnostic):
                self.corrupt(change, diagnostic)
        def rename_consistently(records, sources):
            info = records[client]["declarations"][0]["info"]
            info["name"] = "NormFormsTests.imaginary"
            info["docLink"] = "./NormFormsTests/Coordinate.html#NormFormsTests.imaginary"
        self.corrupt(rename_consistently, "native source/name/kind position differs")

    def test_line_source_doc_signature_and_implicit_binders(self):
        module = api.MODULES[0]
        name = "NormForms.coordinateChange"
        controls = [
            ("native source module/revision/path differs", lambda records, sources: records[module]["declarations"][0]["info"].__setitem__(
                "sourceLink", "https://example.invalid/commit/main/NormForms/Coordinate.lean")),
            ("native self link differs", lambda records, sources: records[module]["declarations"][0]["info"].__setitem__(
                "docLink", "./wrong.html#wrong")),
            ("native source docstring position differs", lambda records, sources: records[module]["declarations"][0]["info"].__setitem__(
                "line", 1)),
            ("native docstring/source mismatch", lambda records, sources: records[module]["declarations"][0]["info"].__setitem__(
                "doc", "Invented comment")),
            ("missing/active native source docstring", lambda records, sources: records[module]["declarations"][0]["info"].__setitem__(
                "doc", "<script>alert(1)</script>")),
            ("unexpected/active native header tag", lambda records, sources: records[module]["declarations"][0].__setitem__(
                "header", "<script>alert(1)</script>")),
        ]
        for diagnostic, change in controls:
            with self.subTest(diagnostic=diagnostic):
                self.corrupt(change, diagnostic)
        corruptions = {
            "{ι : Type w}": (">ι</span>", ">wrong</span>"),
            "{κ : Type w'}": (">κ</span>", ">wrong</span>"),
            "[Fintype κ]": (">Fintype</span>", ">WrongClass</span>"),
            "(κ → K) ≃ₗ[K] ι → K": (">≃ₗ[</span>", ">WrongMap[</span>"),
        }
        for token, (old, replacement) in corruptions.items():
            with self.subTest(binder=token):
                def remove_binder(records, sources):
                    row = next(row for row in records[module]["declarations"]
                               if row["info"]["name"] == name)
                    self.assertIn(token, api.Header(row["header"]).rendered())
                    if token == "[Fintype κ]":
                        left, separator, right = row["header"].rpartition(old)
                        self.assertTrue(separator)
                        row["header"] = left + replacement + right
                    else:
                        self.assertIn(old, row["header"])
                        row["header"] = row["header"].replace(old, replacement, 1)
                self.corrupt(remove_binder, "missing signature binder")

    def test_raw_byte_and_unexpected_files(self):
        module = api.MODULES[0]
        raw = dict(self.original)
        raw[module] += b" "
        with self.assertRaisesRegex(ValueError, "native raw record differs from pinned tool/input"):
            api.validate(self.records, raw, self.sources, api.SOURCE)
        with tempfile.TemporaryDirectory() as temporary:
            for name, data in self.original.items():
                (Path(temporary) / ("declaration-data-" + name + ".bmp")).write_bytes(data)
            (Path(temporary) / "declaration-data-Unapproved.Extra.bmp").write_bytes(b"{}")
            result = subprocess.run([sys.executable, "-B", str(ROOT / "scripts/generate_api.py"),
                                     "--native-data", temporary, "--source-revision", api.SOURCE,
                                     "--docgen-revision", api.TOOL, "--check"],
                                    capture_output=True, text=True, check=False)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("missing/extra native record file", result.stderr)

    def test_snapshot_optimizer_and_no_git_source_only_replay(self):
        for path in self.sources:
            with self.subTest(path=path):
                changed = dict(self.sources)
                changed[path] += b"\n"
                with self.assertRaisesRegex(ValueError, "source/pin drift from analyzed input"):
                    api.check_snapshot(api.SOURCE, changed)
        with self.assertRaisesRegex(ValueError, "source/pin inventory differs"):
            api.check_snapshot(api.SOURCE, {**self.sources, "extra.lean": b""})
        with self.assertRaisesRegex(ValueError, "unexpected/stale analyzed source revision"):
            api.check_snapshot("main", self.sources)
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            archive = root / "source-only-archive"
            (archive / "scripts").mkdir(parents=True)
            (archive / "docs").mkdir()
            for path in api.SOURCE_INPUT_SHA256:
                target = archive / path
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(self.sources[path])
            for name in ("scripts/generate_api.py", "docs/API.md", "docs/api-manifest.json"):
                (archive / name).write_bytes((ROOT / name).read_bytes())
            native = root / "retained-native-inputs"
            native.mkdir()
            for module, raw in self.original.items():
                (native / ("declaration-data-" + module + ".bmp")).write_bytes(raw)
            command = [sys.executable, "-I", "-B", str(archive / "scripts/generate_api.py"),
                       "--native-data", str(native), "--source-revision", api.SOURCE,
                       "--docgen-revision", api.TOOL, "--check"]
            result = subprocess.run(command, cwd=archive, env={"PATH": "/no-git-binary"},
                                    capture_output=True, text=True, check=False)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn('"status": "matched"', result.stdout)
            (archive / "docs/api-manifest.json").write_bytes(b"{}")
            result = subprocess.run(command, cwd=archive, env={"PATH": "/no-git-binary"},
                                    capture_output=True, text=True, check=False)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("generated file differs/stale manifest", result.stderr)
            for optimization in ("-O", "-OO"):
                with self.subTest(optimization=optimization):
                    result = subprocess.run([sys.executable, optimization,
                                             str(ROOT / "scripts/generate_api.py"),
                                             "--native-data", str(native),
                                             "--source-revision", api.SOURCE,
                                             "--docgen-revision", api.TOOL],
                                            capture_output=True, text=True, check=False)
                    self.assertNotEqual(result.returncode, 0)
                    self.assertIn("optimized Python is not supported", result.stderr)


if __name__ == "__main__":
    ARGS = PARSER.parse_args()
    unittest.main(argv=[sys.argv[0]], verbosity=2)
