#!/usr/bin/make -f

major:
	@./src/tagit -M

minor:
	@./src/tagit -m

patch:
	@./src/tagit -p

package:
	cd src/ && GZIP=-9 tar -cvzf ../release.tar.gz *

publish: patch package
	hub release create -a release.tar.gz -m "v$(shell git describe) release" "$(shell git describe)"
	git push origin master --tags

#docker-publish:
#	docker build . -t "smartystreets/version-tools:$(shell git describe)"
