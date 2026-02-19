# AGENTS.md - Guide de collaboration pour agents IA

## Objectif
Ce dépôt est préparé pour un développement incrémental par plusieurs agents IA (et humains).  
Le but est de **réduire les conflits**, **améliorer la traçabilité**, et **standardiser les livrables**.

## Règles de contribution
1. Travailler par lot de changements petits et atomiques.
2. Mettre à jour la documentation impactée dans le même commit.
3. Toujours renseigner l'avancement dans `docs/12-PROGRESS-TRACKER.md`.
4. Si une décision technique est prise, l'ajouter dans `docs/11-AGENT-WORKFLOW.md` (section Journal des décisions).
5. Respecter l'arborescence décrite dans `docs/10-PROJECT-STRUCTURE.md`.

## Convention de branches
- `feat/<scope>-<short-description>`
- `fix/<scope>-<short-description>`
- `docs/<scope>-<short-description>`
- `chore/<scope>-<short-description>`

## Convention de commit
Format recommandé:
- `feat(scope): description`
- `fix(scope): description`
- `docs(scope): description`
- `chore(scope): description`

## Checklist avant PR
- [ ] Structure des dossiers respectée.
- [ ] Fichiers Markdown de suivi mis à jour.
- [ ] TODO et prochaines étapes explicites.
- [ ] Impacts architecture/API documentés si nécessaire.
