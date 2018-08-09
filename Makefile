#!/usr/bin/make -f

tag-major:
	@./git-tag-version -M

tag-minor:
	@./git-tag-version -m

tag-patch:
	@./git-tag-version -p
