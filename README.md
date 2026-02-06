# free-the-claw

A self-hosted AI chat setup using [openclaw](https://github.com/openclaw/openclaw) with free NVIDIA NIM models via [claude-code-free](https://github.com/Alishahryar1/claude-code-free).

## Quick Start

1. Get a free NVIDIA NIM API key from https://build.nvidia.com/settings/api-keys

2. Clone the repo:
   ```
   git clone --recurse-submodules https://github.com/polats/free-the-claw.git
   cd free-the-claw
   ```

3. Copy the example env file and add your API key:
   ```
   cp .env.example .env
   ```
   Edit `.env` and set your API key and model:
   ```
   NVIDIA_NIM_API_KEY=your-key-here
   MODEL=stepfun-ai/step-3.5-flash
   ```

4. Start the services:
   ```
   docker compose up -d
   ```

5. Open http://localhost:18789/?token=changeme in your browser.

## Configuration

- **Model**: Change `MODEL` in `.env` (default: `stepfun-ai/step-3.5-flash`)

Popular choices:

- `stepfun-ai/step-3.5-flash`
- `moonshotai/kimi-k2.5`
- `z-ai/glm4.7`
- `minimaxai/minimax-m2.1`
- `mistralai/devstral-2-123b-instruct-2512`

See [`Claude Code Free`](claude-code-free/README.md) to add more models.

- **Gateway token**: Change `OPENCLAW_GATEWAY_TOKEN` in `docker-compose.yml` (default: `changeme`)

- **Ports**: claude-code-free runs on `8082`, openclaw on `18789`

## Agent Persona (optional)

Give your agent a personality by loading a [SOUL.md](https://github.com/urtimus-prime/soul.md) file at startup. Add one of the following to your `.env`:

**From a GitHub profile README** (the `username/username` repo):
```
GITHUB_SOUL_USER=voxxelle
```

**From any URL** (raw markdown file):
```
SOUL_URL=https://raw.githubusercontent.com/your-org/your-repo/main/SOUL.md
```

If both are set, `GITHUB_SOUL_USER` takes priority. The file is fetched on every container start and written to the agent's workspace as `SOUL.md`, which openclaw automatically injects into the agent's system prompt.
