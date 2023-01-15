down:
	docker-compose down
.PHONY: down

down-all:
	docker-compose down --rmi all --volumes --remove-orphans
.PHONY: down-all

build:
	docker-compose build --no-cache
.PHONY: build

up:
	docker-compose up -d
.PHONY: up

restart-all:
	docker-compose restart
.PHONY: restart
