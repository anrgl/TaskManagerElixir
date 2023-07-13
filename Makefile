up:
	docker-compose up

build:
	docker-compose build

server:
	docker-compose run --rm api mix phx.server

iex:
	docker-compose run --rm --service-ports api iex -S mix phx.server

deps-get:
	docker-compose run --rm api mix deps.get

api-linter:
	docker-compose run --rm api mix dialyzer

api-format:
	docker-compose run --rm api mix format

api-test:
	docker-compose run --rm -e MIX_ENV=test api mix test

bash:
	docker-compose run --rm api bash

psql:
	docker-compose exec db psql -U postgres

swagger:
	docker-compose run --rm api mix phx.swagger.generate
