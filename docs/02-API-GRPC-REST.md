
# RepairMesh — API gRPC + REST

## 1) Objectif
Permettre le pilotage des agents :
- diagnostic
- exécution plan
- récupération résultats
- création bundle support
- audit

Transport :
- gRPC (principal)
- REST (miroir simplifié)

## 2) Authentification
- Localhost : auth Windows ou token local
- Mesh : mTLS ou token support TTL court

## 3) Endpoints REST principaux
- GET /v1/health
- GET /v1/agent
- POST /v1/diagnose
- POST /v1/execute
- GET /v1/jobs/{id}
- POST /v1/bundles
- POST /v1/support/notify
- GET /v1/audit

Fail-Closed :
> Si le moteur Rust refuse ⇒ HTTP 403 POLICY_DENY
