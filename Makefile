#!/usr/bin/make -f

SOURCE_NAME  ?= version-tools
DOCKER_IMAGE ?= smartystreets/$(SOURCE_NAME)
VERSION      ?= $(shell tagit -p --dry-run)

clean:
	rm -rf workspace/ scratch/ *.deb *.buildinfo *.changes

changelog: clean
	@mkdir -p scratch/debian && echo "$(SOURCE_NAME) ($(VERSION)) unstable; urgency=low" > scratch/debian/changelog \
		&& echo "\n  * $(shell git rev-parse HEAD)\n" >> scratch/debian/changelog \
		&& echo " -- $(shell git --no-pager show -s --format="%an <%ae>")  $(shell git --no-pager show -s --format="%cD")" >> scratch/debian/changelog

deb: changelog
	cp -r src debian scratch/ \
		&& (cd scratch && dpkg-buildpackage -b -us -uc) \
		&& mkdir -p workspace && mv *.deb workspace/ \
		&& rm -rf scratch/ version-tools*.buildinfo version-tools*.changes

tarball:
	mkdir -p workspace/ && cd src/ \
		&& GZIP=-9 tar -cvzf ../workspace/release.tar.gz * --owner=0 --group=0 \
		&& zip -9 ../workspace/release.zip * \
		&& cat ../install | sed 's/0\.0\.0/$(VERSION)/g' > ../workspace/install

package: deb tarball

#############################################

workspace:
	docker-compose run tools /bin/bash

image:
	docker build . -f release.Dockerfile -t "$(DOCKER_IMAGE):$(VERSION)" -t "$(DOCKER_IMAGE):latest"

release: image
	docker-compose run tools make package \
		&& tagit -p \
		&& hub release create -m "v$(VERSION) release" "$(VERSION)" -a workspace/* \
		&& docker push "$(DOCKER_IMAGE):$(VERSION)" \
		&& docker push "$(DOCKER_IMAGE):latest" \
		&& git push origin --tags

.PHONY: clean changelog deb tarball package workspace image release
