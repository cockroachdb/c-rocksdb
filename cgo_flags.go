// Package rocksdb uses the cgo compilation facilities to build the
// RocksDB C++ library. Note that support for bzip2 and zlib is not
// compiled in.
package rocksdb

// #cgo CPPFLAGS: -Iinternal -Iinternal/include -Iinternal/db -Iinternal/util
// #cgo CPPFLAGS: -Iinternal/utilities/merge_operators/string_append
// #cgo CPPFLAGS: -I../c-snappy/internal -I../c-lz4/internal/lib
// #cgo CPPFLAGS: -DROCKSDB_PLATFORM_POSIX -DNDEBUG -DSNAPPY -DLZ4
// #cgo darwin CPPFLAGS: -DOS_MACOSX
// #cgo linux CPPFLAGS: -DOS_LINUX
// #cgo CXXFLAGS: -Wall -Werror -Wsign-compare -Wshadow
// #cgo CXXFLAGS: -std=c++11 -fno-omit-frame-pointer -momit-leaf-frame-pointer
// #cgo darwin CXXFLAGS: -Wshorten-64-to-32
// #cgo darwin LDFLAGS: -Wl,-undefined -Wl,dynamic_lookup
// #cgo !darwin LDFLAGS: -Wl,-unresolved-symbols=ignore-all
import "C"
