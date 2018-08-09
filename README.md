### VERSION TOOLS

----------------------

These tools are designed to facilate version calculation and respository tagging using Semantic Versioning (semver) and are compatible with POSIX-based shells (`bash`, `dash`, `sh`, etc.) on Linux, Unix, and MacOS. The scripts are explictly designed to avoid all external dependencies such that they can be run in a minimal container environment such as Alpine Linux.

There are two scripts: one for semver calculation and another which tags your Git repository according to the calculated version script. Git is only required if and when you want to tag your repository using the tagging script.

Here's example of how to calculate the next semver value based upon the existing version:

```
$ calculate-version
usage: calculate-version [-Mmp] major.minor.patch

$ calculate-version -p 0.0.0
0.0.1

$ calculate-version -m 0.0.3
0.1.0

$ calculate-version -M 1.1.15
2.0.0

$ calculate-version -Mmp 2.3.4
3.1.1

$ calculate-version -p 1.2.3-17-6fb3af9 # (results of git-describe)
1.2.4
```

Here's an example of how to tag your Git repository based upon the existing semver-based tags:
```
$ git-tag-version
usage: git-tag-version -[M|m|p]

$ git-tag-version -p
Tagged repository with version '0.0.1'."

$ git-tag-version -m
Tagged repository with version '0.1.0'."

$ git-tag-version -M
Tagged repository with version '1.0.0'."
```

If the repository is in a clean state (no new commits since the last tag), it will not add any new tags.

If `git-tag-version` is unable to tag the repository, it will print a diagnostic message and exit.