
# RepairMesh — IPC Contract (Go Agent ⇄ Rust Engine) — NDJSON

## 1) Transport
- Communication via STDIN / STDOUT
- Format : NDJSON (1 JSON par ligne)
- STDERR réservé aux logs engine

Règle : si engine indisponible ⇒ refus exécution (fail-closed).

## 2) Enveloppe standard

### Request
```json
{
  "request_id": "req_1",
  "op": "ValidatePlan",
  "version": "1.0",
  "payload": {}
}
```

### Response
```json
{
  "request_id": "req_1",
  "ok": true,
  "error": null,
  "payload": {}
}
```

### Error
```json
{
  "code": "POLICY_DENY",
  "message": "Action denied by policy",
  "details": {"action_id":"win.reset_network"}
}
```

## 3) Opérations IPC (MVP)
- EngineInfo
- VerifySignature
- ValidateAction
- ValidatePlan
- BuildBundle
- HashFiles

Chaque opération retourne decision ALLOW/DENY et consentement requis.
