#!/bin/bash
# Creates two developer builds and runs unit tests
trap exit INT TERM
set -o errexit

dir1=build1
dir2=build2

if [ -d $dir1 ] || [ -d $dir2 ]; then
    printf "Target directories exist: %s %s\n" $dir1 $dir2 >&2
    exit 1
fi

gradle () (
    set -o xtrace
    bash gradlew --no-daemon "$@"
)

printf "SOURCE_DATE_EPOCH=%s\n" "$SOURCE_DATE_EPOCH"
for dir in $dir1 $dir2; do
    gradle cleanAll
    gradle sdk jmods javadoc
    mv build "$dir"
done
gradle sdk jmods javadoc test -x :web:test
