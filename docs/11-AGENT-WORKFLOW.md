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
