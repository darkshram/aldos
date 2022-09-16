# ALDOS.ks
#
# Maintainer(s):
# - Joel Barrios Dueñas

%include ALDOS-1.4-Desktop.ks

lang es_MX.UTF-8
keyboard la-latin1
timezone --utc America/Mexico_City
auth --useshadow --passalgo=sha512
selinux --disabled
firewall --enabled --service=mdns --service=ssh --service=ipp-client --service=samba-client
xconfig --startxonboot
part / --size 6000 --fstype ext4 --fsoptions="relatime,commit=60"
services --enabled=NetworkManager,firewalld,cpupower,avahi-daemon,nscd --disabled=network,pppoe-server,iptables,ip6tables
bootloader --timeout=50 --append="rd.locale.LANG=es_MX.UTF-8 KEYBOARDTYPE=pc SYSFONT=latarcyrheb-sun16 rd.vconsole.keymap=es rootflags=defaults,relatime,commit=60 selinux=0 nmi_watchdog=0"

repo --name=ALDOS --baseurl=file:///var/www/mirror0/public_html/aldos/1.4/x86_64/
repo --name=ALDOS-nonfree --baseurl=file:///var/www/mirror0/public_html/aldos/1.4/nonfree/x86_64/
repo --name=ALDOS-nonfree-updates --baseurl=file:///var/www/mirror0/public_html/aldos/1.4/nonfree/updates/x86_64/
repo --name=ALDOS-updates --baseurl=file:///var/www/mirror0/public_html/aldos/1.4/updates/x86_64/

#packages --excludedocs --instLangs=C:en:en_US:es:es_MX:es_ES:es_AR:ca:ca_ES
%packages --instLangs=C:en:en_US:es:es_MX:es_ES:es_AR:ca:ca_ES
-@fonts
-@input-methods
-@graphics
-@mysql
-mcelog

@cinnamon-desktop

bleachbit
celluloid
cheese
dconf-editor
dibuja
dippi
file-roller
firefox
gnome-calculator
gnome-disk-utility
gparted
libreoffice-gtk3
mate-user-admin
mpv-script-autosub
nasc
notes-up
pinentry-gtk
pix
remmina
screencast
seahorse
simple-scan
sound-juicer
transmission-gtk
xed
xreader
mokutil
xorg-x11-drv-vboxvideo
blueman

%end

