# Requirements

To run the environment you need to have at least the following stack:

- Docker Engine
- [Docker Compose](https://docs.docker.com/compose/install/)

# Initial configurations

## environment variables

Create and edit a file with environment variable to configure the services

```
chmod 755 app.sh
cp common-sample.env common.env
ln -s common.env .env
```
# Nodev Environment usage

```
# Build images
./app.sh -f docker-compose.nodev.yml build

# Run Containers
./app.sh -f docker-compose.nodev.yml -f docker-compose.sidecars.yml up
```

# Dev Environment usage

```
# Build images
./app.sh build

# Run containers
./app.sh up -d
```

## Connect to shell inside a container

Sometime you want to see stuff inside the container. You can initialize a bash term using the follow command

```
docker exec -it <container name> bash
```

## How To see containers output logs

To see logs from a specific container
```
docker logs -f <container_name or container_id>
```
