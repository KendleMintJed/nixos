#!/usr/bin/env python3
import json
import sys
import uuid

src, dst = sys.argv[1:3]

with open(src) as f:
    items = json.load(f)

storage = {
    # Required for Stylus to read style-N entries from extension storage.
    "dbInChromeStorage": True,
}

style_id = 1

for item in items:
    # Catppuccin's first object contains Stylus preferences.
    if "name" not in item and "settings" in item:
        storage["settings"] = item["settings"]
        continue

    style = dict(item)
    style["id"] = style_id
    style.setdefault(
        "_id",
        str(uuid.uuid5(
            uuid.NAMESPACE_URL,
            "stylus:" + str(
                style.get("originalDigest")
                or style.get("updateUrl")
                or style.get("name")
                or style_id
            ),
        )),
    )

    storage[f"style-{style_id}"] = style
    style_id += 1

with open(dst, "w") as f:
    json.dump(storage, f, indent=2)
    f.write("\n")
