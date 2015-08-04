#!/usr/bin/env sh

set -eu

rm -rf *.cc internal/*
curl -sL https://github.com/facebook/rocksdb/archive/rocksdb-3.11.2.tar.gz | tar zxf - -C internal --strip-components=1
make -C internal util/build_version.cc
patch -p1 < gitignore.patch

# stuff we need to compile.
SOURCES=$(
  find internal/{db,table,port,util,utilities/write_batch_with_index} -type f -name '*.cc' \
    -not -name '*_bench.cc' \
    -not -name '*_cmd.cc' \
    -not -name '*_debug.cc' \
    -not -name '*_example.cc' \
    -not -name '*_test.cc' \
    -not -name '*_tool.cc' \
    -not -name 'mock_*.cc' \
    -not -name 'test*.cc'
)

# symlink so cgo compiles them
for file in $SOURCES; do
  ln -sf $file .
done

# restore the repo to what it would look like when first cloned
git clean -dxf
