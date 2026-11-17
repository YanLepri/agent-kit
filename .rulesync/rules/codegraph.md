---
root: true
targets: ["*"]
description: "Initialize CodeGraph in the project and query the index before exploring code"
globs: ["**/*"]
---

# CodeGraph

Before searching for a symbol, call, file, or structure in this project, use CodeGraph.

1. If the project root has no `.codegraph/` directory, run `codegraph init -y` there and wait for the index to finish.
2. Query the index through the `codegraph` MCP server, passing the project path. If the MCP server does not respond, run `codegraph explore` in the terminal.
3. Use Grep and file reads only for what the index does not cover, or when `codegraph` is not installed.
