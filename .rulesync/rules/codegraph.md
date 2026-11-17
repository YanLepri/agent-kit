---
root: true
targets: ["*"]
description: "Inicializa o CodeGraph no projeto e usa o índice antes de explorar o código"
globs: ["**/*"]
---

# CodeGraph

Antes de procurar símbolo, chamada, arquivo ou estrutura neste projeto, use o CodeGraph.

1. Se a raiz do projeto não tiver `.codegraph/`, rode `codegraph init -y` nessa raiz e espere o índice terminar.
2. Consulte o índice pelo MCP `codegraph`, passando o caminho do projeto. Use `codegraph explore` no terminal se o MCP não responder.
3. Grep e leitura de arquivo ficam para o que o índice não cobrir, ou para quando o `codegraph` não estiver instalado.
