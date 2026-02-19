#!/usr/bin/env bash
set -euo pipefail

required_dirs=(
  apps/api-gateway
  apps/diagnostic-engine
  apps/repair-orchestrator
  services/device-connector
  services/telemetry
  packages/shared-types
  packages/shared-utils
  infra/docker
  infra/k8s
  scripts
  tests
  docs/templates
)

required_docs=(
  README.md
  AGENTS.md
  docs/00-ARCHITECTURE.md
  docs/01-IPC-CONTRACT.md
  docs/02-API-GRPC-REST.md
  docs/10-PROJECT-STRUCTURE.md
  docs/11-AGENT-WORKFLOW.md
  docs/12-PROGRESS-TRACKER.md
)

required_module_readmes=(
  apps/api-gateway/README.md
  apps/diagnostic-engine/README.md
  apps/repair-orchestrator/README.md
  services/device-connector/README.md
  services/telemetry/README.md
  packages/shared-types/README.md
  packages/shared-utils/README.md
  infra/docker/README.md
  infra/k8s/README.md
  scripts/README.md
  tests/README.md
)

for dir in "${required_dirs[@]}"; do
  if [[ ! -d "$dir" ]]; then
    echo "[ERROR] Missing required directory: $dir"
    exit 1
  fi
done

for file in "${required_docs[@]}" "${required_module_readmes[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "[ERROR] Missing required file: $file"
    exit 1
  fi
done

echo "[OK] Project structure checks passed."
