#!/bin/bash
# Creates a production build and runs unit tests without SOURCE_DATE_EPOCH
trap exit INT TERM
set -o errexit

gradle () (
    set -o xtrace
    bash gradlew --no-daemon \
        -PCONF=Release -PPROMOTED_BUILD_NUMBER=12 \
        -PHUDSON_BUILD_NUMBER=101 -PHUDSON_JOB_NAME=jfx \
        -PCOMPILE_WEBKIT=true -PCOMPILE_MEDIA=true -PBUILD_LIBAV_STUBS=true \
        "$@"
)

unset SOURCE_DATE_EPOCH
printf "SOURCE_DATE_EPOCH=%s\n" "$SOURCE_DATE_EPOCH"
gradle cleanAll
gradle sdk jmods javadoc test
