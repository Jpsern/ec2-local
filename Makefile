.DEFAULT_GOAL := help

help: ## このヘルプメッセージを出力
	@echo
	@printf "\033[1;4mUSAGE\033[0m\n"
	@printf "  make \033[1;36m[TARGET]\033[32m([ARGS])\033[0m\n"
	@echo
	@printf "\033[1;4mTARGETS\033[0m\n"
	@grep -E '^[/a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | perl -pe 's%^([/a-zA-Z_-]+):.*?(##)%$$1 $$2%' | awk -F " *?## *?" '{printf "  \033[1;36m%-20s\033[0m %s\n", $$1, $$2}'
.PHONY: help

down: ## コンテナ停止
	docker-compose down
.PHONY: down

down-all: ## コンテナ、イメージ、ネットワーク一括削除
	docker-compose down --rmi all --volumes --remove-orphans
.PHONY: down-all

build: ## コンテナ作成
	docker-compose build --no-cache
.PHONY: build

rebuild: ## 環境一括作り直し
	make down-all && make build
.PHONY: rebuild

up: ## コンテナ起動
	docker-compose up -d
.PHONY: up

restart: ## コンテナ再起動
	docker-compose restart
.PHONY: restart

aml2: ## Amazon Linux 2 コンテナにログイン
	docker-compose exec -u ec2-user amazon-linux-2 bash
