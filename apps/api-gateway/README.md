# api-gateway

Passerelle API HTTP (bootstrap) pour RepairMesh.

## Endpoints MVP
- `GET /v1/health` → état du service.
- `GET /v1/agent` → informations minimales de l'agent.

## Exécution locale
```bash
cd apps/api-gateway
go run .
```

Port par défaut: `7444` (surcharge via `PORT`).

## Tests
```bash
cd apps/api-gateway
go test ./...
```
