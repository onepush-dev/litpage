# Litpage — self-hosted workspace for pages, databases and AI. Deploy on Railway with one click.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template/TBD)

[Litpage](https://github.com/litmers-dev/litpage) (MIT) is a block editor, databases with a dozen views, real-time
collaboration, REST API/webhooks/MCP and bring-your-own-key AI in one Node.js process with one SQLite file.

This repo packages upstream commit `931cd28` unmodified as `ghcr.io/onepush-dev/litpage:931cd28-r2` (listens on 8080, the port Railway injects).

## What the template sets up
- One service `litpage` on port 8080 with a public domain and health check on `/login`
- A volume at `/data` (SQLite database + uploaded files)
- First account created on boot: `NC_BOOTSTRAP_EMAIL` (default `admin@example.com`) with a generated
  `NC_BOOTSTRAP_PASSWORD` — read it from the service Variables tab and sign in with "Continue with a password"
- `NC_PUBLIC_URL` points at the Railway domain

## Optional
- AI: set `OPENAI_API_KEY` (optionally `OPENAI_BASE_URL`) or `ANTHROPIC_API_KEY`, plus `NC_AI_MODEL`
- Mail (login codes / invitations): `NC_SMTP_URL` and `NC_MAIL_FROM`. Without SMTP, only the password account can sign in.
