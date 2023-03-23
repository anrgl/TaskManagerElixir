build:
	docker-compose build

server:
	docker-compose run --rm api mix phx.server

iex:
	docker-compose run --rm --service-ports api iex
