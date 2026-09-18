# Simple Web Application — CLO835

A small [Flask](https://flask.palletsprojects.com/) application. It exists to show
the same deployment performed two ways: **by hand on a Linux machine**, and
**inside a container image**.

| Item | Version |
|---|---|
| Base image | Ubuntu 26.04 LTS (Resolute Raccoon) |
| Python | 3.14 |
| Flask | 3.1.3 (pinned in `requirements.txt`) |

## The routes

| Path | Answer |
|---|---|
| `/` | `Welcome CLO835!` |
| `/how%20are%20you` | `I am good, how about you?` |

## The port

8080, by hand and in a container. Change it with one variable:
`PORT=9000 python3 app.py`.

## 1. Run it by hand (Ubuntu)

Ubuntu 24.04 and later protect the system Python, so `pip3 install flask`
fails with an `externally-managed-environment` error. A virtual environment is
the correct answer.

```bash
sudo apt-get update -y
sudo apt-get install -y python3 python3-venv

python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt
python3 app.py                       # serves on 8080
```

Test it.

```bash
curl http://localhost:8080/          # Welcome CLO835!
```

On macOS, `python3` and `pip` are already present.

```bash
python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt
python3 app.py
```

## 2. Run it as a container

Read the `Dockerfile` first. Every line repeats one step from section 1.

```bash
docker build -t simple-webapp-flask:v1 .
docker run -d --name webapp -p 8080:8080 simple-webapp-flask:v1

curl http://localhost:8080/         # Welcome CLO835!
docker logs webapp
```

Publish it.

```bash
docker login
docker tag simple-webapp-flask:v1 <user>/simple-webapp-flask:v1
docker push <user>/simple-webapp-flask:v1
```

Any computer with Docker now repeats all of section 1 with one command.

```bash
docker run -d -p 8080:8080 <user>/simple-webapp-flask:v1
```

Clean up.

```bash
docker rm -f webapp
```

## 3. The point

| | By hand | As a container |
|---|---|---|
| Steps to repeat on a new machine | 6 | 1 |
| Moves to another computer | No | Yes |
| Leaves files behind after you stop it | Yes | No |
| Breaks on a different Ubuntu version | Yes | No |
