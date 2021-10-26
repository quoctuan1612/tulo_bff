.DEFAULT_GOAL := usage

build:
	docker-compose build

up:
	rm -rf tmp/pids/server.pid
	docker-compose up

up-bridge:
	if [ -z "$$(docker network ls -q -f name=tulo_bridge)"]; then docker network create tulo_bridge; fi
	rm -rf tmp/pids/server.pid
	docker-compose -f docker-compose-bridge.yaml up

down:
	docker-compose down

stop:
	docker-compose stop

bundle:
	docker-compose run --rm app bundle install

bundle-update:
	docker-compose run --rm app bundle update

console:
	docker-compose run --rm app bundle exec rails console

rubocop-fix:
	docker-compose run --rm app bundle exec rubocop --auto-correct

rspec:
	docker-compose run --rm app bundle exec rspec ${OPTS} --profile -- ${TARGETS}

update-pb:
	docker-compose run --rm app sh scripts/proto_converter.sh ${SERVICE}

attach:
	docker container attach $(docker-compose ps -q | head -n 1)

usage:
	@echo usage: [build, up, up-bridge, down, stop, bundle, bundle-update, console, rubocop-fix, rspec, update-pb, attach]
