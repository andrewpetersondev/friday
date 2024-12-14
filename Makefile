.PHONY: build-development
build-development: ## Build the development docker image.
	docker compose -f docker/development/compose.yaml build

.PHONY: start-development
start-development: ## Start the development docker container. -d means run in detached mode (terminal doesnt display activity)
	docker compose -f docker/development/compose.yaml up -d

.PHONY: stop-development
stop-development: ## Stop the development docker container.
	docker compose -f docker/development/compose.yaml down

.PHONY: watch-development
watch-development: ## Start the development docker container with watch mode to automatically see updates.
	docker compose -f docker/development/compose.yaml watch
