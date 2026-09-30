#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
# Authors: Formal Frontier Agents
"""Version-bound native doc-gen4 reference for coordinate norm forms.

Adapted from Formal Frontier's finite-group Tate cohomology generator,
following its polynomial-root-stability predecessor and Anchor's
ideal-completion recipe. The fixed records document analyzed input,
not proof or release certification.
"""

if not __debug__:
    raise SystemExit("optimized Python is not supported for API generation")

import argparse
import hashlib
from html.parser import HTMLParser
import json
from pathlib import Path
import re


TOOL = "97d4ecdfc8e09e7f511724c25e303d448de6a3db"
SOURCE = "54accffeba182bea1f6969c2f6d67a96a43dc6f7"
SOURCE_TREE = "c7dbbf39c7acf315ada65f18f84f0ed276c73151"
MODULES = (
    "NormForms.Coordinate", "NormForms", "NormFormsTests.Coordinate",
    "NormFormsTests.DirectAPI", "NormFormsTests.Axioms", "NormFormsTests",
)
SOURCE_INPUT_SHA256 = {
    "NormForms/Coordinate.lean": "6a2f284a1a902654b7636f7918df2e420cbab8ff470804c82a3e355669b2231e",
    "NormForms.lean": "15b92644efddc5f4251bd2966bb4943b9de43c73f1d53873c73a20cec7e600bc",
    "NormFormsTests/Coordinate.lean": "4cdaf23a100e59f3c24fa40a5045b8acb61425535e4a47f3191a5b1eecde35ee",
    "NormFormsTests/DirectAPI.lean": "bfb87349001aa5ead356cb2996df3a9a40f2810624b505fa45c597df429367cd",
    "NormFormsTests/Axioms.lean": "54d823ab799c0c380336875b4616c9e87489062818b387ec6adcb8b3fd894dad",
    "NormFormsTests.lean": "d530db0f5037db6ac722828349168b8e862309f5a094c52503b4dd78e2e39bea",
    "lean-toolchain": "8190e75a201741065fe508b28955dd64dd72d090babe5f70ce6848879d68ae88",
    "lakefile.toml": "52463d1c2aa8e2721397cdd0f3eecfe4d736850b8bd0408418c25830eee676ac",
    "lake-manifest.json": "6642600cbe58cca9e288661987ecc3bb19cb4435f744412332c5b4b97f86a4e9",
}
NATIVE_RECORD_SHA256 = {
    "NormForms.Coordinate": "4bfa8f808e81c53d2f599d2f087b28a22e49d65df792effaf0d5dda6ac023144",
    "NormForms": "6fc959b783308660d3839b49677c122081d781374dbe7243ee01c01f767bfd89",
    "NormFormsTests.Coordinate": "ed8bf81735dafd4f27f2491cc6d224ef448f7a9cec74ef18c30f902f36118722",
    "NormFormsTests.DirectAPI": "233db4420e6d28c1cce327a1e2c6a303db7b550894524bf7f3f4932521e1f926",
    "NormFormsTests.Axioms": "3458a47c15d4a28e2afa411e61124b9552c8a1f276493ce8334522a05a6cfaaf",
    "NormFormsTests": "d43f46e7d412b971bd607f8c08d9d5481a1665432756058f23cc7128dd5cc1a8",
}
EXPECTED = {
    "NormForms.Coordinate": (
        "coordinateNorm", "coordinateNorm_eq_zero_iff", "coordinateNorm_smul",
        "coordinateChange", "coordinateChange_apply", "coordinateNorm_coordinateChange",
        "coordinateNormPolynomial", "coordinateNormPolynomial_isHomogeneous",
        "coordinateNormPolynomial_eval", "coordinateNormPolynomial_eval_eq_zero_iff",
        "coordinateNormPolynomial_ne_zero", "coordinateNormPolynomial_totalDegree",
        "coordinateNormPolynomial_eval_coordinateChange", "coordinateNormPolynomial_reindex",
        "coordinateNorm_reindex", "coordinateChangePolynomial",
        "coordinateChangePolynomial_eval", "coordinateNormPolynomial_changeBasis",
    ),
    "NormForms": (),
    "NormFormsTests.Coordinate": (
        "rational_singleton_norm", "rational_singleton_polynomial", "complex_norm_polynomial",
        "complex_swap_coordinates", "complex_reindex_polynomial",
        "complex_changeBasis_eval", "complex_changeBasis_polynomial",
    ),
    "NormFormsTests.DirectAPI": (
        "finite_identity_norm_one", "finite_unequal_indices_eval",
        "finite_unequal_indices_rename", "finite_unequal_indices_substitution",
    ),
    "NormFormsTests.Axioms": (),
    "NormFormsTests": (),
}
DEFINITIONS = {
    "NormForms.coordinateNorm", "NormForms.coordinateChange",
    "NormForms.coordinateNormPolynomial", "NormForms.coordinateChangePolynomial",
}
KEY_TOKENS = {
    "NormForms.coordinateNorm": ("{K : Type u}", "{L : Type v}", "[Algebra K L]", "{ι : Type w}", "[Fintype ι]"),
    "NormForms.coordinateChange": ("{ι : Type w}", "{κ : Type w'}", "[Fintype κ]", "(κ → K) ≃ₗ[K] ι → K"),
    "NormForms.coordinateNormPolynomial_changeBasis": ("{ι : Type w}", "{κ : Type w'}", "MvPolynomial.bind₁", "coordinateChangePolynomial b b'"),
    "NormForms.coordinateNormPolynomial_reindex": ("(e : ι ≃ κ)", "MvPolynomial.rename ⇑e"),
    "NormFormsTests.finite_unequal_indices_rename": ("ZMod 2", "ULift.{1, 0} (Fin 1)", "MvPolynomial.rename"),
    "NormFormsTests.finite_unequal_indices_substitution": ("ZMod 2", "ULift.{1, 0} (Fin 1)", "MvPolynomial.bind₁"),
}


