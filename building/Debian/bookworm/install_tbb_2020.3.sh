#!/bin/sh

if [ $# -eq 3 ] ; then
    echo 'Source and install directories are mandatory !'
    exit 1
fi

if [ ! -d "$2/lib/cmake/tbb" ]; then
  echo "$2/lib/cmake/tbb does not exist, create it."
  mkdir $2/lib/cmake/tbb
fi

echo "Copy TBB include's files"
cp -r $1/TBB-prefix/src/TBB/include/tbb $2/include/
echo "Copy TBB cmake's files"
cp -r $1/TBB-prefix/src/TBB/cmake/* $2/lib/cmake/tbb/

CC_VERSION=`cc --version | grep "Debian" | cut -d" " -f4`
BUILD_DIR=`ls $1/TBB-prefix/src/TBB/build | grep $CC_VERSION`

echo "Copy TBB $BUILD_DIR lib's files"
cp $1/TBB-prefix/src/TBB/build/$BUILD_DIR/libtbb* $2/lib/
