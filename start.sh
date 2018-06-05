sudo apt-get update -y && sudo apt-get upgrade -y && echo OK || exit

#wget https://atom.io/download/deb -O foo
#sudo dpkg -i foo
sudo apt-get install emacs -y #this I found to be better in everyway than Atom.

#Git
sudo apt-get install git -y

#shutter for screenshots
#sudo add-apt-repository ppa:shutter/ppa -y # not maintaned properly, causes whole installation to break
#sudo apt-get update -y
sudo apt-get install shutter -y

#tor
sudo apt-get install torsocks -y

#aira2c
sudo apt-get install aria2 -y

#install FTP
sudo apt-get install filezilla -y

#install FTPServer
sudo apt-get install openssh-server -y

#install Gedit Plugins
#sudo apt-get install gedit-plugins -y

#install VPC
sudo apt-get install vlc -y

#install autoSSH. I like this better than SSH as it reconnects automatically.
sudo apt-get install autossh -y

#terminal manager
#sudo apt-get install byobu -y ; not that good. 

#Youtube Downloader
sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

#Python3.
sudo apt-get install python3-pip -y

#ETTUS drive for USRP
echo "Installing ETTUS USRP Driver"
cd #go home prior to doing the installation
echo "Installation assumes you're uisng an Debian, latest "
sudo apt-get install --ignore-missing git swig cmake doxygen build-essential libboost-all-dev libtool libusb-1.0-0 libusb-1.0-0-dev libudev-dev libncurses5-dev libfftw3-bin libfftw3-dev libfftw3-doc libcppunit-1.13-0v5 libcppunit-dev libcppunit-doc ncurses-bin cpufrequtils python-numpy python-numpy-doc python-numpy-dbg python-scipy python-docutils qt4-bin-dbg qt4-default qt4-doc libqt4-dev libqt4-dev-bin python-qt4 python-qt4-dbg python-qt4-dev python-qt4-doc python-qt4-doc libqwt6abi1 libfftw3-bin libfftw3-dev libfftw3-doc ncurses-bin libncurses5 libncurses5-dev libncurses5-dbg libfontconfig1-dev libxrender-dev libpulse-dev swig g++ automake autoconf libtool python-dev libfftw3-dev libcppunit-dev libboost-all-dev libusb-dev libusb-1.0-0-dev fort77 libsdl1.2-dev python-wxgtk3.0 git-core libqt4-dev python-numpy ccache python-opengl libgsl-dev python-cheetah python-mako python-lxml doxygen qt4-default qt4-dev-tools libusb-1.0-0-dev libqwt5-qt4-dev libqwtplot3d-qt4-dev pyqt4-dev-tools python-qwt5-qt4 cmake git-core wget libxi-dev gtk2-engines-pixbuf r-base-dev python-tk liborc-0.4-0 liborc-0.4-dev libasound2-dev python-gtk2 libzmq-dev libzmq1 python-requests python-sphinx libcomedi-dev python-zmq -y
cd $HOME
mkdir workarea-uhd
cd workarea-uhd
git clone https://github.com/EttusResearch/uhd
cd uhd
cd host
mkdir build
cd build
cmake ../ && make && make test && sudo make install && sudo ldconfig && echo "Install UHD success" || exit
echo "export LD_LIBRARY_PATH=/usr/local/lib" | sudo tee -a $HOME/.bashrc #-a appends, otherwise content is replaced.
export LD_LIBRARY_PATH=/usr/local/lib
echo "If you see no devices found below, the instalation completed successfully"
uhd_find_devices
cd

