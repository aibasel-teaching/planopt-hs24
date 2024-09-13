#!/bin/bash

# Ubuntu 22.04

semester="planopt-hs24"

sudo apt-get update && sudo apt-get install --no-install-recommends -y \
        cmake      \
        g++        \
        git        \
        make       \
        python3    \
        flex       \
        bison      \
        ecl        \
        meld       \
        emacs      \
        zlib1g-dev \
        libgmp3-dev

cd ~
git clone "https://github.com/aibasel-teaching/${semester}.git" "${semester}"

git clone https://github.com/KCL-Planning/VAL.git VAL
cd VAL
git checkout a5565396007eee73ac36527fbf904142b3077c74
make clean
sed -i 's/-Werror //g' Makefile  # Ignore warnings.
make
sudo mv validate /usr/bin
cd ..
rm -rf VAL

git clone https://github.com/patrikhaslum/INVAL.git INVAL
cd INVAL
sed -i '1s|.*|#!/usr/bin/ecl -shell|g' compile-with-ecl
./compile-with-ecl
sudo mv inval /usr/bin
cd ..
rm -rf INVAL

git clone https://github.com/scipopt/soplex.git soplex
cd soplex
git checkout a5df0814d67812c13a00f06eec507b4d071fb862
cd ..
cmake -S soplex -B build
cmake --build build
sudo cmake --install build
rm -rf soplex build
cd ~
