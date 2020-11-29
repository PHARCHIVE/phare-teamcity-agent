ARG RELEASE=32
FROM fedora:$RELEASE

RUN dnf update -y
# for ffmpeg (at least)
RUN dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

RUN dnf update -y &&  dnf install -y git make cmake ccache tar gzip unzip \
                   zlib-devel.x86_64 gcovr environment-modules wget m4 \
                   openmpi openmpi-devel hdf5 hdf5-devel \
                   hdf5-openmpi-devel python3 sphinx python3-sphinx python3-sphinx_rtd_theme \
                   python3-breathe python3-docutils python3-numpy python3-scipy python3-openmpi \
                   python3-mpi4py-openmpi libasan libubsan lcov python3-ddt \
                   which gitstats wget doxygen g++ clang cppcheck cppcheck-htmlreport \
                   python3-h5py python3-matplotlib ninja-build ffmpeg python3-seaborn 


