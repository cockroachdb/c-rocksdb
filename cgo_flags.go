// Package rocksdb uses the cgo compilation facilities to build the
// RocksDB C++ library. Note that support for bzip2, snappy and zlib
// is not compiled in.
package rocksdb

// #cgo CPPFLAGS: -Iinternal -Iinternal/include -Iinternal/db -Iinternal/util
// #cgo CPPFLAGS: -Iinternal/utilities/merge_operators/string_append
// #cgo CPPFLAGS: -DROCKSDB_PLATFORM_POSIX -DNDEBUG
// #cgo darwin CPPFLAGS: -DOS_MACOSX
// #cgo !darwin CPPFLAGS: -DOS_LINUX
// #cgo CXXFLAGS: -Wall -Werror -Wsign-compare -Wshadow
// #cgo CXXFLAGS: -std=c++11 -fno-omit-frame-pointer -momit-leaf-frame-pointer
// #cgo darwin CXXFLAGS: -Wshorten-64-to-32
import "C"
