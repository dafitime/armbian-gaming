#!/bin/bash

update
libglu

box64Jammy

box86Jammy

wine64

winex86




function box64Jammy {
	sudo apt -y install cmake libsdl1.2debian
	cd ~
	git clone https://github.com/ptitSeb/box64
	cd box64
	mkdir build; cd build; cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo
	make -j4
	sudo make install
	menuJammy
}

function winex86 {
	sudo rm /usr/local/bin/wine
	sudo rm /usr/local/bin/wine64
	sudo rm /usr/local/bin/wineserver
	sudo rm /usr/local/bin/winecfg
	sudo rm /usr/local/bin/wineboot
	sudo rm -r ~/.wine/
	sudo rm -r ~/wine/
	sudo cp wine /usr/local/bin/
	sudo chmod +x /usr/local/bin/wine
	echo "Copied wine to /usr/local/bin/ and given rights "
	
	sudo cp wineserver /usr/local/bin/
	sudo chmod +x /usr/local/bin/wineserver
	echo "Copied wineserver to /usr/local/bin/ and given rights "

	
	sudo cp winetricks /usr/local/bin/
	sudo chmod +x /usr/local/bin/winetricks
	echo "Copied winetricks to /usr/local/bin/ and given rights "

	cp wine-config.desktop ~/.local/share/applications/
	cp wine-desktop.desktop ~/.local/share/applications/
	echo "Copied wine-config.desktop and wine-desktop.desktop to ~/.local/share/applications/ "
	echo " "
	
	mkdir ~/wine/
	mkdir ~/wine/lib/
	cp libwine.so ~/wine/lib/
	cp libwine.so.1 ~/wine/lib/
	echo "Created wine folder and copied libwine.so and libwine.so.1 "
	echo " "
	
	
	sudo cp -r /wine-5.13-i686-1sg/usr/ ~/wine/
	

}

function wine64 {
	sudo rm -r ~/.wine/
	sudo rm -r ~/wine/
	cd ~
	wget https://www.playonlinux.com/wine/binaries/phoenicis/upstream-linux-amd64/PlayOnLinux-wine-6.0.1-upstream-linux-amd64.tar.gz
	mkdir ~/wine
	cd ~/wine
	tar xf ../PlayOnLinux-wine-6.0.1-upstream-linux-amd64.tar.gz
	sudo rm /usr/local/bin/wine
	sudo rm /usr/local/bin/wine64
	sudo rm /usr/local/bin/wineserver
	sudo rm /usr/local/bin/winecfg
	sudo rm /usr/local/bin/wineboot
	sudo ln -s ~/wine/bin/wine /usr/local/bin/wine
	sudo ln -s ~/wine/bin/wine64 /usr/local/bin/wine64
	sudo ln -s ~/wine/bin/wineserver /usr/local/bin/wineserver
	sudo ln -s ~/wine/bin/winecfg /usr/local/bin/winecfg
	sudo ln -s ~/wine/bin/wineboot /usr/local/bin/wineboot
	cd ..
	sudo rm PlayOnLinux-wine-6.0.1-upstream-linux-amd64.tar.gz
	echo "Wine installed, test with : "
	echo "box64 wine winecfg "
}

function update {
	sudo apt -y update && apt -y upgrade
}

function box86 {
	sudo apt -y install cmake
	sudo dpkg --add-architecture armhf
	update
	dependencies
	git clone https://github.com/ptitSeb/box86.git	
	cd box86/
	mkdir build
	cd build
	sudo cmake .. -DRK3399=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make -j4
	sudo make install
	cd ..
	cd ..
	rm -r box86/
}

function dependencies {	
	sudo apt -y install libllvm12:armhf
	sudo apt -y install linux-libc-dev:armhf
	sudo apt -y install git cmake libncurses6:armhf libc6:armhf  libx11-6:armhf libgdk-pixbuf2.0-0:armhf libgtk2.0-0:armhf libstdc++6:armhf libsdl2-2.0-0:armhf mesa-va-drivers:armhf libsdl1.2-dev:armhf libsdl-mixer1.2:armhf libpng16-16:armhf libcal3d12v5:armhf libsdl2-net-2.0-0:armhf libopenal1:armhf libsdl2-image-2.0-0:armhf libvorbis-dev:armhf libcurl4:armhf libjpeg62:armhf  libudev1:armhf libgl1-mesa-dev:armhf  libx11-dev:armhf libsmpeg0:armhf libavcodec58:armhf libavformat58:armhf libswscale5:armhf libsdl2-image-2.0-0:armhf libsdl2-mixer-2.0-0:armhf gcc-arm-linux-gnueabihf cmake git cabextract
	dependenciesFix
}

function dependenciesFix {
	 sudo mv /usr/share/doc/linux-libc-dev/changelog.Debian.gz /usr/share/doc/linux-libc-dev/changelog.Debian.gz.old 
	 sudo rm /usr/include/drm/drm_fourcc.h
	 sudo rm /usr/include/drm/lima_drm.h
	 sudo apt -y --fix-broken install
}

function box64 {
	git clone https://github.com/ptitSeb/box64
	cd box64
	mkdir build
	cd build
	sudo apt -y install linux-libc-dev
	sudo apt -y install build-essential 
	sudo cmake .. -DRK3399=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make -j4
	sudo make install
	cd ..
	cd ..
	sudo rm -r box64/
}

function box86Jammy {
	sudo apt -y install libc6-dev-armhf-cross git cmake gcc-arm-linux-gnueabihf 
	cd ~
	git clone https://github.com/ptitSeb/box86
	cd box86
	mkdir build; cd build; cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo
	make -j2
	sudo make install
	sudo systemctl restart systemd-binfmt

	sudo dpkg --add-architecture armhf
	sudo apt update
	sudo aptitude install mesa-va-drivers:armhf libgtk2.0-0:armhf libsdl2-image-2.0-0:armhf libsdl1.2debian:armhf libopenal1:armhf libvorbisfile3:armhf libgl1:armhf libjpeg62:armhf libcurl4:armhf libasound2-plugins:armhf -y
	sudo apt update
	sudo aptitude upgrade
	menuJammy
}

function libglu {
	sudo apt -y install libglu1-mesa 
	menuJammy
}

function all {
	box86
	box64
	winex86
}

function distro {
	echo "Choose your distro! "
	echo "1. Armbian Hirsute "
	echo "2. Armbian Jammy/Sid "
	
	read choicevar
if [ $choicevar -eq 1 ]
	then 
	menuHirsute
elif [ $choicevar -eq 2 ]
	then 
	menuJammy
else 
	echo "Invalid choice. Exiting script! "
	exit
fi
}

distro
echo "Greetings, NicoD "