def require(condition, message):
    if not condition:
        raise ValueError(message)


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


class Header(HTMLParser):
    """Extract all displayed tokens, including CSS-hidden implicit binders."""

    def __init__(self, value):
        super().__init__(convert_charrefs=True)
        self.stack = []
        self.text = []
        self.kinds = []
        self.names = []
        self.feed(value)
        self.close()
        require(not self.stack, "unclosed native header")

    def handle_starttag(self, tag, attrs):
        require(tag in {"div", "span", "a"}, "unexpected/active native header tag")
        attributes = dict(attrs)
        require(len(attrs) == len(attributes) and set(attributes) <= {"class", "href"},
                "active/unknown native header attribute")
        require(tag == "a" or "href" not in attributes, "unexpected native header link")
        require("href" not in attributes or
                re.fullmatch(r"\./[\w./#-]+", attributes["href"]) is not None,
                "active/external native header link")
        classes = set(attributes.get("class", "").split())
        if tag == "div" and "decl_type" in classes:
            self.text.append(" ")
        self.stack.append((tag, classes))

    def handle_endtag(self, tag):
        require(bool(self.stack) and self.stack[-1][0] == tag, "unbalanced native header")
        self.stack.pop()

    def handle_data(self, value):
        require(bool(self.stack) or not value.strip(), "text outside native header")
        self.text.append(value)
        if any("decl_kind" in classes for _, classes in self.stack):
            self.kinds.append(value)
        if any("decl_name" in classes for _, classes in self.stack):
            self.names.append(value)

    def handle_comment(self, _):
        raise ValueError("unexpected native header comment")

    def handle_decl(self, _):
        raise ValueError("unexpected native header declaration")

    def rendered(self):
        return " ".join("".join(self.text).split())


def source_anchor(raw, line, name, kind, doc):
    lines = raw.decode("utf-8").splitlines()
    require(type(line) is int and 0 < line <= len(lines), "invalid native source line: " + name)
    rest = "\n".join(lines[line - 1:])
    require(rest.startswith("/--"), "native source docstring position differs: " + name)
    source_doc, closing, rest = rest.partition("-/")
    require(bool(closing) and source_doc[3:].strip() == doc.strip(),
            "native docstring/source mismatch: " + name)
    declaration = re.search(r"(?m)^\s*(?:(?:noncomputable|private|protected)\s+)?"
                            r"(def|lemma|theorem|instance|abbrev)\s+(\S+)", rest)
    require(declaration is not None and declaration.group(2) == name.rsplit(".", 1)[-1]
            and declaration.group(1) == kind and "/--" not in rest[:declaration.start()],
            "native source/name/kind position differs: " + name)


