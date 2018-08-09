#!/usr/bin/make -f

major:
	@./src/tagit -M

minor:
	@./src/tagit -m

patch:
	@./src/tagit -p

docker-publish:
	docker build . -t "smartystreets/version-tools:$(shell git describe)"
