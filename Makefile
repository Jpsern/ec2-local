down:
	docker-compose down
.PHONY: down

down-all:
	docker-compose down --rmi all --volumes --remove-orphans
.PHONY: down-all

build:
	docker-compose build --no-cache
.PHONY: build

rebuild:
	make down-all && make build
.PHONY: rebuild

up:
	docker-compose up -d
.PHONY: up

restart:
	docker-compose restart
.PHONY: restart

aml2:
	docker-compose exec -u ec2-user amazon-linux-2 bash
