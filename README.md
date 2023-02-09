#### SMARTY DISCLAIMER: Subject to the terms of the associated license agreement, this software is freely available for your use. This software is FREE, AS IN PUPPIES, and is a gift. Enjoy your new responsibility. This means that while we may consider enhancement requests, we may or may not choose to entertain requests at our sole and absolute discretion.

## VERSION TOOLS

These tools are designed to facilate version calculation and respository tagging using Semantic Versioning (semver) and are compatible with POSIX-based shells (`bash`, `dash`, `sh`, etc.) on Linux, Unix, and MacOS. The scripts are explictly designed to avoid all external dependencies such that they can be run in a minimal container environment such as Alpine Linux.

There are two scripts: one for semver calculation and another which tags your Git repository according to the calculated version script. Git is only required if and when you want to tag your repository using the tagging script.

Pre-existing tags must be of one of the following forms to be recognized by this tool:

- (major).(minor).(patch)
	- Example: `1.2.3`
- v(major).(minor).(patch)
	- Example: `v1.2.3`

Tags created by this tool will match the form of the most recent pre-existing tag.

Here's example of how to calculate the next semver value based upon the existing version:

```
$ bumpit
usage: usage: bumpit [-Mmp] major.minor.patch [-d|--dirty]

$ bumpit -p 0.0.0
0.0.1

$ bumpit -m v0.0.3
v0.1.0

$ bumpit -M 1.1.15
2.0.0

$ bumpit -Mmp v2.3.4
v3.1.1

$ bumpit -p 1.2.3-17-6fb3af9 # (results of git-describe)
1.2.4

$ bumpit -p v1.2.3-17-6fb3af9 --dirty
v1.2.4

$ bumpit -p v1.2.3 --dirty # version is clean, it doesn't increment
v1.2.3
```

Here's an example of how to tag your Git repository based upon the existing semver-based tags:
```
$ tagit
usage: tagit -[M|m|p] [-d|--dryrun|--dry-run]

$ tagit -p
Tagged repository with version '0.0.1'."

$ tagit -m
Tagged repository with version '0.1.0'."

$ tagit -M
Tagged repository with version '1.0.0'."
```

If the repository is in a clean state (no new commits since the last tag), it will not add any new tags.

If `tagit` is unable to tag the repository, it will print a diagnostic message and exit with a non-zero error code.

## INSTALLATION:

### On MacOS:
```
$ brew tap smartystreets/builds
$ brew install smartystreets/builds/version-tools
```

### Inside a Docker container:
```
# toward the top of target Dockerfile
FROM smartystreets/version-tools:latest as version-tools

FROM your-base-image-name-here
COPY --from=version-tools / /usr/bin

# the rest of your Dockerfile contents here...
```

### On a Debian-based OS:
```
$ wget "https://github.com/smartystreets/version-tools/releases/download/1.0.1/version-tools_1.0.1_all.deb"
$ dpkg -i version-tools_1.0.1_all.deb
$ rm version-tools_1.0.1_all.deb
```

You can also install using the provided install script which works on BSD, Linux, and Mac and work in shell environments such as Bash and others.

### Other environments (install):
```
$ curl -sL bit.ly/version-tools | sudo sh
Package [version-tools] successfully installed into [/usr/local/bin/].

# --- OR ---

$ wget -q -O - bit.ly/version-tools | sudo sh
Package [version-tools] successfully installed into [/usr/local/bin/].
```

### Other environments (tar.gz):
```
$ curl "https://github.com/smartystreets/version-tools/releases/download/1.0.1/release.tar.gz" \
	| sudo tar -xz -C /usr/local/bin
```

### Other environments (zip):
```
$ wget "https://github.com/smartystreets/version-tools/releases/download/1.0.1/release.zip"
$ unzip release.zip -d /usr/local/bin
$ rm release.zip
```

### Notes:

- Be sure to point to the latest release. This readme file MAY be several versions behind.
- You're welcome to download with `curl`, `wget` or any other mechanism. The use of `curl` or `wget` above is simply an example of how to download the release artifact.
