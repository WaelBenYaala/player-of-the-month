# Player of the Month — Projet DevOps

Dépôt du projet : https://github.com/WaelBenYaala/player-of-the-month

## Architecture
- **Application** : Laravel (PHP) exposant le endpoint `/health`
- **Conteneurisation** : Docker & Docker Compose (`Dockerfile`, `docker-compose.yml`)
- **CI/CD** : GitHub & GitHub Actions avec runner auto-hébergé (`DESKTOP-O6U0P6A`)
- **Registre Docker local** : `localhost:5000` (`localhost:5000/player-of-the-month:latest`)
- **Déploiement automatisé** : `pyinfra` (`deploy.py`)
- **Supervision** : Uptime Kuma (`http://localhost:3001`) surveillant l'application sur le port `3000`

## Flux du pipeline
1. Création d'une branche `feature/...` et push sur GitHub
2. Ouverture d'une Pull Request et exécution des vérifications CI via le runner `DESKTOP-O6U0P6A`
3. Fusion (`merge`) vers `main` avec construction et poussée de l'image vers `localhost:5000`
4. Récupération de l'image et déploiement/redémarrage du conteneur (`pyinfra` / Docker)
5. Surveillance continue de la disponibilité de l'application dans Uptime Kuma

## Comment exécuter
### Lancer en local avec Docker Compose
```bash
docker compose up -d --build