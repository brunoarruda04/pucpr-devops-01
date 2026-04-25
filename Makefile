# Variáveis
APP_NAME = ruby-app
PORT = 4567

# Default
.PHONY: help
help:
	@echo "Comandos disponíveis:"
	@echo "  make setup        -> instala tudo (ruby deps + node + husky)"
	@echo "  make install      -> instala dependências Ruby"
	@echo "  make lint         -> roda rubocop"
	@echo "  make lint-fix     -> corrige lint automaticamente"
	@echo "  make run          -> roda a aplicação"
	@echo "  make test         -> roda testes (placeholder)"
	@echo "  make docker-build -> build do container"
	@echo "  make docker-run   -> roda container"
	@echo "  make clean        -> limpa caches"

# Setup completo
.PHONY: setup
setup: install setup-node setup-husky
	@echo "Setup completo!"

# Instalar dependências Ruby
.PHONY: install
install:
	bundle install

# Setup Node (necessário pro semantic-release + husky)
.PHONY: setup-node
setup-node:
	npm install

# Setup Husky
.PHONY: setup-husky
setup-husky:
	npx husky init

# Rodar aplicação
.PHONY: run
run:
	ruby app.rb

# Linter
.PHONY: lint
lint:
	bundle exec rubocop

# Corrigir lint
.PHONY: lint-fix
lint-fix:
	bundle exec rubocop -A

# Testes
.PHONY: test
test:
	bundle exec rspec

# Docker build
.PHONY: docker-build
docker-build:
	docker build -t $(APP_NAME) .

# Docker run
.PHONY: docker-run
docker-run:
	docker run -p $(PORT):$(PORT) $(APP_NAME)

# Limpeza
.PHONY: clean
clean:
	rm -rf node_modules
	rm -rf .bundle