#!/bin/bash
# This is a template script to install the external project
# You should create a configuration folder and copy this script
# to the folder for actual installation.

SuperLU_version=${1:-"6.0.0"}
SuperLU_configuration=${2:-"default"}


config=$(basename "${BASH_SOURCE[0]}" .sh)
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
root="$script_dir/.."
source_dir="$script_dir/../source"
build_dir="$script_dir/../build/$OCP_COMPILER/$config"
install_dir="$script_dir/../install/$OCP_COMPILER/$config"

mkdir -p $install_dir
# cmake -S $source_dir -B $build_dir -DFASP_INSTALL_PREFIX=$install_dir -DUSE_SUPERLU=ON -DSUPERLU_DIR=$HOME/ocp/external/superlu/6.0.0/install/default/lib/cmake/superlu -GNinja
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/ocp/external/superlu/6.0.0/install/default/lib

dir=$HOME/ocp/external/superlu/$SuperLU_version/install/$OCP_COMPILER/$SuperLU_configuration
cmake -S $source_dir -B $build_dir -GNinja \
    -DFASP_INSTALL_PREFIX=$install_dir \
    -DUSE_SUPERLU=ON \
    -DSUPERLU_DIR="$dir" \
    -DBLAS_LIBRARIES="$dir/lib/libblas.a"

cmake --build $build_dir --target install
