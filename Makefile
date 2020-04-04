.PHONY: build coverage format push run test

NAME=tedmiston/wtf-covid-19-ohio
TAG=latest
IMAGE=$(NAME):$(TAG)

build:
	@DOCKER_BUILDKIT=1 docker build --tag=$(IMAGE) .

run:
	@docker run $(IMAGE)

test:
	@pipenv run coverage run --source=. --omit=tests/test_app.py -m pytest

coverage:
	@coverage report

format:
	@black .

push:
	@docker push $(IMAGE)
