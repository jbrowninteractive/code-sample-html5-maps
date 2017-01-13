// gcc -v
// Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
// Apple LLVM version 5.1 (clang-503.0.40) (based on LLVM 3.4svn)
// Target: x86_64-apple-darwin13.1.0
// Thread model: posix


ooc     = require("ooc");
src     = "../src";
main    = "../src/net/equityone/maps/PropertyMaps.coffee";
debug   = "../bin/lib/equityone/property-maps.js";
release = "../bin/lib/equityone/property-maps.min.js";
ooc.compile(src, main, debug, release);
