# 🚀 Guia Consolidado: Configuração de Ambientes e Ferramentas

Este documento consolida tudo o que foi instalado, configurado e testado no seu ambiente de desenvolvimento Windows durante o chat **"Configuração De Ambiente E Ferramentas"**.

Tanto você (no terminal) quanto o **Antigravity (o agente)** possuem acesso total e imediato a todas essas ferramentas e skills.

---

## 📋 1. Resumo Executivo das Camadas

```
┌────────────────────────────────────────────────────────────────────────┐
│                        ANTIGRAVITY IA & AGENTES                        │
│   web-app-architect │ backend-system-architect │ desktop-mobile-apps   │
│   automation-tool   │ code-quality-standards   │ animation-engineering │
├────────────────────────────────────────────────────────────────────────┤
│                       FERRAMENTAS DE ALTA PERFORMANCE                  │
│       uv (Python)   │    Bun & pnpm (JS/TS)   │   ripgrep & fd (Busca) │
│       jq (JSON)     │    bat (Syntax Cat)     │   LazyGit (Git TUI)    │
│       tldr (Help)   │    ruff (Linter/Format) │   cloudflared (Tunnel) │
├────────────────────────────────────────────────────────────────────────┤
│                       BASE DO SISTEMA E SHELL                          │
│   PowerShell 7 (pwsh) com Perfil Inteligente e Atalhos Automáticos     │
│   Git Blindado: quebras de linha LF (`autocrlf=input`) e caminhos 260+ │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 🛠️ 2. Ferramentas Globais Instaladas

### ⚡ JavaScript, TypeScript & Frontend
* **`Bun` (v1.4.4)**: Runtime ultrarrápido em Zig/C++. Executa TypeScript sem compilação:
  ```bash
  bun run script.ts
  bun add <pacote>
  ```
* **`pnpm` (v12.18.0)**: Gerenciador com economia de disco via hardlinks.
  ```bash
  pnpm create vite meu-app --template react-ts
  pnpm install
  ```
* **`tsx` (v4.23.15)**: Executor imediato de arquivos `.ts` diretamente no Node.js.
* **`serve` (v14.2.7)**: Servidor estático local leve para pré-visualização de builds.
* **`yarn` (v1.22.22)**: Gerenciador de pacotes clássico.

### 🐍 Python, Backend & Automação
* **`uv` (v0.13.8)**: O gerenciador de pacotes e ambientes Python mais veloz do mercado (feito em Rust).
  ```bash
  uv venv .venv
  uv pip install fastapi uvicorn
  uv run script.py
  ```
* **`ruff` (v0.15.5)**: Linter e formatador Python ultrarrápido (substitui Black, Flake8 e isort).
  ```bash
  ruff check .
  ruff format .
  ```
* **Bibliotecas Python Globais:**
  * `fastapi` + `uvicorn[standard]`: Criação de APIs assíncronas com documentação Swagger automática (`/docs`).
  * `pydantic`: Validação estrita de esquemas e dados.
  * `sqlalchemy`: ORM para banco de dados relacional (SQLite, PostgreSQL).
  * `typer` + `rich`: Criação de ferramentas CLI profissionais com tabelas, barras de progresso e cores.
  * `httpx` + `requests`: Clientes HTTP para chamadas a APIs e webhooks.
  * `pytest`: Testes automatizados.
  * `mkdocs` + `mkdocs-material`: Gerador de documentações elegantes em Markdown.
  * `httpie` (`http`): Cliente HTTP interativo para testar APIs no terminal.

### 🔍 Produtividade, Busca & Terminal
* **`ripgrep` (`rg` v14.1.1)**: Mecanismo de busca textual e código mais rápido do mundo.
  ```bash
  rg "minhaFuncao"
  rg "SELECT" --type py
  ```
* **`fd` (v10.2.0)**: Alternativa rápida e intuitiva ao `find` para localizar arquivos e pastas.
  ```bash
  fd "\.tsx$"
  fd "auth"
  ```
* **`bat` (v0.25.0)**: O `cat` moderno com numeração de linhas e destaque de sintaxe colorido.
  ```bash
  bat package.json
  bat main.py
  ```
* **`jq` (v1.7.1)**: Formatador e filtro cirúrgico de JSON.
  ```bash
  cat dados.json | jq .items[0]
  ```
* **`lazygit` (v0.44.1)**: Interface gráfica TUI completa para Git dentro do terminal.
  ```bash
  lazygit
  # ou pelo atalho rápido:
  lg
  ```
* **`tldr`**: Manual comunitário instantâneo com os comandos mais usados do mundo.
  ```bash
  tldr docker
  tldr git commit
  tldr curl
  ```
* **`cloudflared`**: Criação de túneis HTTPS instantâneos para expor portas locais na internet.
  ```bash
  tunnel 8000
  ```
* **`sqlite3`**: Cliente interativo para bancos locais `.db` e `.sqlite`.
* **`get-gitignore`**: Baixa `.gitignore` oficial do GitHub blindado contra vazamento de credenciais.
  ```bash
  get-gitignore node react vite
  get-gitignore python
  ```

---

## 💻 3. PowerShell 7 e Atalhos do Perfil

O perfil do PowerShell 7 foi configurado em:
`C:\Users\User\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

