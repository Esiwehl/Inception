all: dir
	@docker compose -f ./srcs/docker-compose.yml up -d --build

dir:
	@mkdir -p /Users/ewehl/Documents/Core/Inception/srcs/requirements/data/mariadb
	@mkdir -p /Users/ewehl/Documents/Core/Inception/srcs/requirements/data/wordpress

rmdir:
	@rm -Rf /Users/ewehl/Documents/Core/Inception/srcs/requirements/data/mariadb
	@rm -Rf /Users/ewehl/Documents/Core/Inception/srcs/requirements/data/wordpress

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

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\

prune: rmdir
	@docker system prune -af

.PHONY: dir rmdir all re down nginx mariadb wp clean