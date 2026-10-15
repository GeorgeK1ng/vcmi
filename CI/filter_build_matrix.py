#!/usr/bin/env python3

import json
import os


def is_enabled(group: str) -> bool:
    return os.environ[f"BUILD_{group.upper()}"] == "true"


matrix = json.loads(os.environ["BUILD_MATRIX"])
matrix["include"] = [entry for entry in matrix["include"] if is_enabled(entry["group"])]

if not matrix["include"]:
    raise SystemExit("At least one build platform must be enabled")

with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as output:
    output.write(f"matrix={json.dumps(matrix, separators=(',', ':'))}\n")