### Comandos de Scaffolding Instantâneo:
| Comando | O que gera |
| :--- | :--- |
| **`scaffold-web ./frontend`** | Cria site React 19 + Vite + TypeScript + Tailwind CSS pronto para rodar. |
| **`scaffold-api ./backend "Minha API"`** | Cria API FastAPI completa com SQLite, Pydantic, CORS e Swagger UI. |
| **`scaffold-cli ./ferramenta "Minha CLI"`** | Cria utilitário de terminal com Typer, Rich e comandos estruturados. |

### Atalhos de Produtividade Git & Terminal:
| Atalho | Comando Equivalente | Função |
| :--- | :--- | :--- |
| **`lg`** | `lazygit` | Painel gráfico interativo do Git |
| **`gs`** | `git status -s` | Status resumido dos arquivos |
| **`gl`** | `git log --graph --oneline` | Histórico visual de commits |
| **`gp`** | `git push` | Envia alterações ao repositório remoto |
| **`gpl`** | `git pull` | Puxa alterações remotas |
| **`ll`** | `Get-ChildItem` | Listagem detalhada de arquivos |
| **`la`** | `Get-ChildItem -Force` | Listagem completa incluindo ocultos |
| **`tunnel <porta>`** | `cloudflared tunnel --url ...` | Expõe a porta local via HTTPS na web |

---

## 🧠 4. As 7 Skills Criadas no Antigravity

Localizadas em `C:\Users\User\.gemini\config\skills`:

1. **`web-app-architect`**:
   - Criação de frontends, sites e SPAs modernos (React, Next.js, Vite, Tailwind CSS, Shadcn UI, Radix).
2. **`backend-system-architect`**:
   - APIs REST e WebSockets de alto desempenho com FastAPI ou Node/Hono, modelagem de banco SQLite/Postgres e middlewares.
3. **`desktop-mobile-apps`**:
   - Apps desktop multiplataforma com **Tauri** (Rust + Web) e aplicativos móveis Android nativos com Jetpack Compose.
4. **`automation-tool-builder`**:
   - Utilitários de linha de comando (CLI) com Typer e Rich, scrapers e scripts em lote executáveis diretamente.
5. **`code-quality-standards`**:
   - Padrões de código limpo baseados em repositórios de ponta do GitHub: Clean Architecture, Conventional Commits, tipagem estrita e segurança OWASP.
6. **`animation-engineering`**:
   - Animações fluidas a 60/120fps aceleradas por GPU (Framer Motion, CSS Motion, GSAP).
7. **`desktop-pointer`**:
   - Orientação visual com cursor na tela e automação assistida na interface gráfica do Windows.

---

## 🔒 5. Blindagem do Git e Sistema

* **Quebras de Linha (`core.autocrlf = input`)**: Evita conflitos de CRLF/LF em projetos compartilhados entre Windows e Linux.
* **Caminhos Longos (`core.longpaths = true`)**: Elimina o limite de 260 caracteres do Windows para árvores profundas como `node_modules`.

---

## 📂 Arquivos no Projeto `melhorias`

* [CONFIGURACAO_AMBIENTES.md](file:///e:/projetos/melhorias/CONFIGURACAO_AMBIENTES.md): Este guia completo de referência.
* [HISTORICO_CHAT_CONFIGURACAO.md](file:///e:/projetos/melhorias/HISTORICO_CHAT_CONFIGURACAO.md): Transcrição na íntegra de toda a conversa e decisões tomadas no chat original.
