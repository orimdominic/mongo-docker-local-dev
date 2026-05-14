#!/bin/bash

# This runs INSIDE Docker, so these are internal ports
PRIMARY="mongo_1:27001"

echo "Waiting for MongoDB nodes to be reachable..."
for HOST in mongo_1:27001 mongo_2:27002 mongo_3:27003; do
  until mongosh --host "$HOST" --eval "db.adminCommand('ping')" --quiet; do
    echo "  Waiting for $HOST..."
    sleep 2
  done
  echo "  $HOST is up."
done

echo "Checking replica set status..."
IS_INIT=$(mongosh --host "$PRIMARY" --quiet --eval "try { rs.status().ok } catch(e) { 0 }")

if [ "$IS_INIT" -eq 1 ]; then
  echo "Replica set already initialized. Skipping."
else
  echo "Initializing replica set..."
  mongosh --host "$PRIMARY" --eval '
    rs.initiate({
      _id: "rs",
      members: [
        { _id: 0, host: "mongo_1:27001", priority: 2 },
        { _id: 1, host: "mongo_2:27002", priority: 1 },
        { _id: 2, host: "mongo_3:27003", priority: 1 }
      ]
    })
  '
  echo "Replica set initialized."
fi
