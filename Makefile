.DEFAULT_GOAL := help

COMPOSE_CMD := docker compose

help: ## ヘルプの表示
	@echo
	@printf "\033[1;4mUSAGE\033[0m\n"
	@printf "  make \033[1;36m[TARGET]\033[32m([ARGS])\033[0m\n"
	@echo
	@printf "\033[1;4mTARGETS\033[0m\n"
	@grep -E '^[/a-zA-Z_0-9-]+:.*?## .*$$' $(MAKEFILE_LIST) | perl -pe 's%^([/a-zA-Z_0-9-]+):.*?(##)%$$1 $$2%' | awk -F " *?## *?" '{printf "  \033[1;36m%-20s\033[0m %s\n", $$1, $$2}'
.PHONY: help down clean build rebuild up restart setup-ssh aml2023

down: ## コンテナ停止
	$(COMPOSE_CMD) down
clean: ## コンテナ、イメージ、ボリューム掃除
	$(COMPOSE_CMD) down --rmi all --volumes --remove-orphans

build: ## コンテナ初期化
	$(COMPOSE_CMD) build --no-cache

rebuild: ## コンテナ作り直し
	make clean && make build && make up

up: ## コンテナ起動
	$(COMPOSE_CMD) up -d

restart: ## コンテナ再起動
	$(COMPOSE_CMD) restart

setup-ssh: ## SSH鍵の作成・公開鍵コピー・権限設定
	@test -f ~/.ssh/ec2_local_rsa || ssh-keygen -t rsa -f ~/.ssh/ec2_local_rsa -N ""
	@$(COMPOSE_CMD) up -d amazon-linux-2023
	@$(COMPOSE_CMD) cp ~/.ssh/ec2_local_rsa.pub amazon-linux-2023:/home/ec2-user/.ssh/authorized_keys
	@$(COMPOSE_CMD) exec -u root amazon-linux-2023 sh -lc 'chmod 600 /home/ec2-user/.ssh/authorized_keys && chown ec2-user:ec2-user /home/ec2-user/.ssh/authorized_keys'

aml2023: ## amazon-linux-2023 コンテナにログイン
	$(COMPOSE_CMD) exec -u ec2-user amazon-linux-2023 bash
