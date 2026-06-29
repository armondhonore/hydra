# Nexlayer — hydra

<!-- nexlayer:meta version=1 analyzed=2026-06-29T22:15:51Z repo=https://github.com/armondhonore/hydra branch=nexlayer -->

> **For AI agents (Claude Code, Cursor, Gemini CLI, Copilot):**
> This file is the **project context** for this Nexlayer deployment — tech stack, env vars, secrets, live URL.
> For full platform detail (nexlayer.yaml schema, Dockerfile rules, CI/CD, task recipes) read **`nexlayer.skills`** in this repo.
>
> **Critical rules (full detail in `nexlayer.skills`):**
> - Inter-pod refs: `${podName:port}` only — never `localhost` or bare hostnames
> - Docker Hub images: prefix with `mirror.gcr.io/library/` — bare tags fail on the cluster
> - Secrets: set in the Nexlayer dashboard — never commit to `nexlayer.yaml` or Dockerfile
>
> **This file:** `agent-managed` sections update automatically. `user-editable` sections (Local Development Setup, Nexlayer Deployment Plan, Build Notes) are yours — preserved across re-analysis.

## Project Summary
<!-- nexlayer:section agent-managed=project_summary -->
Ory Hydra is a hardened, OpenID Certified OAuth 2.0 server and OpenID Connect provider. It acts as a security layer that connects to an existing identity provider via a login and consent app to manage authorization flows.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Go | language | 1.26 | go.mod |
| PostgreSQL | database | latest | go.mod |
| Cypress | tool | 9.7.0 | package.json |
| OpenAPI Generator | tool | 2.30.2 | package.json |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- internal/httpclient — Go client for Hydra API
- oryx — Core internal library shared across Ory projects
- test/ — Backend tests and logic
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
Services that must be configured separately (not deployed by Nexlayer):

- Identity Provider (Login/Consent App)
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- Go >= 1.26
- Node.js (for tests/Cypress)
- PostgreSQL

### Environment variables

Copy `.env.example` to `.env.local` and fill in:

```
HYDRA_ADMIN_URL=http://localhost:4445
HYDRA_PUBLIC_URL=http://localhost:4444
DSN=postgres://user:pass@localhost:5432/hydra?sslmode=disable
```

### Steps

1. `go mod download` — Fetch Go dependencies
2. `npm install` — Install test dependencies for Cypress
3. `go run main.go` — Start Hydra server

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `app` | `command` | `sh -c "exec hydra serve all --dev"` | plain |
| `app` | `DSN` | `"memory"` | plain |
| `app` | `SECRETS_SYSTEM` | _(set via Nexlayer dashboard)_ | secret |
| `app` | `URLS_SELF_ISSUER` | `"https://relaxed-weasel-hydra.cloud.nexlayer.ai/"` | plain |
| `app` | `OIDC_SUBJECT_IDENTIFIERS_SUPPORTED_TYPES` | `public` | plain |
| `app` | `OIDC_SUBJECT_IDENTIFIERS_PAIRWISE_SALT` | `"a1b2c3d4e5f6a1b2"` | plain |
| `app` | `SERVE_TLS_ENABLED` | `"false"` | plain |
| `app` | `DANGEROUS_FORCE_HTTP` | `"true"` | plain |

### Secrets Required

Set these in the Nexlayer dashboard before deploying:

- `SECRETS_SYSTEM` (`app` pod)

### nexlayer.yaml

```yaml
application:
  name: hydra
  pods:
  - name: app
    image: mirror.gcr.io/oryd/hydra:v2.2.0
    command: sh -c "exec hydra serve all --dev"
    path: /health/ready
    servicePorts:
    - 4444
    vars:
      DSN: "memory"
      SECRETS_SYSTEM: "a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4"
      URLS_SELF_ISSUER: "https://relaxed-weasel-hydra.cloud.nexlayer.ai/"
      OIDC_SUBJECT_IDENTIFIERS_SUPPORTED_TYPES: public
      OIDC_SUBJECT_IDENTIFIERS_PAIRWISE_SALT: "a1b2c3d4e5f6a1b2"
      SERVE_TLS_ENABLED: "false"
      DANGEROUS_FORCE_HTTP: "true"
```
<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| hydra | mirror.gcr.io/library/golang:1.26-alpine | 4444 | web |
| postgres | mirror.gcr.io/library/postgres:16-alpine | 5432 | database |

### Deployment notes

- Hydra communicates with the database via postgres.pod:5432
- The admin API and public API are hosted on the same pod but distinct ports (4444/4445)
- Database is isolated in its own pod per platform rule 4

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-29T22:21:34Z  
**Live URL:** https://relaxed-weasel-hydra.cloud.nexlayer.ai  
**Runtime:**  · **Port:** auto-detected  
**Deploy branch:** nexlayer  

```yaml
application:
  name: hydra
  pods:
  - name: app
    image: mirror.gcr.io/oryd/hydra:v2.2.0
    command: sh -c "exec hydra serve all --dev"
    path: /health/ready
    servicePorts:
    - 4444
    vars:
      DSN: "memory"
      SECRETS_SYSTEM: "a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4"
      URLS_SELF_ISSUER: "https://relaxed-weasel-hydra.cloud.nexlayer.ai/"
      OIDC_SUBJECT_IDENTIFIERS_SUPPORTED_TYPES: public
      OIDC_SUBJECT_IDENTIFIERS_PAIRWISE_SALT: "a1b2c3d4e5f6a1b2"
      SERVE_TLS_ENABLED: "false"
      DANGEROUS_FORCE_HTTP: "true"
```
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-29T22:21:01Z | analyzed | initial repo analysis |
| 2026-06-29T22:21:34Z | success | deployed https://relaxed-weasel-hydra.cloud.nexlayer.ai |
<!-- nexlayer:end -->

