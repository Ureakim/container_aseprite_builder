#!/bin/bash
cd aseprite
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLAF_BACKEND=skia -DSKIA_DIR=/code/deps/skia -DSKIA_LIBRARY_DIR=/code/deps/skia/out/Release-x64 -G Ninja ..
ninja aseprite
