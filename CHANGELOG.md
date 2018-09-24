## Next (Unreleased)

* Added POSIX-compliant install script.

## 0.0.6 (2018-09-06)

* Added Github release packaging for tar.gz.
* Added Github release packaging for zip.
* Added Github release packaging for debian.

## 0.0.5 (2018-09-05)

FEATURES:

 * Allowing `-d` flag to be used in addition to `--dirty` for `bumpit` command.
 * When the git committer (user/email) has not been set, use a fake one.
 * Added Docker container publication and readme instructions.

## 0.0.4 (2018-08-09)

MISC:

 * Publishing scripts as a tarball to Github.

## 0.0.3 (2018-08-09)

FEATURES:

 * Added `--dryrun` flag to `tagit`.

MISC:

 * Docker images point to git repo root.

## 0.0.2 (2018-08-09)

BREAKING CHANGES:

 * Renamed `calculate-version` to `bumpit`.
 * Renamed `git-tag-version` to `tagit`.

FEATURES:

 * When the `--dirty` flag is specified, a version is only incremented
   or bumped when found to be dirty, e.g. `1.2.3-17-3fdcfa9`.

FIXES:

 * If a tag is duplicate (it exists earlier in the git history), exit with an error.

## 0.0.1 (2018-08-09)

  * Initial release.
