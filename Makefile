#!/usr/bin/make -f

major:
	@./src/tagit -M

minor:
	@./src/tagit -m

patch:
	@./src/tagit -p

github-package:
	cd src/ && GZIP=-9 tar -cvzf ../release.tar.gz *
github-publish: github-package
	hub release create -a release.tar.gz -m "v$(shell git describe) release" "$(shell git describe)"
	git push origin master --tags

publish: patch
	test -f ~/.config/hub && mkdir -p .config && cp ~/.config/hub ./.config
	# now docker-compose run primary make publish
	# docker -f Dockerfile.dockerhub build . -t "smartystreets/version-tools:$(shell git describe)"
