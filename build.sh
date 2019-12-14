#!/bin/sh

cdir=`pwd`
install_dir=${cdir}/install
mkdir -p $install_dir

# nvxs
cd nvxs
./configure --prefix $install_dir --enable-openmp
make all -j$(getconf _NPROCESSORS_ONLN)
make install
cd ${cdir}

# ruby ext
cd animeface-ruby
ruby extconf_local.rb
make -j$(getconf _NPROCESSORS_ONLN)

echo -n "\n\nCheck:"
echo " % cd animeface-ruby"
echo " % ruby sample.rb <input image>"