#Install GNURadio from source
echo "Installing GNU Radio"
cd #go home prior to installation
#This script will work perfectly on Ubuntu 16.04 or upwards. If you want to make it wokr on something else, please check the link below and install the dependancies
#https://kb.ettus.com/Building_and_Installing_the_USRP_Open-Source_Toolchain_(UHD_and_GNU_Radio)_on_Linux
sudo apt-get install git -y
cd $HOME
mkdir workarea-gnuradio
cd workarea-gnuradio
git clone --recursive https://github.com/gnuradio/gnuradio
cd gnuradio && mkdir build && cd build && cmake ../ && make && sudo make install && sudo ldconfig && echo "install GNU Radio OK" || exit
gnuradio-config-info --version
gnuradio-config-info --prefix
gnuradio-config-info --enabled-components
echo "@GROUP    - rtprio    99" | sudo tee -a /etc/security/limits.conf
cd #go back home



#inspectrum
#Tested only on Linux Mint 18.03 Cinemon. Results for your distrib may vary.
#earlier hack
#sudo apt-get update -y
#echo "deb http://cz.archive.ubuntu.com/ubuntu artful main universe" | sudo tee -a /etc/apt/sources.list.d/temp.list
#sudo apt-get update -y
#sudo apt-get install libliquid-dev -y
#sudo rm -f /etc/apt/sources.list.d/temp.list
#sudo apt-get update -y #Update with the temp added repo removd. Top important! Otherwise system can break. We only install the libliquid-dev from this repo. Others are not made for your distrib.
wget http://mirrors.kernel.org/ubuntu/pool/universe/l/liquid-dsp/libliquid1d_1.3.0-1_amd64.deb
dpkg -x libliquid1d_1.3.0-1_amd64.deb .
wget http://mirrors.kernel.org/ubuntu/pool/universe/l/liquid-dsp/libliquid-dev_1.3.0-1_amd64.deb
dpkg -x libliquid-dev_1.3.0-1_amd64.deb .
sudo cp  usr/lib/x86_64-linux-gnu/libliquid.* /usr/lib/x86_64-linux-gnu/
sudo cp -ar usr/include/liquid /usr/include/

sudo apt-get install build-essential git
sudo apt-get install qt5-default libfftw3-dev cmake pkg-config -y
git clone https://github.com/miek/inspectrum
cd inspectrum
mkdir build
cd build
cmake ..
make
sudo make install
cd #go back home

#install RTL-SDR hardware drivers
#instruction from RTL-SDR for Linux Quick Start Guide v10.16 by Kenn Ranous 
sudo apt-get install cmake -y
sudo apt-get install build-essential -y
sudo apt-get install libusb-1.0-0-dev -y
git clone git://git.osmocom.org/rtl-sdr.git
cd rtl-sdr/
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
make
sudo make install
sudo ldconfig
sudo cp ../rtl-sdr.rules /etc/udev/rules.d/
#now Blacklist the default driver that is automatically loaded for using the dongle as a TV device as it doesn't work for SDR purposes and clashes with the new Osmocom drivers we just installed.
sudo echo "blacklist dvb_usb_rtl28xxu" | sudo tee -a /etc/modprobe.d/blacklist-rtl.conf
rtl_test -t #do this for testing
#Adding RTL Radio Blocks to GNU Radio
cd #Go back home
git clone git://git.osmocom.org/gr-osmosdr
cd gr-osmosdr/
mkdir build
cd build/
cmake ../
make
sudo make install
sudo ldconfig

#install Arduino user as dialog user
#Adding self to dialout. Requires logout to work.
#user='whoami'
sudo usermod -a -G dialout user

#Safeeyes for eyes
sudo add-apt-repository ppa:slgobinath/safeeyes -y
sudo apt update -y
sudo apt install safeeyes -y
#sudo apt-get install gir1.2-appindicator3-0.1 gir1.2-notify-0.7 python3-psutil python3-xlib xprintidle -y
#sudo apt install python3-pip -y
#pip3 install --upgrade pip
#sudo pip3 install safeeyes

#install Dropbox
#sudo apt install nautilus-dropbox -y

#install Latex
sudo apt-get install texlive-full texmaker -y

#install KiCad, the worlds best PCB generation software
sudo add-apt-repository --yes ppa:js-reynaud/kicad-4 -y
sudo apt update -y
sudo apt install kicad -y


#END
