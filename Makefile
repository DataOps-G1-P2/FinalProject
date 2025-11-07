DOCKER := docker compose
PROJECT_NAME := finalproject
include .env
export

# Targets
.PHONY: all setup up down logs logs-nifi logs-registry shell-toolkit

## Start all services and follow logs
all: up echo

## Generate secret key for NiFi
setup:
	@echo "🔑 Generating a password..."
	@openssl rand -hex 16 > .env_password
	@echo "✅ Password generated."
	@if grep -q "NIFI_PASSWORD=" .env 2>/dev/null; then \
		sed -i "s/NIFI_PASSWORD=.*/NIFI_PASSWORD=$$(cat .env_password)/" .env; \
		echo "🔐 Password updated in .env file."; \
	else \
		echo "NIFI_PASSWORD=$$(cat .env_password)" >> .env; \
		echo "🔐 Password added to .env file."; \
	fi
	@rm .env_password

# Display environment variables and service URLs
echo:
	@echo "NIFI_USERNAME: $(NIFI_USERNAME)"
	@echo "NIFI_PASSWORD: $(NIFI_PASSWORD)"
	@echo "✅ NiFi:          https://localhost:8443/nifi"
	@echo "✅ NiFi Registry: http://localhost:18080/nifi-registry"
	@echo "🔗 Access the services using the above URLs."

## Start all services
up: 
	@echo "🚀 Starting NiFi, NiFi Registry, and NiFi Toolkit ..."
	@$(DOCKER) up -d
	@echo "✅ Services started."

## Stop all services
down:
	@echo "🛑 Stopping NiFi, NiFi Registry, and NiFi Toolkit..."
	@$(DOCKER) down
	@echo "✅ Services stopped."

## Follow logs from all services
logs:
	@$(DOCKER) logs -f

## Follow logs from NiFi only
logs-nifi:
	@$(DOCKER) logs -f nifi

## Follow logs from NiFi Registry only
logs-registry:
	@$(DOCKER) logs -f nifi-registry

# clean up docker volumes
clean-volumes:
	@echo "🧹 Cleaning up..."
	@docker volume rm $(PROJECT_NAME)_nifi_registry_database
	@docker volume rm $(PROJECT_NAME)_nifi_registry_flow_storage
	@docker volume rm $(PROJECT_NAME)_nifi_database_repository
	@docker volume rm $(PROJECT_NAME)_nifi_flowfile_repository
	@docker volume rm $(PROJECT_NAME)_nifi_content_repository
	@docker volume rm $(PROJECT_NAME)_nifi_provenance_repository
	@docker volume rm $(PROJECT_NAME)_nifi_nar_extensions
	@docker volume rm $(PROJECT_NAME)_nifi_python_extensions
	@docker volume rm $(PROJECT_NAME)_nifi_conf
	@docker volume rm $(PROJECT_NAME)_nifi_state
	@docker volume rm $(PROJECT_NAME)_nifi_logs
	@echo "✅ Cleanup complete."