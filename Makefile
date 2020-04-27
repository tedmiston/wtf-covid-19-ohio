NAME=tedmiston/wtf-covid-19-ohio
TAG=latest
IMAGE=$(NAME):$(TAG)

.PHONY: build
build:
	@DOCKER_BUILDKIT=1 docker build --target=prod --tag=$(IMAGE) .

.PHONY: build-test
build-test:
	@DOCKER_BUILDKIT=1 docker build --target=test --tag=$(IMAGE)-test .

.PHONY: run
run:
	@docker run --rm $(IMAGE)

.PHONY: test
test: build-test
	@docker run --rm $(IMAGE)-test

.PHONY: mypy
mypy:
	@poetry run mypy --strict --ignore-missing-imports . tests/

.PHONY: coverage
coverage:
	@poetry run coverage report

.PHONY: coverage-html
coverage-html:
	@poetry run coverage html

.PHONY: coverage-html-show
coverage-html-show: coverage-html
	@cd htmlcov/ && open http://localhost:8000 && poetry run python -m http.server

.PHONY: format-check
format-check:
	@poetry run black --check .

.PHONY: format-dry-run
format-dry-run:
	@poetry run black --diff .

.PHONY: format
format:
	@poetry run black .

.PHONY: push
push:
	@./ci/push.sh $(IMAGE)

cache-clear:
	@rm "${HOME}/.wtf-covid-19-ohio/cache.sqlite"
