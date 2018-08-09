## Next (Unreleased)

BREAKING CHANGES:

 * Renamed `calculate-version` to `bumpit`
 * Renamed `git-tag-version` to `tagit`

NEW FEATURES:

 * When the `--dirty` flag is specified, a version is only incremented
   or bumped when found to be dirty, e.g. `1.2.3-17-3fdcfa9`.

BUG FIXES:

 * If a tag is duplicate (it exists earlier in the git history), exit with an error.

## 0.0.1 (2018-08-09)

  * Initial release
