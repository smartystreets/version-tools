###Version Tools
-------------------------

These tools are designed to facilate version calculation and respository tagging using Semantic Versioning (semver) and are compatible with POSIX-based shells (`bash`, `dash`, `sh`, etc.) on Linux, Unix, and MacOS. The scripts are explictly designed to avoid all external dependencies such that they can be run in a minimal container environment such as Alpine Linux.

There are two scripts: one for semver calculation and another which tags your Git repository according to the calculated version script. Git is only required if and when you want to tag your repository using the tagging script.

Here is an example of how to calculate the next semver value based upon the existing version:

```
$ calculate-version
usage: calculate-version [-Mmp] major.minor.patch

$ ./calculate-version -p 0.0.0
0.0.1

$ ./calculate-version -m 0.0.3
0.1.0

$ ./calculate-version -M 1.1.15
2.0.0

$ ./calculate-version -Mmp 2.3.4
3.1.1

$ ./calculate-version -p 1.2.3-17-6fb3af9 # (results of git-describe)
1.2.4
```
