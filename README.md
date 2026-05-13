# MongoDB Docker Compose Setup for Local Development

This setup is for MongoDB local development to use transactions (with replica sets) and vector search (with mongodb-atlas-local).

## Requirements

- Docker
- Docker Compose

## Setting Up

1. (Required for replica set only) Add these entries to /etc/hosts file so your machine can resolve `mongo_1`, `mongo_2` and `mongo_3`:

- For Linux/Mac, edit `/etc/hosts` (with `sudo` privileges):

```txt
127.0.0.1   mongo_1
127.0.0.1   mongo_2
127.0.0.1   mongo_3
```

- For Windows, edit `C:\Windows\System32\drivers\etc\hosts` (as Administrator):

```txt
127.0.0.1 mongo_1
127.0.0.1 mongo_2
127.0.0.1 mongo_3
```

2. In the root terminal of this directory, run:
   - `make replicas` to run only the replica set servers
   - `make atlas` to run the local atlas server
   - `make replas` to run both the replica set and the local atlas servers

3. Use the connection strings below to connect to the database servers from your application or MongoDB Compass:
   - replica set: `mongodb://mongo_1:27001,mongo_2:27002,mongo_3:27003/?replicaSet=rs0`
   - atlas: `mongodb://root:secret@localhost:27004?directConnection=true`

You can see sample connections in the `scripts` folder.

> [!NOTE]
> The mongodb-atlas-local server also runs a replica set by default.
