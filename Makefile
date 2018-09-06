#!/usr/bin/make -f

PROJECT := smartystreets/version-tools

clean:
	rm release.tar.gz

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
	hub release create -a release.tar.gz -m "v$(shell git describe) release" "$(shell git describe)"

package: clean version docker tarball

version: patch

docker:
	docker build . -t "$(PROJECT):$(shell git describe)" -t "$(PROJECT):latest"

tarball:
	cd src/ && GZIP=-9 tar -cvzf ../release.tar.gz *
