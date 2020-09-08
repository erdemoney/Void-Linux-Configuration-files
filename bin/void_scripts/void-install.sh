#!/bin/bash
# https://alkusin.net/voidlinux
# Void Linux post-install script

bypass() {
  sudo -v
  while true;
  do
    sudo -n true
    sleep 45
    kill -0 "$$" || exit
  done 2>/dev/null &
}

echo "Starting Void Linux post-install script..."
sleep 3s
	bypass

clear
echo "Updating system and adding repositories..."
sleep 3s
	sudo xbps-install -Syu
	sudo xbps-install -Sy void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree

clear
echo "Installing packages..."
sleep 3s
	sudo xbps-install -Sy alsa-plugins alsa-utils dbus-elogind elogind 	#sudo xbps-install -Sy xfce4-panel-appmenu appmenu-gtk-module appmenu-gtk3-module plank
clear
echo "Importing files from server..."
sleep 3s
 	cd /tmp/
	wget https://alkusin.net/voidlinux/void-files.tar.xz
	tar Jxvf void-files.tar.xz
	chmod +x void-files/usr/local/share/applications/*
	chmod +x void-files/usr/local/bin/void-scripts/*
	chmod +x void-files/usr/local/bin/void-scripts/extra-themes/*
	\cp -r void-files/etc/skel/. ~/
	sudo \cp -r void-files/etc/. /etc
	sudo \cp -r void-files/usr/. /usr
	rm -rf void-files/
	mkdir ~/.void-backup/
	mv void-files.tar.xz ~/.void-backup/
	sudo chmod 755 /etc/sv/void-updater/run

clear
echo "Installing new theme..."
sleep 3s
	/usr/local/bin/void-scripts/plata-custom-void.sh
	/usr/local/bin/void-scripts/papirus-custom-void.sh
	sudo ln -sfnr /usr/share/icons/Papirus/64x64/apps/hardinfo.svg /usr/share/hardinfo/pixmaps/logo.png

clear
echo "Configuring system..."
sleep 3s

	sudo sed -i "s/--noclear/--noclear\ --skip-login\ --login-options=$USER/g" /etc/sv/agetty-tty1/conf

	#sudo ln -s /etc/sv/void-updater /var/service/

	sudo rm -f /var/service/agetty-tty{3,4,5,6}
	sudo ln -s /etc/sv/ntpd /var/service/
	sudo ln -s /etc/sv/dbus /var/service/
	sudo ln -s /etc/sv/elogind /var/service/
	sudo ln -s /etc/sv/polkitd /var/service/
	sudo ln -s /etc/sv/ufw /var/service/

	sudo ufw default deny
	#sudo ufw allow from 192.168.0.0/24
	sudo ufw logging off
	sudo ufw enable

	#sudo ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
	#sudo hwclock --systohc

	sudo mkdir /etc/sysctl.d/
	echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf

	sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

clear
echo "Adding user to some groups..."
sleep 3s
	sudo usermod -aG input $USER
	sudo usermod -aG audio $USER
	sudo usermod -aG video $USER
	#sudo usermod -aG libvirt $USER
	#sudo usermod -aG kvm $USER
	#sudo usermod -aG socklog $USER

clear
printf "If LightDM was installed, run \"sudo ln -s /etc/sv/lightdm /var/service/\" after reboot.\n"
read -p "Done! Press ENTER to reboot."
	sudo shutdown -r now
