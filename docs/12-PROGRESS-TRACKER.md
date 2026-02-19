# 12 - Suivi d'avancement

## Backlog priorisé
| ID | Priorité | Tâche | Propriétaire | Statut | Notes |
|---|---|---|---|---|---|
| RM-001 | Haute | Initialiser le squelette des apps principales | IA | ✅ Fait | Arborescence créée |
| RM-002 | Haute | Définir conventions de collaboration IA | IA | ✅ Fait | `AGENTS.md` + workflow |
| RM-003 | Moyenne | Créer les premiers README par module | IA | ✅ Fait | README présents dans modules clés |
| RM-004 | Moyenne | Définir pipeline CI (lint/test) | IA | ✅ Fait | Workflow GitHub Actions + vérification structure + tests api-gateway |

| RM-005 | Haute | Créer une vertical slice API (`/v1/health`, `/v1/agent`) | IA | ✅ Fait | Implémentation Go + tests unitaires |

## Travail en cours
| Tâche | Propriétaire | Début | Dernière mise à jour | Blocage |
|---|---|---|---|---|
| _Aucune actuellement_ |  |  |  |  |

## Historique des livraisons
| Date | Livrable | Détails |
|---|---|---|
| 2026-02-19 | Structuration initiale du dépôt | Dossiers cibles + documentation de coordination |
| 2026-02-19 | Pipeline CI minimal | Ajout de `.github/workflows/ci.yml` + script `scripts/check-structure.sh` |
| 2026-02-19 | Vertical slice API gateway | Ajout de `apps/api-gateway/main.go` + tests `/v1/health` et `/v1/agent` + job CI Go |
