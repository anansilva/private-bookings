args = $(filter-out $@, $(MAKECMDGOALS))

# DEVELOPMENT
setup: # Copy configuration files locally needed for running Docker
	cp ./docker/config/database.sample.yml ./config/database.yml
up.d:
	docker-compose up --detach
up:
	docker-compose up
down:
	docker-compose down
up.web:
	docker-compose up web
down.web:
	docker-compose down web
up.jobs:
	docker-compose up jobs
down.jobs:
	docker-compose down jobs
build:
	docker-compose build --no-cache web
bundle:
	docker-compose run --rm web bash -c "bundle"
bundle.update:
	docker-compose run --rm web bash -c "bundle update"
bash:
	docker-compose run --rm web bash
binding.pry:
	docker attach `docker-compose ps -q web`
credentials:
	docker-compose run --rm -e EDITOR=vim web bin/rails credentials:edit

# TDD
tdd:
	docker-compose -f docker-compose.tdd.yml run tdd bash
%:
	@:

