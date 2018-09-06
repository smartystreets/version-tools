#!/usr/bin/make -f

SOURCE_NAME := version-tools
DOCKER_IMAGE := smartystreets/$(SOURCE_NAME)

clean:
	rm -rf output/

major:
	@./src/tagit -M

minor:
	@./src/tagit -m

patch:
	@./src/tagit -p

debian-changelog:
	@echo "$(SOURCE_NAME) ($(shell git describe)) unstable; urgency=low" > debian/changelog
	@echo "\n  * $(shell git rev-parse HEAD)\n" >> debian/changelog
	@echo " -- $(shell git --no-pager show -s --format="%an <%ae>")  $(shell git --no-pager show -s --format="%cD")" >> debian/changelog

#############################################33

publish:
	git push origin --tags
	docker push "$(DOCKER_IMAGE):$(shell git describe)" && docker push "$(DOCKER_IMAGE):latest"
	hub release create -m "v$(shell git describe) release" "$(shell git describe)" \
		-a output/release.tar.gz \
		-a output/release.zip \
		-a output/*.deb

package: clean version tarball docker debianize

version: patch

docker:
	docker build . -t "$(DOCKER_IMAGE):$(shell git describe)" -t "$(DOCKER_IMAGE):latest"

tarball:
	mkdir -p output/ && cd src/ && GZIP=-9 tar -cvzf ../output/release.tar.gz * && zip -9 ../output/release.zip *

debianize:
	docker build -f Dockerfile.debian -t version-tools-debian .
	docker run --rm -v "$(CURDIR)/output:/output/" version-tools-debian
