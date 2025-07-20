#!/usr/bin/env bash
set -exu

DNF_INSTALL="zlib-devel.x86_64"
((RELEASE > 39)) && DNF_INSTALL="zlib-ng-devel"

dnf update -y

# for ffmpeg (at least)
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

dnf update -y && dnf install -y git make cmake ccache tar gzip unzip \
                   gcovr environment-modules wget m4 llvm elfutils compiler-rt \
                   openmpi openmpi-devel hdf5 hdf5-devel perf python3-pylint python3-dill \
                   hdf5-openmpi-devel python3 sphinx python3-sphinx python3-sphinx_rtd_theme \
                   python3-breathe python3-docutils python3-numpy python3-scipy python3-openmpi \
                   python3-mpi4py-openmpi libasan libubsan lcov python3-ddt python3-yaml \
                   which doxygen /usr/bin/g++ clang cppcheck cppcheck-htmlreport python3-pip \
                   python3-h5py python3-matplotlib ninja-build ffmpeg python3-seaborn ${DNF_INSTALL}

echo "gcc: $(gcc --version)" && echo "clang: $(clang --version)" && echo "hdf5: $(dnf list installed | grep hdf5)"

cd ~/
echo "" >> .bashrc
echo "eval \`modulecmd bash load mpi/openmpi-x86_64\`" >> .bashrc
