# RepairMesh — SPEC (Hybrid Go Agent + Rust Engine)

## 0. Résumé
RepairMesh est un agent de diagnostic et remédiation PC (Windows d’abord) qui :
- collecte des signaux (télémétrie locale),
- détecte des incidents via règles,
- exécute des remédiations automatiques **bornées** (catalogue d’actions),
- demande consentement pour les actions à risque,
- escalade au support si non résoluble (bundle chiffré + notification),
- offre une API **gRPC + REST** (local + mesh) pour pilotage autorisé.

Contraintes :
- Pas de cloud IA (LLM local optionnel, jamais “exécuter ce qu’il invente”).
- Architecture hybride **2 process** : Go (orchestration) + Rust (moteur safety-critical).
- Fail-closed : si l’engine est indisponible, aucune action “dangereuse” ne s’exécute.

## 1. Architecture

### 1.1 Process 1 — repairmesh-agent (Go)
Responsabilités :
- Windows service / daemon
- Collector (light/deep)
- Diagnoser (règles)
- Job queue + exécution plan (après validation engine)
- API serveur gRPC + REST
- Stockage SQLite + logs
- Consentement (UI tray ou prompt minimal)
- Support escalation (bundle request + notify)
- Supervision du process engine (start/health/restart/backoff)

### 1.2 Process 2 — repairmesh-engine (Rust)
Responsabilités :
- Vérification signatures (actions/rules/policy/bundles)
- Validation d’actions/plans (RBAC + allowlists + args + paths + deny registry)
- Construction bundles chiffrés (age) + manifest + hashing
- (Phase 2) redaction PII plus robuste, exécution de steps sensibles possible

### 1.3 Flux principal
1) Collector met à jour signaux dans SQLite
2) Diagnoser évalue règles -> Incident + Plan
3) UI demande consentement si nécessaire
4) Agent appelle Engine ValidatePlan (fail-closed)
5) Agent exécute les steps autorisés (MVP), loggue tout
6) Validation post-action (probes)
7) Si échec -> BuildBundle via engine + NotifySupport

## 2. Sécurité & gouvernance

### 2.1 Non négociable (anti-abus)
- Pas de shell distant libre.
- Pas de “commande arbitraire”.
- Seules les actions du catalogue signé peuvent être exécutées.
- Consentement explicite pour actions à risque.
- Audit complet + traçabilité.
- Support sessions à durée limitée (TTL) + autorisation locale.

### 2.2 Identité
Agent :
- Génère une paire Ed25519 au 1er démarrage
- agent_id = base32(sha256(pubkey))
- Stocke la clé privée dans un emplacement protégé (Windows DPAPI recommandé)

Admin/Support :
- Auth via mesh (mTLS) OU token signé (support session) TTL court.
- REST/gRPC protégés (voir section API security).

### 2.3 RBAC (roles)
- EndUser : diagnostiquer, exécuter low-risk
- Support : medium-risk + bundle + assistance (si autorisé)
- Admin : policies + actions high-risk + config/keys

### 2.4 Consentement
Chaque action définit consent_level :
- NONE, NOTICE, CONFIRM, ELEVATED_CONFIRM
Le consentement est enregistré (SQLite) et audité.

## 3. Données locales

### 3.1 Chemins (Windows)
- DB : C:\ProgramData\RepairMesh\data.db
- Logs : C:\ProgramData\RepairMesh\Logs\
- Bundles : C:\ProgramData\RepairMesh\Bundles\
- Temp : C:\ProgramData\RepairMesh\Temp\

### 3.2 SQLite (schéma MVP)
Voir `docs/IPC.md` pour le schéma recommandé (copiable).

## 4. Catalogue d’actions et règles

### 4.1 Actions (JSON signées)
Emplacement : `assets/actions/*.json`
Champs requis :
- action_id, title, description
- risk_level (LOW/MEDIUM/HIGH)
- consent_level (NONE/NOTICE/CONFIRM/ELEVATED_CONFIRM)
- requires_admin (bool)
- steps[] (types bornés)
- validation[] (probes)
- signature (key_id + sig)

