all: dir
	@docker compose -f ./srcs/docker-compose.yml up -d --build

dir:
	@mkdir -p /Users/ewehl/Documents/Core/Inception/srcs/requirements/data/mariadb
	@mkdir -p /Users/ewehl/Documents/Core/Inception/srcs/requirements/data/wordpress

rmdir:
	@rm -Rf /Users/ewehl/Documents/Core/Inception/srcs/requirements/data

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