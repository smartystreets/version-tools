### VERSION TOOLS

----------------------

These tools are designed to facilate version calculation and respository tagging using Semantic Versioning (semver) and are compatible with POSIX-based shells (`bash`, `dash`, `sh`, etc.) on Linux, Unix, and MacOS. The scripts are explictly designed to avoid all external dependencies such that they can be run in a minimal container environment such as Alpine Linux.

There are two scripts: one for semver calculation and another which tags your Git repository according to the calculated version script. Git is only required if and when you want to tag your repository using the tagging script.

Here's example of how to calculate the next semver value based upon the existing version:

```
$ bumpit
usage: bumpit [-Mmp] major.minor.patch

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

$ bumpit -p 1.2.3-17-6fb3af9 -dirty
1.2.4

$ bumpit -p 1.2.3 -dirty # version is clean, it doesn't increment
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

If `tagit` is unable to tag the repository, it will print a diagnostic message and exit.


### INSTALLATION:

On MacOS:
```
$ brew tap smartystreets/builds
$ brew install smartystreets/builds/version-tools
```


### USAGE IN DOCKER:

To make the tools available within a container, simply copy them from published layer. Here is an example Dockerfile:
```
FROM smartystreets/version-tools:0.0.3 as tools

FROM alpine:latest
COPY --from=tools /usr/bin /usr/bin

... # the rest of your dockerfile
... # bumpit and tagit will now be available within the container

```