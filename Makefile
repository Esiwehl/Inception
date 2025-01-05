all: dir
	@docker compose -f ./srcs/docker-compose.yml up -d --build

dir:
	@sudo mkdir -p /home/ewehl/data/mariadb
	@sudo mkdir -p /home/ewehl/data/wordpress

rmdir:
	@sudo rm -Rf /home/ewehl/data

down:
	@docker compose -f ./srcs/docker-compose.yml down

re: dir
	@docker compose -f ./srcs/docker-compose.yml down -v
	@docker compose -f ./srcs/docker-compose.yml up -d --build

nginx:
	@docker exec -it srcs-nginx-1 bash

mariadb:
	@docker exec -it srcs-mariadb-1 bash

wp:
	@docker exec -it srcs-wordpress-1 bash

clean: rmdir
	@docker compose -f ./srcs/docker-compose.yml down -v

prune: rmdir
	@docker system prune -af

.PHONY: dir rmdir all re down nginx mariadb wp clean