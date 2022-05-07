#!/bin/bash
# Installs JavaFX build dependencies
# Assumes local copies of OpenJDK, Gradle, Apache Ant, and CMake

# gradle sdk jmods javadoc
# gradle all
apt-get install pkg-config
apt-get install libgtk2.0-dev
apt-get install libxtst-dev
apt-get install libgtk-3-dev
apt-get install libxxf86vm-dev

# gradle -PCONF=Release -PPROMOTED_BUILD_NUMBER=12 \
#   -PHUDSON_BUILD_NUMBER=101 -PHUDSON_JOB_NAME=jfx \
#   -PCOMPILE_WEBKIT=true -PCOMPILE_MEDIA=true -PBUILD_LIBAV_STUBS=true \
#   sdk jmods javadoc
apt-get install libasound2-dev
apt-get install ruby
apt-get install gperf
