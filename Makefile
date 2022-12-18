THIS_DIR := $(realpath $(dir $(THIS_FILE)))

args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

.PHONY: bash
bash: ## Ouvre une session bash.
	@docker-compose exec -u 1000:1000 serv bash

.PHONY: migration
migration: ## Met en ligne les modifications de bdd
	@docker-compose exec -u 1000:1000 serv php bin/console d:m:m

.PHONY: composer-install
composer-install: ## Import les données
	@docker-compose exec -u 1000:1000 serv composer install

.PHONY: clear-cache
clear-cache: ## Lance les test phpunit
	@docker-compose exec -u 1000:1000 serv php bin/console c:c

.PHONY: reset-db
reset-db: ## Réinintialise la db
	@docker-compose exec -u 1000:1000 serv php bin/console doctrine:database:drop --force
	@docker-compose exec -u 1000:1000 serv php bin/console doctrine:database:create
	@docker-compose exec -u 1000:1000 serv php bin/console d:m:m -n