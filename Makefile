atlas:
	docker compose -f compose-atlas.yml up

replicas:
	docker compose -f compose-replicas.yml up

replas:
	docker compose -f compose-replicas.yml -f compose-atlas.yml up
