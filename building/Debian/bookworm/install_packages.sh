# Copyright 2023-2024 DreamWorks Animation LLC
# SPDX-License-Identifier: Apache-2.0 

# Install Debian/Ubuntu packages for building MoonRay
# source this script in bash

install_qt=1
install_cuda=1
install_cgroup=1
for i in "$@" 
do
case ${i,,} in
    --noqt|-noqt)
        install_qt=0
    ;;
    --nocuda|-nocuda)
        install_cuda=0
    ;;
    --nocgroup|-nocgroup)
        install_cgroup=0
    ;;
    *)
        echo "Unknown option: $i"
        return 1
    ;;
esac
done


# dnf install -y epel-release
# dnf config-manager --enable crb

# not required if you are not building with GPU support
if [ $install_cuda -eq 1 ] 
then
    # dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo
    # dnf install -y cuda-runtime-11-8 cuda-toolkit-11-8
fi

apt-get install libglvnd-dev

apt-get install build-essential

apt-get install bison flex wget git python3 python3-dev patch \
               libgif-dev libmng-dev libtiff5-dev libjpeg68-turbo-dev \
               libatomic1 uuid-dev openssl libcurl4-openssl-dev \
               libfreetype-dev

# dnf install -y lsb_release

mkdir -p /installs/{bin,lib,include}
cd /installs

# if [ $install_cgroup -eq 1 ] 
# then
#     wget https://kojihub.stream.centos.org/kojifiles/packages/libcgroup/0.42.2/5.el9/x86_64/libcgroup-0.42.2-5.el9.x86_64.rpm
#     wget https://kojihub.stream.centos.org/kojifiles/packages/libcgroup/0.42.2/5.el9/x86_64/libcgroup-devel-0.42.2-5.el9.x86_64.rpm
#     dnf install libcgroup-0.42.2-5.el9.x86_64.rpm -y
#     dnf install libcgroup-devel-0.42.2-5.el9.x86_64.rpm -y
# fi

wget https://github.com/Kitware/CMake/releases/download/v3.23.1/cmake-3.23.1-linux-x86_64.tar.gz
tar xzf cmake-3.23.1-linux-x86_64.tar.gz

apt-get install libblosc-dev
apt-get install libboost1.81-all-dev
# dnf install -y lua lua-libs lua-devel #5.4.4
apt-get install lua5.4 liblua5.4-dev
# dnf install -y openvdb openvdb-libs openvdb-devel #9.1.0
apt-get install libopenvdb-dev
# dnf install -y tbb tbb-devel python3-tbb #2020.3
apt-get install libtbb-dev
# dnf install -y log4cplus log4cplus-devel #2.0.5
apt-get install liblog4cplus-dev
# dnf install -y cppunit cppunit-devel #1.15.1
apt-get install libcppunit-dev
# dnf install -y libmicrohttpd libmicrohttpd-devel #0.9.72
apt-get install libmicrohttpd-dev

# not required if you are not building the GUI apps
if [ $install_qt -eq 1 ]
then
    apt install qtbase5-dev qtscript5-dev
#    dnf install -y qt5-qtbase-devel qt5-qtscript-devel
fi

export PATH=/usr/local/cuda/bin:${PATH}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}
