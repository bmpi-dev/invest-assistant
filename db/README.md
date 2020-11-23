# Postgres for local dev/test

## Starting PostgreSQL Instance

- Pull docker image

```
docker pull postgres
```

- Create a folder in a known location for you

```bash
mkdir ${HOME}/postgres-data/
```

- run the postgres image

```bash
docker run -d \
	--name dev-postgres \
	-e POSTGRES_PASSWORD=123456 \
	-v ${HOME}/postgres-data/:/var/lib/postgresql/data \
    -p 5432:5432 \
    postgres
```

- check that the container is running

```bash
docker ps
```

## Starting the pgAdmin instance

```bash
docker pull dpage/pgadmin4
docker run -d \
    -p 80:80 \
    -e 'PGADMIN_DEFAULT_EMAIL=user@domain.local' \
    -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret' \
    --name dev-pgadmin \
    dpage/pgadmin4
```

## Accessing the PostgreSQL from the pgAdmin tool

Then access `http://localhost:80` and login with name `user@domain.local` and password `SuperSecret`.

Once you are in the portal, you will need to add a new server by clicking on the “Add New Server” and adding the right information on the pop-up window, make sure you add the IPAdress that you copied previously in the Host name/address under the Connection tab.

Get postgres address by:

```bash
docker inspect dev-postgres -f "{{json .NetworkSettings.Networks }}"
```