This repository contains my build environment and shell scripts for building JavaFX on Linux, macOS, and Windows. The files common to all systems are found in the root `bin` directory, while those that are platform-dependent are found in the `linux/bin`, `macos/bin`, and `win10/bin` directories.

I use these files to test pull request [openjdk/jfx#446](https://github.com/openjdk/jfx/pull/446), "8264449: Enable reproducible builds with SOURCE_DATE_EPOCH."

### Building

I set the environment variables with the "dot" command (`.`) and then run the build scripts as follows:

```console
$ . ~/bin/jfxbuild.env
$ ~/bin/develop.sh
$ ~/bin/actions.sh
$ ~/bin/release.sh
$ ~/bin/noepoch.sh
```

where:

* **jfxbuild.env** defines the `SOURCE_DATE_EPOCH`, `JDK_HOME`, and `PATH` environment variables for the local copy of CMake, OpenJDK, and Apache Ant.

* **develop.sh** creates two developer builds with targets "`sdk jmods javadoc`" and runs the unit tests.

* **actions.sh** creates two GitHub Actions builds with target "`all`" and runs the unit tests.

* **release.sh** creates two production builds with targets "`sdk jmods javadoc`" and runs the unit tests.

* **noepoch.sh** creates a production build without `SOURCE_DATE_EPOCH` and runs the unit tests.

### Testing

After running the scripts, I test whether the build is reproducible by comparing the pair of builds created by each of the first three scripts:

```console
$ diff -r build1 build2
$ diff -r build3 build4
$ diff -r build5 build6
```

The `noepoch.sh` script tests whether the production build still works after removing `SOURCE_DATE_EPOCH` from the environment.
