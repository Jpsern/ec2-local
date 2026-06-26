.DEFAULT_GOAL := help

COMPOSE_CMD := docker compose
SSH_KEY := ~/.ssh/ec2_local_rsa
EC2_USER := ec2-user

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
	$(MAKE) clean && $(MAKE) build && $(MAKE) up

up: ## コンテナ起動
	$(COMPOSE_CMD) up -d

restart: ## コンテナ再起動
	$(COMPOSE_CMD) restart

setup-ssh: ## SSH鍵の作成・公開鍵コピー・権限設定
	@test -f $(SSH_KEY) || ssh-keygen -t rsa -f $(SSH_KEY) -N ""
	@$(COMPOSE_CMD) up -d amazon-linux-2023
	@$(COMPOSE_CMD) cp $(SSH_KEY).pub amazon-linux-2023:/home/$(EC2_USER)/.ssh/authorized_keys
	@$(COMPOSE_CMD) exec -u root amazon-linux-2023 sh -lc 'chmod 600 /home/$(EC2_USER)/.ssh/authorized_keys && chown $(EC2_USER):$(EC2_USER) /home/$(EC2_USER)/.ssh/authorized_keys'

aml2023: ## amazon-linux-2023 コンテナにログイン
	$(COMPOSE_CMD) exec -u $(EC2_USER) amazon-linux-2023 bash