def check_snapshot(revision, sources):
    require(revision == SOURCE, "unexpected/stale analyzed source revision")
    require(set(sources) == set(SOURCE_INPUT_SHA256), "source/pin inventory differs")
    for path, expected in SOURCE_INPUT_SHA256.items():
        require(digest(sources[path]) == expected, "source/pin drift from analyzed input: " + path)


def validate(records, raw_records, sources, revision):
    check_snapshot(revision, sources)
    require(set(records) == set(raw_records) == set(MODULES), "native module inventory differs")
    sections = {"production": [], "clients": []}
    all_names = set()
    for module in MODULES:
        record = records[module]
        require(json.loads(raw_records[module]) == record, "native record bytes/JSON differ: " + module)
        require(type(record) is dict and set(record) == {"name", "declarations", "instances", "imports"},
                "native module shape differs: " + module)
        require(record["name"] == module, "native module name differs: " + module)
        require(type(record["declarations"]) is list and
                len(record["declarations"]) == len(EXPECTED[module]),
                "missing/extra native declaration: " + module)
        require(type(record["instances"]) is list and not record["instances"] and
                type(record["imports"]) is list, "unexpected native instance/import surface: " + module)
        path = module.replace(".", "/") + ".lean"
        names = set()
        for row in record["declarations"]:
            require(type(row) is dict and set(row) == {"info", "header"} and
                    type(row["info"]) is dict, "native declaration shape differs: " + module)
            info = row["info"]
            require(set(info) == {"name", "kind", "doc", "docLink", "sourceLink", "line"},
                    "native declaration info shape differs: " + module)
            name, kind = info["name"], info["kind"]
            require(type(name) is str and type(kind) is str and
                    kind in {"def", "theorem"} and name.startswith(module.split(".")[0] + "."),
                    "wrong native name/kind: " + str(name))
            require(name not in names and name not in all_names,
                    "duplicate native declaration: " + name)
            names.add(name)
            all_names.add(name)
            require(type(info["doc"]) is str and type(row["header"]) is str,
                    "malformed native doc/header: " + name)
            require(info["sourceLink"] == "https://example.invalid/commit/" + revision + "/" + path,
                    "native source module/revision/path differs: " + name)
            require(info["docLink"] == "./" + module.replace(".", "/") + ".html#" + name,
                    "native self link differs: " + name)
            require(bool(info["doc"]) and "```" not in info["doc"] and
                    re.search(r"<\s*[/!?a-zA-Z]", info["doc"]) is None,
                    "missing/active native source docstring: " + name)
            source_anchor(sources[path], info["line"], name, kind, info["doc"])
            header = Header(row["header"])
            visible_kind = "".join(header.kinds)
            text = header.rendered()
            require(visible_kind == ("noncomputable def" if kind == "def" else "theorem") and
                    "".join(header.names) == name and
                    text.startswith(visible_kind + " " + name + " ") and
                    "```" not in text and "<script" not in text.lower(),
                    "native signature identity/format differs: " + name)
            for binder in KEY_TOKENS.get(name, ()):
                require(binder in text, "missing signature binder: " + name + " / " + binder)
            sections["clients" if module.startswith("NormFormsTests") else "production"].append(
                dict(name=name, kind=kind, path=path, line=info["line"],
                     signature=text, doc=info["doc"].strip()))
        require(names == {module.split(".")[0] + "." + short for short in EXPECTED[module]},
                "missing/extra/wrong native name: " + module)
        require(digest(raw_records[module]) == NATIVE_RECORD_SHA256[module],
                "native raw record differs from pinned tool/input: " + module)
    require({row["name"] for row in sections["production"] if row["kind"] == "def"} == DEFINITIONS and
            len(sections["production"]) == 18 and len(sections["clients"]) == 11,
            "mixed production/client/definition inventory differs")
    return sections


