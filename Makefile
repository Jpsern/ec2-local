.DEFAULT_GOAL := help

help: ## print help message
	@echo
	@printf "\033[1;4mUSAGE\033[0m\n"
	@printf "  make \033[1;36m[TARGET]\033[32m([ARGS])\033[0m\n"
	@echo
	@printf "\033[1;4mTARGETS\033[0m\n"
	@grep -E '^[/a-zA-Z_0-9-]+:.*?## .*$$' $(MAKEFILE_LIST) | perl -pe 's%^([/a-zA-Z_0-9-]+):.*?(##)%$$1 $$2%' | awk -F " *?## *?" '{printf "  \033[1;36m%-20s\033[0m %s\n", $$1, $$2}'
.PHONY: help

down: ## stop containers
	docker-compose down
.PHONY: down

destroy: ## remove all containers, images, and volumes
	docker-compose down --rmi all --volumes --remove-orphans
.PHONY: down-all

build: ## build containers
	docker-compose build --no-cache
.PHONY: build

rebuild: ## rebuild containers
	make destroy && make build && make up
.PHONY: rebuild

up: ## start containers
	docker-compose up -d
.PHONY: up

restart: ## restart containers
	docker-compose restart
.PHONY: restart

aml2: ## login to amazon-linux-2 container
	docker-compose exec -u ec2-user amazon-linux-2 bash
