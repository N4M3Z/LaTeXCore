#!/bin/bash

# Get code location in filesystem
PROJECT_PATH=`pwd`

# Go to and clean compilation directory
cd CMake
echo "Cleaning CMake work directory ..."
rm CMakeCache.txt
rm -r CMakeFiles
rm Makefile
rm cmake_install.cmake

# Setup CMake
cmake ..

# Compile the code
make
