#!/usr/bin/bash

# Author: Juan Rivas (aka @r1vs3c)

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Global variables
dir=$(pwd)
fdir="$HOME/.local/share/fonts"
user=$(whoami)

trap ctrl_c INT

function ctrl_c(){
	echo -e "\n\n${redColour}[!] Exiting...\n${endColour}"
	exit 1
}

function banner(){
	echo -e "\n${turquoiseColour}              _____            ______"
	sleep 0.05
	echo -e "______ ____  ___  /______      ___  /___________________      ________ ___"
	sleep 0.05
	echo -e "_  __ \`/  / / /  __/  __ \     __  __ \_  ___/__  __ \_ | /| / /_  __ \`__ \\"
	sleep 0.05
	echo -e "/ /_/ // /_/ // /_ / /_/ /     _  /_/ /(__  )__  /_/ /_ |/ |/ /_  / / / / /"
	sleep 0.05
	echo -e "\__,_/ \__,_/ \__/ \____/      /_.___//____/ _  .___/____/|__/ /_/ /_/ /_/    ${endColour}${yellowColour}(${endColour}${grayColour}By ${endColour}${purpleColour}@r1vs3c${endColour}${yellowColour})${endColour}${turquoiseColour}"
	sleep 0.05
    	echo -e "                                             /_/${endColour}"
}

if [ "$user" == "root" ]; then
	banner
	echo -e "\n\n${redColour}[!] You should not run the script as the root user!\n${endColour}"
    	exit 1
