#!/usr/bin/make -f

PROJECT := "smartystreets/version-tools"

clean:

major:
	@./src/tagit -M

minor:
	@./src/tagit -m

patch:
	@./src/tagit -p

#############################################33

publish:
	git push origin --tags
	docker push "$(PROJECT):$(shell git describe)" && docker push "$(PROJECT):latest"

package: clean version docker

version: patch

docker:
	docker build . -t "$(PROJECT):$(shell git describe)" -t "$(PROJECT):latest"
