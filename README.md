# agent-kit

Precisa do Rulesync na máquina: `npm install -g rulesync`. Também Node.js 22, pnpm, o comando `codegraph` no PATH, Docker em execução (SonarQube) e Chrome (DevTools e a extensão Browser MCP).

Exporte no ambiente:

```bash
export GITHUB_TOKEN='seu-token'
export PENPOT_MCP_URL='https://url-do-servidor/mcp/stream'
export PENPOT_USER_TOKEN='sua-chave'
export SONARQUBE_URL='https://seu-sonarqube'
export SONARQUBE_TOKEN='seu-user-token'
export POSTGRES_MCP_CONNECTION_STRING='postgresql://usuario:senha@host:5432/banco?sslmode=require'
```

Na raiz do repositório:

```bash
./generate.sh
```

O `generate` substitui os servidores MCP em `~/.cursor/mcp.json` e em `~/.claude.json`. Servidor que existir só nesses arquivos some.

## O que isso entrega

Subagentes, um por tipo de trabalho:

| Nome                    | Entrega                                              |
| ----------------------- | ---------------------------------------------------- |
| `spec-writer`           | Entrevista, afia a ideia e grava README e ADR        |
| `behavior-specifier`    | Comportamento em Gherkin, arquivo `.feature`         |
| `domain-modeler`        | Modelo de domínio (contextos, agregados, eventos)    |
| `data-modeler`          | Schema, DBML, armazenamento                          |
| `diagram-writer`        | Diagrama Mermaid                                     |
| `api-contract-designer` | Spec OpenAPI                                         |
| `api-tester`            | Teste em arquivo `.http` com httpyac                 |
| `ui-builder`            | Tela com shadcn/ui e Penpot                          |
| `design-reviewer`       | Crítica de tela e acessibilidade, sem editar         |
| `architecture-reviewer` | Revisão de arquitetura, sem editar                   |
| `code-reviewer`         | Revisão de código, sem editar                        |
| `refactoring-engineer`  | Refatoração sem mudar o comportamento                |
| `resilience-reviewer`   | Timeout, retry e prontidão para produção, sem editar |
| `commit-writer`         | Mensagem no padrão Conventional Commits              |

Skills ficam disponíveis na conta. O agente carrega a que combina com o pedido. Três valem em qualquer conversa, sem subagente: `test-driven-development`, `brainstorming` e `context-engineering`. O kit de UX instala skills a mais (`brandkit`, `figma-integration`, `ship` e outras). Os subagentes de tela usam só uma parte.

Servidores MCP:

| Servidor        | Para quê                                              |
| --------------- | ----------------------------------------------------- |
| codegraph       | Índice do código do projeto aberto                    |
| deepwiki        | Documentação de repositório público                   |
| rulesync        | Consultar e gerar esta configuração                   |
| penpot          | Ler design no Penpot                                  |
| sonarqube       | Issues, qualidade e cobertura. Exige Docker           |
| shadcn          | Componentes do registro shadcn/ui                     |
| atlassian       | Jira e Confluence. O login é no cliente               |
| trello          | Quadros, listas e cartões. O login é no cliente       |
| gitlab          | Issues, merge requests e CI. O login é no cliente     |
| postgres        | Consultar o banco da `POSTGRES_MCP_CONNECTION_STRING` |
| playwright      | Teste de browser                                      |
| chrome-devtools | Inspecionar uma página no Chrome                      |
| browsermcp      | Abrir, clicar e preencher no Chrome em que você está logado |
| robotmcp        | Executar keywords ao vivo e gravar a suíte `.robot`. Exige uv |

## Como usar

1. Deixe as variáveis acima disponíveis no ambiente. O terminal que roda o script precisa de todas.
2. Rode `./generate.sh` e reinicie o Cursor e o Claude Code.
3. Peça o trabalho na conversa. "Revisa esse código" chama o `code-reviewer`. "Faz o commit" chama o `commit-writer`. Para escolher um, cite o nome.
4. Skill não se chama à parte. "Escreve o `.http` desse endpoint" já usa `httpyac`.
5. MCP também entra pelo pedido. "Olha esse issue no Sonar" usa o `sonarqube`. Atlassian e GitLab pedem login na primeira vez.
6. A rule do CodeGraph vale em todo projeto. Sem a pasta `.codegraph/` na raiz, o agente roda `codegraph init -y` e passa a consultar o índice antes de vasculhar o código.

## Browser MCP

O servidor `browsermcp` dirige o Chrome, o Edge ou o Brave em que você já está logado. O agente abre páginas, clica e preenche formulários em abas próprias. Você vê essas abas e para o agente pelo popup da extensão.

1. Instale a [extensão Browser MCP](https://chromewebstore.google.com/detail/browser-mcp-let-ai-use-yo/bjfgambnhccakkhmkepdoekmckoijdlc) e fixe o ícone na barra de ferramentas.
2. Rode `./generate.sh` e reinicie o Cursor e o Claude Code. Até um dos dois subir o servidor, o popup diz "Waiting for the Browser MCP server".
3. Peça para abrir uma página. A primeira resposta traz um código de seis dígitos.
4. Clique no ícone da extensão. O popup mostra um código. Ele precisa ser o mesmo da última mensagem do agente. Confira e clique em Allow. Esse clique vale para este computador.
5. Peça de novo. O popup passa a dizer "Connected to the Browser MCP server".

Se o código do popup for outro, peça de novo e compare o código novo antes de clicar em Allow. O guia completo está em [browsermcp.io/docs](https://browsermcp.io/docs).

## Robot Framework

A configuração segue a [página oficial](https://robotframework.org/ai). A skill `robotcode` ensina o agente a consultar keywords, rodar testes e ler o resultado com o CLI do projeto. As demais vêm do [MarketSquare](https://github.com/MarketSquare/robotframework-plugins): `rf-language`, `rf-setup`, `rf-python-library`, `rf-bdd`, `rf-browser`, `rf-selenium`, `rf-requests`, `rf-restinstance`, `rf-appium` e `rf-platynui`.

No projeto de teste, instale o CLI:

```bash
pip install "robotcode[all]"
```

O servidor `robotmcp` executa keywords ao vivo e grava a suíte `.robot`. A máquina precisa de `uv` e Python 3.10 ou mais. Na primeira vez com a Browser Library, rode `robotmcp init --browsers`.
