# 11 - Workflow de collaboration des agents IA

## Cycle de travail recommandé
1. Lire `README.md`, `AGENTS.md` et les docs techniques pertinentes.
2. Définir une tâche ciblée (scope clair).
3. Implémenter le changement minimal viable.
4. Mettre à jour la documentation et le suivi d'avancement.
5. Proposer les prochaines étapes.

## Modèle de handoff entre agents

```md
## Handoff
- Contexte:
- Changements réalisés:
- Fichiers touchés:
- Décisions prises:
- Risques / points ouverts:
- Prochaine action recommandée:
```

## Journal des décisions (ADR léger)

> Ajouter une entrée à chaque décision structurante.

### Template

```md
### YYYY-MM-DD - Décision: <titre>
- Contexte:
- Options considérées:
- Décision retenue:
- Impacts:
```

## Gouvernance des tâches
- Les tâches en cours et terminées sont suivies dans `docs/12-PROGRESS-TRACKER.md`.
- Une seule personne/agent propriétaire par tâche active.
- Toute tâche bloquée doit inclure un blocage explicite et un besoin d'entrée.

### 2026-02-19 - Décision: CI initiale orientée conformité structure
- Contexte: Le dépôt est en phase de bootstrap et contient surtout une structure cible et de la documentation.
- Options considérées:
  - Mettre en place directement des linters spécifiques (Go/Rust/JS) non encore pertinents.
  - Démarrer par une validation universelle de structure/documents obligatoires.
- Décision retenue: Ajouter un workflow CI minimal qui exécute un script bash de vérification de structure.
- Impacts:
  - Feedback rapide sur les régressions de structure.
  - Base CI simple extensible vers lint/tests applicatifs lors de l'ajout de code.

### 2026-02-19 - Décision: Vertical slice exécutable avant intégration complète agent/engine
- Contexte: Après la CI de structure, il fallait un incrément réellement exécutable pour valider le flux API de base.
- Options considérées:
  - Implémenter immédiatement tout le flux Diagnose/ExecutePlan/IPC.
  - Commencer par une slice minimale testable avec `/v1/health` et `/v1/agent`.
- Décision retenue: Ajouter un API gateway Go minimal avec tests automatiques dans CI.
- Impacts:
  - Réduction du risque d'architecture “papier”.
  - Point d'entrée concret pour brancher ensuite Diagnose, ExecutePlan et le fail-closed IPC.