Types de steps MVP autorisés :
- cmd (executable allowlist + args validation)
- service_restart
- powershell_script_ref (script packagé/signé, pas inline)
- file_delete_safe (paths allowlist)
- registry_set_safe (keys allowlist)
- http_probe / dns_probe / ping
- note

Interdits :
- download-and-execute
- execution depuis %TEMP%
- scripts non signés / inline arbitraires

### 4.2 Règles (YAML/JSON)
Emplacement : `assets/rules/*.yaml`
Pipeline :
- Normalisation des signaux -> evaluation -> incident_type -> plan(s)

LLM local optionnel :
- Sert à résumer/classer et choisir un plan parmi ceux proposés
- Ne génère jamais des commandes

## 5. API gRPC + REST

### 5.1 Exposition
- gRPC : port configurable (défaut 7443)
- REST : port configurable (défaut 7444)
- Localhost + interface mesh (config)
- TLS obligatoire sur mesh (mTLS recommandé)

### 5.2 Endpoints gRPC (voir proto)
- Health, GetAgentInfo
- Diagnose
- ExecutePlan
- GetJob, ListJobs
- CreateSupportBundle
- NotifySupport
- GetCatalogInfo (optionnel)
- GetAudit (optionnel, admin/support)

### 5.3 REST (mapping)
REST est un “miroir” simplifié du gRPC.
Exemples :
- GET /v1/health
- GET /v1/agent
- POST /v1/diagnose
- POST /v1/execute
- GET /v1/jobs/{id}
- GET /v1/jobs?limit=50
- POST /v1/bundles
- POST /v1/support/notify
- GET /v1/audit?since=...

### 5.4 Auth & autorisation API
Modes :
- Localhost : Windows auth (SID) ou token local
- Mesh : mTLS (cert support/admin) OU support-session token (TTL)

Règles :
- Diagnose : EndUser+
- ExecutePlan : rôle conforme au risk_level + consentement
- CreateSupportBundle : Support+
- Audit : Admin (ou Support limité selon policy)

## 6. IPC Go <-> Rust Engine

- Communication NDJSON stdin/stdout
- Fail-closed : si engine down, l’agent refuse ExecutePlan (sauf actions “NONE” purement lecture)
- Ops minimales : EngineInfo, VerifySignature, ValidateAction, ValidatePlan, BuildBundle, HashFiles

Voir `docs/IPC.md`.

## 7. Observabilité

Logs JSONL :
- chaque job/action a un correlation id (job_id, incident_id)
Audit log SQLite :
- DIAGNOSE, EXECUTE_REQUESTED, CONSENT_GRANTED, ACTION_STARTED, ACTION_RESULT,
  BUNDLE_CREATED, SUPPORT_NOTIFIED, REMOTE_CALL, POLICY_DENY, ENGINE_DOWN, etc.

## 8. Roadmap

### Phase 1 (MVP entreprise)
- Agent Go service + SQLite + logs + gRPC+REST
- Engine Rust validation + bundle
- 20 actions Windows signées (réseau, spooler, WU basique, cleanup, services)
- Consent UI minimal
- Support notify (email/webhook)

### Phase 2 (durcissement)
- Updates signées
- Tamper protection basique
- Redaction PII avancée
- Migration éventuelle d’exécution steps sensibles côté Rust

### Phase 3 (grand public)
- Onboarding grand public (codes, sessions courtes)
- Mesh indépendant (headscale / relay minimal) ou WebRTC+TURN (à décider)
- Knowledge sharing non sensible (stats fixes) avec anti-abus

## 9. Definition of Done (MVP)
- 5 scénarios résolus automatiquement : DNS/HTTP, Spooler, Windows Update basique, Cleanup temp, Service down
- 0 exécution hors catalogue signé
- consentement respecté
- bundle chiffré généré
- fail-closed si engine indisponible
