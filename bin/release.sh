#!/bin/bash
# Creates two production builds and runs unit tests
trap exit INT TERM
set -o errexit

dir1=build5
dir2=build6

if [ -d $dir1 ] || [ -d $dir2 ]; then
    printf "Target directories exist: %s %s\n" $dir1 $dir2 >&2
    exit 1
fi

gradle () (
    set -o xtrace
    bash gradlew --no-daemon \
        -PCONF=Release -PPROMOTED_BUILD_NUMBER=7 \
        -PHUDSON_BUILD_NUMBER=101 -PHUDSON_JOB_NAME=jfx \
        -PCOMPILE_WEBKIT=true -PCOMPILE_MEDIA=true -PBUILD_LIBAV_STUBS=true \
        "$@"
)

printf "SOURCE_DATE_EPOCH=%s\n" "$SOURCE_DATE_EPOCH"
for dir in $dir1 $dir2; do
    gradle cleanAll
    gradle sdk jmods javadoc
    mv build "$dir"
done
gradle sdk jmods javadoc test
