
all:
	@docker compose -f ./srcs/docker-compose.yml -up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

re:
	@make down
	@make all

clean:
	@docker stop $$(docker ps -aq);\
	docker rm $$(docker ps -aq);\
	docker rmi -f $$(docker images -aq);\
	docker volume rm $$(docker volume ls -q);\
	docker netword rm $$(docker netword ls -q);\

.PHONY all down re clean
