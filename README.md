# singular-agent

Precisa do Rulesync na máquina: `npm install -g rulesync`. Também Node.js 22, pnpm, o comando `codegraph` no PATH, Docker em execução (SonarQube) e Chrome (DevTools).

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
| postgres        | Consultar o banco da `POSTGRES_MCP_CONNECTION_STRING` |
| playwright      | Teste de browser                                      |
| chrome-devtools | Inspecionar uma página no Chrome                      |

## Como usar

1. Deixe as variáveis acima disponíveis no ambiente. O terminal que roda o script precisa de todas.
2. Rode `./generate.sh` e reinicie o Cursor e o Claude Code.
3. Peça o trabalho na conversa. "Revisa esse código" chama o `code-reviewer`. "Faz o commit" chama o `commit-writer`. Para escolher um, cite o nome.
4. Skill não se chama à parte. "Escreve o `.http` desse endpoint" já usa `httpyac`.
5. MCP também entra pelo pedido. "Olha esse issue no Sonar" usa o `sonarqube`. O Atlassian pede login na primeira vez.
6. A rule do CodeGraph vale em todo projeto. Sem a pasta `.codegraph/` na raiz, o agente roda `codegraph init -y` e passa a consultar o índice antes de vasculhar o código.
