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
.PHONY: destroy

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
.PHONY: aml2

cp_ssh_key: ## copy ssh public key and change permission
	docker-compose cp ~/.ssh/ec2_local_rsa.pub amazon-linux-2:/home/ec2-user/.ssh/authorized_keys
	docker-compose run --rm amazon-linux-2 sudo chmod 600 ~/.ssh/authorized_keys
	docker-compose run --rm amazon-linux-2 sudo chown ec2-user:ec2-user ~/.ssh/authorized_keys
.PHONY: cp_ssh_key