def render(records, raw_records, sources, revision):
    sections = validate(records, raw_records, sources, revision)
    lines = ["# Native API reference", "",
             "Pinned Lean `v4.34.0-rc2`, mathlib `e37d88a26f3791ed5a93daa1f949af1021b8d103`",
             "and separately pinned doc-gen4 `" + TOOL + "`. Full displayed signatures",
             "retain implicit binders, typeclasses and universe parameters.", "",
             "The six shipped Lean modules have 18 production entries (four exposed",
             "noncomputable definitions and 14 theorems) and 11 checked-use client",
             "theorems. The reexport root, axiom-print module and test root have zero",
             "new native rows. There are no named/generated/anonymous instance rows",
             "in these filtered native records. Private helpers and compiler-generated",
             "proof bodies are **not** enumerated here; this is not an axiom census,",
             "proof recheck, rights clearance, source-coverage or release certificate.",
             "[Reproduction and limitations](README.md).", "",
             "Each entry reproduces its **original native source docstring** and has a",
             "relative anchor into the analyzed `.lean` source. No catalogue prose",
             "is substituted for missing documentation; these records have none.", ""]
    for section, heading in (("production", "Production API (18 entries)"),
                             ("clients", "Checked-use clients (11 entries)")):
        lines.extend(["## " + heading, ""])
        for row in sorted(sections[section], key=lambda item:
                          (MODULES.index(item["path"].removesuffix(".lean").replace("/", ".")),
                           item["line"], item["name"])):
            lines.extend(["### " + row["name"], "", "Kind: `" + row["kind"] + "`.", "",
                          "```lean", row["signature"], "```", "",
                          "**Native source docstring:** " + row["doc"], "",
                          f"[Source](../{row['path']}#L{row['line']}) (native source start line).", ""])
    markdown = "\n".join(lines).encode("utf-8")
    manifest = dict(format=2, generator="scripts/generate_api.py", docgen_revision=TOOL,
                    analyzed_source_revision=SOURCE, analyzed_source_tree=SOURCE_TREE,
                    modules=list(MODULES), inputs=SOURCE_INPUT_SHA256,
                    native_record_sha256=NATIVE_RECORD_SHA256,
                    normalized_record_sha256={module: digest(json.dumps(records[module],
                            ensure_ascii=False, sort_keys=True, separators=(",", ":")).encode("utf-8"))
                            for module in MODULES},
                    production_declarations=[row["name"] for row in sections["production"]],
                    public_client_declarations=[row["name"] for row in sections["clients"]],
                    exposed_definitions=sorted(DEFINITIONS), instance_declarations=[],
                    undocumented_count=0, api_sha256=digest(markdown),
                    proof_certification=False, release_acceptance=False)
    return markdown, (json.dumps(manifest, indent=2, sort_keys=True) + "\n").encode("utf-8")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--native-data", type=Path, required=True)
    parser.add_argument("--source-revision", required=True)
    parser.add_argument("--docgen-revision", required=True)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    require(args.docgen_revision == TOOL, "unexpected/stale doc-gen4 revision")
    root = Path(__file__).resolve().parent.parent
    sources = {}
    for path in SOURCE_INPUT_SHA256:
        source_path = root / path
        require(source_path.is_file() and not source_path.is_symlink(), "missing/linked source input: " + path)
        sources[path] = source_path.read_bytes()
    check_snapshot(args.source_revision, sources)
    require(args.native_data.is_dir() and not args.native_data.is_symlink(), "native data directory absent/linked")
    expected_files = {"declaration-data-" + module + ".bmp" for module in MODULES}
    require({path.name for path in args.native_data.iterdir()} == expected_files,
            "missing/extra native record file")
    raw_records = {}
    records = {}
    for module in MODULES:
        path = args.native_data / ("declaration-data-" + module + ".bmp")
        require(path.is_file() and not path.is_symlink(), "missing/linked native record: " + module)
        raw_records[module] = path.read_bytes()
        records[module] = json.loads(raw_records[module])
    api, manifest = render(records, raw_records, sources, args.source_revision)
    for name, raw in (("API.md", api), ("api-manifest.json", manifest)):
        target = root / "docs" / name
        if args.check:
            require(target.is_file() and target.read_bytes() == raw,
                    "generated file differs/stale manifest: " + name)
        else:
            require(not target.is_symlink(), "linked output refused: " + name)
    if not args.check:
        (root / "docs" / "API.md").write_bytes(api)
        (root / "docs" / "api-manifest.json").write_bytes(manifest)
    print(json.dumps(dict(status="matched" if args.check else "generated", production=18,
                          clients=11, definitions=4, instances=0, api_sha256=digest(api),
                          proof_certification=False, release_acceptance=False)))


if __name__ == "__main__":
    main()
