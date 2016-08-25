#!/usr/bin/env sh

set -eu

rm -rf internal/*
find . -type l -not -path './.git/*' | xargs rm
curl -sL https://github.com/facebook/rocksdb/archive/v4.9.tar.gz | tar zxf - -C internal --strip-components=1
make -C internal util/build_version.cc
patch -p1 < gitignore.patch
# Downcase some windows-only includes for compatibility with mingw64.
grep -lRF '<Windows.h>' internal | xargs sed -i~ 's!<Windows.h>!<windows.h>!g'
grep -lRF '<Rpc.h>' internal | xargs sed -i~ 's!<Rpc.h>!<rpc.h>!g'
# Avoid MSVC-only extensions for compatibility with mingw64.
grep -lRF 'i64;' internal | xargs sed -i~ 's!i64;!LL;!g'

# symlink so cgo compiles them
for source_file in $(make sources | grep -vE '(/redis/|(_(cmd|tool)|(env|port)_[a-z]+).cc$)'); do
  ln -sf $source_file $(echo $source_file | sed s,/,_,g)
done

# manually use internal/build_tools/build_detect_platform to update the per-
# platform flags in cgo_flags.

# restore the repo to what it would look like when first cloned.
# comment this line out while updating upstream.
git clean -dxf