else
	banner
	sleep 1
	echo -e "\n\n${blueColour}[*] Installing necessary packages for the environment...\n${endColour}"
	sleep 2
	sudo apt install -y kitty rofi feh xclip ranger i3lock-fancy scrot scrub wmname firejail imagemagick cmatrix htop neofetch python3-pip procps tty-clock fzf lsd bat pamixer flameshot
	if [ $? != 0 ] && [ $? != 130 ]; then
		echo -e "\n${redColour}[-] Failed to install some packages!\n${endColour}"
		exit 1
	else
		echo -e "\n${greenColour}[+] Done\n${endColour}"
		sleep 1.5
	fi

	echo -e "\n${blueColour}[*] Installing pywal...\n${endColour}"
	sleep 2
	sudo pip3 install pywal
	if [ $? != 0 ] && [ $? != 130 ]; then
		echo -e "\n${redColour}[-] Failed to install pywal or operation cancelled by user!\n${endColour}"
		exit 1
	else
		echo -e "\n${greenColour}[+] Done\n${endColour}"
		sleep 1.5
	fi

	echo -e "\n${blueColour}[*] Starting installation of necessary dependencies for the environment...\n${endColour}"
	sleep 0.5

	echo -e "\n${purpleColour}[*] Installing necessary dependencies for bspwm...\n${endColour}"
	sleep 2
	sudo apt install -y build-essential git vim libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev libuv1-dev
	if [ $? != 0 ] && [ $? != 130 ]; then
		echo -e "\n${redColour}[-] Failed to install some dependencies for bspwm!\n${endColour}"
		exit 1
	else
		echo -e "\n${greenColour}[+] Done\n${endColour}"
		sleep 1.5
	fi

	echo -e "\n${purpleColour}[*] Installing necessary dependencies for polybar...\n${endColour}"
	sleep 2
	sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev
	if [ $? != 0 ] && [ $? != 130 ]; then
		echo -e "\n${redColour}[-] Failed to install some dependencies for polybar!\n${endColour}"
		exit 1
	else
		echo -e "\n${greenColour}[+] Done\n${endColour}"
		sleep 1.5
	fi

	echo -e "\n${purpleColour}[*] Installing necessary dependencies for picom...\n${endColour}"
	sleep 2
	sudo apt install -y meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev
	if [ $? != 0 ] && [ $? != 130 ]; then
		echo -e "\n${redColour}[-] Failed to install some dependencies for picom!\n${endColour}"
		exit 1
	else
		echo -e "\n${greenColour}[+] Done\n${endColour}"
		sleep 1.5
	fi

	echo -e "\n${blueColour}[*] Starting installation of the tools...\n${endColour}"
	sleep 0.5
	mkdir ~/tools && cd ~/tools

	echo -e "\n${purpleColour}[*] Installing bspwm...\n${endColour}"
	sleep 2
	git clone https://github.com/baskerville/bspwm.git
	cd bspwm
	make -j$(nproc)
	sudo make install
	if [ $? != 0 ] && [ $? != 130 ]; then
		echo -e "\n${redColour}[-] Failed to install bspwm!\n${endColour}"
		exit 1
	else
		sudo apt install bspwm -y
		echo -e "\n${greenColour}[+] Done\n${endColour}"
		sleep 1.5
	fi
	cd ..

	echo -e "\n${purpleColour}[*] Installing sxhkd...\n${endColour}"
	sleep 2
	git clone https://github.com/baskerville/sxhkd.git
	cd sxhkd
	make -j$(nproc)
	sudo make install
	if [ $? != 0 ] && [ $? != 130 ]; then
		echo -e "\n${redColour}[-] Failed to install sxhkd!\n${endColour}"
		exit 1
	else
		echo -e "\n${greenColour}[+] Done\n${endColour}"
		sleep 1.5
	fi

	cd ..

	echo -e "\n${purpleColour}[*] Installing polybar...\n${endColour}"
	sleep 2
	git clone --recursive https://github.com/polybar/polybar
	cd polybar
	mkdir build
	cd build
	cmake ..
	make -j$(nproc)
	sudo make install
	if [ $? != 0 ] && [ $? != 130 ]; then
		echo -e "\n${redColour}[-] Failed to install polybar!\n${endColour}"
		exit 1
	else
		echo -e "\n${greenColour}[+] Done\n${endColour}"
		sleep 1.5
	fi

	cd ../../

	echo -e "\n${purpleColour}[*] Installing picom...\n${endColour}"
	sleep 2
	git clone https://github.com/ibhagwan/picom.git
	cd picom
	git submodule update --init --recursive
	meson --buildtype=release . build
	ninja -C build
	sudo ninja -C build install
	if [ $? != 0 ] && [ $? != 130 ]; then
		echo -e "\n${redColour}[-] Failed to install picom!\n${endColour}"
		exit 1
	else
		echo -e "\n${greenColour}[+] Done\n${endColour}"
		sleep 1.5
	fi

	cd ..

	echo -e "\n${purpleColour}[*] Installing Oh My Zsh and Powerlevel10k for user $user...\n${endColour}"
	sleep 2
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	if [ $? != 0 ] && [ $? != 130 ]; then
		echo -e "\n${redColour}[-] Failed to install Oh My Zsh and Powerlevel10k for user $user!\n${endColour}"
		exit 1
	else
		echo -e "\n${greenColour}[+] Done\n${endColour}"
		sleep 1.5
	fi

	echo -e "\n${purpleColour}[*] Installing Oh My Zsh and Powerlevel10k for user root...\n${endColour}"
	sleep 2
	sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k
	if [ $? != 0 ] && [ $? != 130 ]; then
		echo -e "\n${redColour}[-] Failed to install Oh My Zsh and Powerlevel10k for user root!\n${endColour}"
		exit 1
	else
		echo -e "\n${greenColour}[+] Done\n${endColour}"
		sleep 1.5
	fi

	echo -e "\n${blueColour}[*] Starting configuration of fonts, wallpaper, configuration files, .zshrc, .p10k.zsh, and scripts...\n${endColour}"
	sleep 0.5

	echo -e "\n${purpleColour}[*] Configuring fonts...\n${endColour}"
	sleep 2
	if [[ -d "$fdir" ]]; then
		cp -rv $dir/fonts/* $fdir
	else
		mkdir -p $fdir
		cp -rv $dir/fonts/* $fdir
	fi
	echo -e "\n${greenColour}[+] Done\n${endColour}"
	sleep 1.5

	echo -e "\n${purpleColour}[*] Configuring wallpaper...\n${endColour}"
	sleep 2
	if [[ -d "~/Wallpapers" ]]; then
		cp -rv $dir/wallpapers/* ~/Wallpapers
	else
		mkdir ~/Wallpapers
		cp -rv $dir/wallpapers/* ~/Wallpapers
	fi
	wal -nqi ~/Wallpapers/archkali.png
	sudo wal -nqi ~/Wallpapers/archkali.png
	echo -e "\n${greenColour}[+] Done\n${endColour}"
	sleep 1.5

	echo -e "\n${purpleColour}[*] Configuring configuration files...\n${endColour}"
	sleep 2
	cp -rv $dir/config/* ~/.config/
	echo -e "\n${greenColour}[+] Done\n${endColour}"
	sleep 1.5

	echo -e "\n${purpleColour}[*] Configuring the .zshrc and .p10k.zsh files...\n${endColour}"
	sleep 2
	cp -v $dir/.zshrc ~/.zshrc
	sudo ln -sfv ~/.zshrc /root/.zshrc
	cp -v $dir/.p10k.zsh ~/.p10k.zsh
	sudo ln -sfv ~/.p10k.zsh /root/.p10k.zsh
	echo -e "\n${greenColour}[+] Done\n${endColour}"
	sleep 1.5

	echo -e "\n${purpleColour}[*] Configuring scripts...\n${endColour}"
	sleep 2
	sudo cp -v $dir/scripts/whichSystem.py /usr/local/bin/
	cp -rv $dir/scripts/*.sh ~/.config/polybar/shapes/scripts/
	touch ~/.config/polybar/shapes/scripts/target
	echo -e "\n${greenColour}[+] Done\n${endColour}"
	sleep 1.5

	echo -e "\n${purpleColour}[*] Configuring necessary permissions and symbolic links...\n${endColour}"
	sleep 2
	chmod -R +x ~/.config/bspwm/
	chmod +x ~/.config/polybar/launch.sh
	chmod +x ~/.config/polybar/shapes/scripts/*
	sudo chmod +x /usr/local/bin/whichSystem.py
	sudo chmod +x /usr/local/bin/screenshot
	sudo chmod +x /usr/local/share/zsh/site-functions/_bspc
	sudo chown root:root /usr/local/share/zsh/site-functions/_bspc
	sudo mkdir -p /root/.config/polybar/shapes/scripts/
	sudo touch /root/.config/polybar/shapes/scripts/target
	sudo ln -sfv ~/.config/polybar/shapes/scripts/target /root/.config/polybar/shapes/scripts/target
	cd ..
	echo -e "\n${greenColour}[+] Done\n${endColour}"
	sleep 1.5

	echo -e "\n${purpleColour}[*] Removing repository and tools directory...\n${endColour}"
	sleep 2
	rm -rfv ~/tools
	rm -rfv $dir
	echo -e "\n${greenColour}[+] Done\n${endColour}"
	sleep 1.5

	echo -e "\n${greenColour}[+] Environment configured :D\n${endColour}"
	sleep 1.5

	while true; do
		echo -en "\n${yellowColour}[?] It's necessary to restart the system. Do you want to restart the system now? ([y]/n) ${endColour}"
		read -r
		REPLY=${REPLY:-"y"}
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo -e "\n\n${greenColour}[+] Restarting the system...\n${endColor}"
			sleep 1
			sudo reboot
		elif [[ $REPLY =~ ^[Nn]$ ]]; then
			exit 0
		else
			echo -e "\n${redColour}[!] Invalid response, please try again\n${endColour}"
		fi
	done
fi
