# Requirements

To run the environment you need to have at least the following stack:

- Docker Engine
- [Docker Compose](https://docs.docker.com/compose/install/)

# Technologies
- Next.js 13.5.6
- lumen 10.0
- Docker compose

# Initial configurations

## environment variables

Create and edit a file with environment variable to configure the services

```
cd  docker
chmod 755 app.sh
cp common-sample.env common.env
ln -s common.env .env
```

## Create .env in backend/api

Create the `.env` file based on the `.env.example` file in the `/backend/api` directory. You can do this with the following command:
```
 cd backend/api/
 cp .env.example .env
```

# Dev Environment usage

```
# Build images
./app.sh build

# Run containers
./app.sh up 
or
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


Before running the application, make sure to follow these setup steps:

1. Generate an application key by running the following command inside the `pm-backend` container:

    ```bash
    docker exec -it pm-backend php artisan key:generate
    ```

2. Ensure that the `./storage` directory has the proper permissions for Laravel to write to it. You can set the permissions with the following command in the `/backend/api` directory:

    ```bash
    cd /backend/api/
    chmod -R 777 ./storage
    ```

   Note: Using permissions of 777 is very permissive and not recommended for production environments. Be sure to adjust permissions according to your specific needs and security measures.
   Once you've completed these steps, your Laravel application will be configured and ready to run.


## Enter the backend
```
https://backend/api/
```

## Enter the frontend
```
https://localhost/
```
