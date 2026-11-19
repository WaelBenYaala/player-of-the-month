from pyinfra.operations import server

server.shell(
    name="Pull de la derniere image",
    commands=[
        "docker pull localhost:5000/player-of-the-month:latest",
    ],
)

server.shell(
    name="Arreter l ancien conteneur",
    commands=[
        "docker stop player-of-the-month-app-1 || true",
        "docker rm player-of-the-month-app-1 || true",
        "docker stop player-of-the-month-app || true",
        "docker rm player-of-the-month-app || true",
    ],
)

server.shell(
    name="Demarrer le nouveau conteneur",
    commands=[
        "docker run -d --name player-of-the-month-app -p 3000:3000 --restart unless-stopped localhost:5000/player-of-the-month:latest",
    ],
)