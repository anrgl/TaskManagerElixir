build:
	docker-compose build

server:
	docker-compose run --rm api mix phx.server

iex:
	docker-compose run --rm --service-ports api iex

deps_get:
	docker-compose run --rm api mix deps.get

api_linter:
	docker-compose run --rm api mix dialyzer

api_formatter:
	docker-compose run --rm api mix format

bash:
	docker-compose run --rm api bash