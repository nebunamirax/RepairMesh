# 10 - Structure du projet

## Vue d'ensemble

```text
RepairMesh/
├─ apps/
│  ├─ api-gateway/
│  ├─ diagnostic-engine/
│  └─ repair-orchestrator/
├─ services/
│  ├─ device-connector/
│  └─ telemetry/
├─ packages/
│  ├─ shared-types/
│  └─ shared-utils/
├─ infra/
│  ├─ docker/
│  └─ k8s/
├─ scripts/
├─ tests/
├─ docs/
│  ├─ templates/
│  ├─ 00-ARCHITECTURE.md
│  ├─ 01-IPC-CONTRACT.md
│  ├─ 02-API-GRPC-REST.md
│  ├─ 10-PROJECT-STRUCTURE.md
│  ├─ 11-AGENT-WORKFLOW.md
│  └─ 12-PROGRESS-TRACKER.md
└─ AGENTS.md
```

## Rôle des dossiers
- `apps/`: applications principales déployables.
- `services/`: services secondaires, workers, adaptateurs matériels.
- `packages/`: modules partagés (types, utilitaires, contrats).
- `infra/`: composants d'infrastructure (Docker, Kubernetes, IaC).
- `scripts/`: scripts d'automatisation (setup, lint, release).
- `tests/`: tests d'intégration/e2e globaux.
- `docs/`: documentation fonctionnelle et technique.

## Règles
1. Tout nouveau module doit avoir un `README.md` local.
2. Les interfaces partagées doivent vivre dans `packages/shared-types`.
3. Les conventions de nommage doivent rester cohérentes (kebab-case pour dossiers).
4. Si un dossier est ajouté, mettre à jour ce document.
