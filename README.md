## VERSION TOOLS

These tools are designed to facilate version calculation and respository tagging using Semantic Versioning (semver) and are compatible with POSIX-based shells (`bash`, `dash`, `sh`, etc.) on Linux, Unix, and MacOS. The scripts are explictly designed to avoid all external dependencies such that they can be run in a minimal container environment such as Alpine Linux.

There are two scripts: one for semver calculation and another which tags your Git repository according to the calculated version script. Git is only required if and when you want to tag your repository using the tagging script.

Here's example of how to calculate the next semver value based upon the existing version:

```
$ bumpit
usage: usage: bumpit [-Mmp] major.minor.patch [-d|--dirty]

$ bumpit -p 0.0.0
0.0.1

$ bumpit -m 0.0.3
0.1.0

$ bumpit -M 1.1.15
2.0.0

$ bumpit -Mmp 2.3.4
3.1.1

$ bumpit -p 1.2.3-17-6fb3af9 # (results of git-describe)
1.2.4

$ bumpit -p 1.2.3-17-6fb3af9 --dirty
1.2.4

$ bumpit -p 1.2.3 --dirty # version is clean, it doesn't increment
1.2.3
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
COPY --from=version-tools /* /usr/bin

# the rest of your Dockerfile contents here...
```

### On a Debian-based OS:
```
$ wget "https://github.com/smartystreets/version-tools/releases/download/0.0.6/version-tools_0.0.6_all.deb"
$ dpkg -i version-tools_0.0.6_all.deb
$ rm version-tools_0.0.6_all.deb
```

### Other environments (tar.gz):
```
$ curl "https://github.com/smartystreets/version-tools/releases/download/0.0.6/release.tar.gz" \
  sudo tar -xz -C /usr/local/bin
```

### Other environments (zip):
```
$ wget "https://github.com/smartystreets/version-tools/releases/download/0.0.6/release.zip"
$ unzip release.zip -d /usr/local/bin
```

### Notes:

- Be sure to point to the latest release. This readme file MAY be several versions behind.
- You're welcome to download with `curl`, `wget` or any other mechanism. The use of `curl` or `wget` above is simply an example of how to download the release artifact.
