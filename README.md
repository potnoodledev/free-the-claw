# free-the-claw

A self-hosted AI chat setup using [openclaw](https://github.com/openclaw/openclaw) with free NVIDIA NIM models via [claude-code-free](https://github.com/Alishahryar1/claude-code-free).

## Quick Start

1. Get a free NVIDIA NIM API key from https://build.nvidia.com/settings/api-keys

2. Clone the repo:
   ```
   git clone --recurse-submodules https://github.com/polats/free-the-claw.git
   cd free-the-claw
   ```

3. Set your API key in `docker-compose.yml`:
   ```
   NVIDIA_NIM_API_KEY=your-key-here
   ```

4. Start the services:
   ```
   docker compose up -d
   ```

5. Open http://localhost:18789/?token=changeme in your browser.

## Configuration

- **Model**: Change `MODEL` in `docker-compose.yml` (default: `moonshotai/kimi-k2-thinking`)
- **Gateway token**: Change `OPENCLAW_GATEWAY_TOKEN` in `docker-compose.yml` (default: `changeme`)
- **Ports**: claude-code-free runs on `8082`, openclaw on `18789`
