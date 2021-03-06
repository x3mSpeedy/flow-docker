#!/bin/bash
#

PETSC_VERSION="petsc-$1"

cd /usr/share/petsc
if [ ! -d "$PETSC_VERSION" ]; then
    wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/$PETSC_VERSION.tar.gz
    tar -xvf $PETSC_VERSION.tar.gz
    cd $PETSC_VERSION
    ./configure \
            --with-cc=gcc --with-cxx=g++ --with-fc=gfortran \
            --download-fblaslapack --download-mpich --download-metis=yes --download-parmetis=yes \
            --with-debugging=0 --with-shared-libraries=0 \
            --with-make-np --CFLAGS="-O3 -DNDEBUG" --CXXFLAGS="-O3 -DNDEBUG -Wall -Wno-unused-local-typedefs -std=c++11"
    make all test
    # make PETSC_DIR=/usr/share/petsc/petsc-3.6.1 PETSC_ARCH=arch-linux2-c-debug all
fi
