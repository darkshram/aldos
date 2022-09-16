# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:fedora-desktop-list@redhat.com

## NOTE:
# This file should in general be *subtraction* from the gnome-desktop
# comps group to fit within a CD-sized image.  If you want to add
# a package to the desktop, add them to the comps group.

%include ALDOS-1.4-Base.ks

%packages
-@games
-@graphical-internet
@sound-and-video
-@gnome-desktop
-@technical-writing
-abiword
gnome-keyring
gnome-keyring-pam
package-update-indicator
opensc
alcancelibre-theme
xwrited
vgrive

# LibreOffice.org
autocorr-es
libreoffice-calc
-libreoffice-draw
-libreoffice-graphicfilter
-libreoffice-impress
libreoffice-langpack-es
-libreoffice-math
-libreoffice-pdfimport
-libreoffice-pyuno
-libreoffice-rhino
-libreoffice-wiki-publisher
libreoffice-writer
mythes-es

-compiz*
-emerald*
-kde*
polkit-desktop-policy
-quodlibet
-report-*
-@virtualbox-guest
-@virtualbox
-@virtualization
-@virtualization-client
-gstreamer
-gstreamer-plugins-bad
-gstreamer-plugins-base
-gstreamer-plugins-good
-gstreamer-plugins-ugly
-gstreamer-tools

# Things I need
wacomexpresskeys
-yum-plugin-merge-conf
-lynis

# We do not need these
-gnome-bluetooth*

# Things not really necesary, just to fit my own requirements
hunspell
hunspell-es
-hunspell-en
sound-theme-freedesktop
ntfs-3g

# Java plugin
-icedtea-web

## Sort of non free (because of patents)
#moonlight-plugin
## Legally dangerous!
#-libdvdcss

# No libres
#flash-plugin
# skype
# RealPlayer
# Alternatives:
# gnash-plugin
# swfdec-mozilla

# Multimedia support
ffmpegthumbnailer
# Dolorosa decisión, pero GStreamer es muy malo para video y plugin para gecko
# es pésimo.
-totem
-rhythmbox
-nspluginwrapper
gstreamer1-plugins-ugly
gstreamer1-libav
# Utilizan demasiado espacio debido a dependencias y GStreamer solo vale la pena
# para Rhythmbox, es decir, audio. GStreamer es muy malo para video.
-gstreamer1-plugins-bad-freeworld
-gstreamer-plugins-bad
-gstreamer-plugins-bad-free-extras
-vlc
-vinagre
-openshot-qt

# avoid weird case where we pull in more festival stuff than we need
-festival
-festvox-slt-arctic-hts

# dictionaries are big
-aspell-*
-hunspell-*
-man-pages*
-words

# save some space
-gnome-user-docs
-evolution-help
-isdn4k-utils
#-dasher
-evince-dvi
#-evince-djvu
#-desktop-backgrounds-basic
#-constantine-backgrounds-extras

# these pull in excessive dependencies
-ekiga
#-tomboy

# things we don't need here
-alacarte
-krb5-workstation
-pam_krb5
-quota
-acpid
-smartmontools
-minicom
-dos2unix
-finger
-ftp
-jwhois
-mtr
-pinfo
-rsh
-telnet
-nfs-utils
-ypbind
-yp-tools
-rpcbind

# drop some system-config things
#-system-config-boot
#-system-config-network
#-system-config-rootpassword
-system-config-services
-policycoreutils-gui

# use the PackageKit helper for bash
#PackageKit-command-not-found

# why does the obsoletes not work ?!
#-lzma
xz-lzma-compat

# Things we do not need here
-a2ps
-abiword
-acpid
-aiksaurus
-aiksaurus-gtk
-alacarte
-apr
-apr-util
-apr-util-ldap
-aspell-*
-asunder
-at
-at-spi
-at-spi-python
-attr
-audit
-autocorr-en
-autofs
-balsa
-binutils
-bitstream-vera-sans-fonts
-bitstream-vera-sans-mono-fonts
-bitstream-vera-serif-fonts
-btrfs-progs
-caja-share
-caribou
-ccid
-cdparanoia
-clearlooks-compact-gnome-theme
-clutter
-compat*
-coolkey
-dasher
-deja-dup
-desktop-backgrounds-compat
-ed
-ekiga
-eog
-eog-plugins
-evolution
-evolution-data-server
-evolution-help
-festival
-festival-lib
-festival-speechtools-libs
-festvox-slt-arctic-hts
-firstaidkit
-firstaidkit-gui
-firstaidkit-plugin-all
-genisoimage
-gettext
-gimp
-gnome-activity-journal
-baobab
-gnome-dictionary
-gnome-paint
-gnome-system-log
-gnome-user-docs
-gnote
-gpm
-groff
-gthumb
-gtk2-immodules
-gtk3-immodules
-gtkmathview
-hal-storage-addon
-hplip-gui
-ibus*
-ibus-gtk2
-ibus-gtk3
-icedax
-ImageMagick-c++
-im-chooser
-inkscape
-iok
-iptstate
-ipcalculator
-isdn4k-utils
-isomd5sum
-istanbul
-krb5-workstation
-ksh
-lftp
-libabiword
-libmx
-liferea
-lm_sensors
-logwatch
-m17n*
-mailx
-memtest86+
-mencoder
-mgetty
-mlocate
-mod_dnssd
-mpage
-mtr
-mypaint
-net-snmp-libs
-NetworkManager-pptp
-NetworkManager-vpnc
-nfs-utils
-nmap
-notification-daemon-engine-nodoka
-nss-mdns
-numactl
openssh-server
-orca
-p7zip-plugins
-phonon
-phonon-backend-gstreamer
-pidgin
-pidgin-sipe
-pilot-link
-pinfo
-pitivi
-planner
-portreserve
-prelink
-psacct
-ptouch-driver
-pulseaudio-equalizer
-pulseaudio-module-bluetooth
-purple-microblog
-purple-plugin-pack-pidgin
-quota
-rpcbind
-rsh
-seahorse-plugins
-setroubleshoot
-setroubleshoot-plugins
-setroubleshoot-server
-shotwell
-sos
-sound-juicer
-sox
-sssd
-sssd-client
-symlinks
-system-config-network
-talk
-tcp_wrappers
-telepathy-gabble
-telepathy-haze
-telepathy-salut
-telnet
-thunderbird
-tomboy
-tsclient
-vcdimager
-vconfig
-vino
-wireshark
-words
-xournal
-xsane
-xsane-gimp
-xterm
-ypbind
-yp-tools
-yum-plugin-auto-update-debug-info
-yum-plugin-remove-with-leaves
-yum-plugin-upgrade-helper
-adwaita-gtk2-theme
-xcursor-themes
abattis-cantarell-fonts
unifont-fonts
mozilla-fira-mono-fonts
mozilla-fira-sans-fonts
linux-libertine-fonts
-google-droid-kufi-fonts
-google-droid-sans-fonts
-google-droid-serif-fonts
google-noto-emoji-color-fonts
google-noto-emoji-fonts
julietaula-montserrat-fonts

# Fedora stuff that should be removed because copyright
#-constantine-backgrounds

# Neither we need these backgrounds
-desktop-backgrounds-basic

anaconda
appcenter
authconfig-gtk
avahi
avahi-dnsconfd
bc
bind-utils
-blackbox
bluez
bluez-cups
bluez-hid2hci
bluez-obexd
cabextract
cifs-utils
kernel-tools
cups-bjnp
cups-pk-helper
dejavu-*fonts
device-mapper-multipath
dump
e2fsprogs
elogind
ethtool
ffmpeg
finger
firewall-applet
firewalld
firstboot
flac
flatpak
foo2hbpl
foo2hiperc
foo2hp
foo2lava
foo2oak
foo2qpdl
foo2slx
foo2xqx
foo2zjs
fprintd-pam
ftp
ghostscript-fonts
git
-gnome-mag
gnome-nettool
gnome-packagekit
gnu-free-fonts-common
gnu-free-mono-fonts
gnu-free-sans-fonts
gnu-free-serif-fonts
gnupg
gnupg2
gvfs-afc
gvfs-afp
gvfs-archive
gvfs-fuse
gvfs-gphoto2
gvfs-smb
hardcode-tray
hplip
info
iscsi-initiator-utils
-java-1.8.0-openjdk
-java-1.8.0-openjdk-headless
libcanberra-gtk2
libcanberra-gtk3
liberation-mono-fonts
liberation-sans-fonts
liberation-serif-fonts
libsane-hpaio
libvpx-utils
lsof
lvm2
lzip
madwimax
man-db
man-pages-es
mdadm
minicom
mkbootdisk
mousetweaks
mozilla-filesystem
mozilla-https-everywhere
mozilla-privacy-badger
mozilla-ublock-origin
nano
nc
net-tools
NetworkManager
NetworkManager-adsl
network-manager-applet
-NetworkManager-openvpn
NetworkManager-tui
NetworkManager-wifi
NetworkManager-wwan
ntfsprogs
ntp
ntsysv
onboard
openssh-askpass
openssh-clients
p7zip
PackageKit
PackageKit-command-not-found
PackageKit-gstreamer-plugin
PackageKit-gtk3-module
PackageKit-yum
PackageKit-yum-plugin
pam_pkcs11
parted
pciutils
piramide-palenque-background-grub2
plymouth-plugin-label
plymouth-plugin-two-step
plymouth-system-theme
plymouth-theme-spinfinity
ppp
qgnomeplatform
redshift
redshift-gtk
rmt
rootfiles
rpm-sign
rp-pppoe
rsync
samba-client
samba-winbind-clients
sane-backends
sane-backends-drivers-scanners
setserial
setuptool
smartmontools
squashfs-tools
sudo
-subversion
system-config-boot
system-config-date
-system-config-firewall
system-config-firewall-tui
system-config-keyboard
system-config-language
system-config-lvm
system-config-network-tui
system-config-printer
system-config-rootpassword
system-config-services
system-config-users
system-switch-java
tcpdump
-texlive*
time
traceroute
-tracker
tree
unrar
unzip
urw-base35-fonts
usb_modeswitch
usb_modeswitch-data
usbutils
usermode
usermode-gtk
vim-enhanced
vorbis-tools
whois
wireless-tools
wodim
wpa_supplicant
wvdial
x264
xdg-user-dirs-gtk
xorg-x11-apps
-xournalpp
yelp
yum-NetworkManager-dispatcher
yum-utils

# Extra drivers
libva-intel-driver
libva-vdpau-driver
libvdpau-va-gl
mesa-libXvMC
mesa-vdpau-drivers
vdpauinfo
xorg-x11-drivers
xorg-x11-drv-vmware
xorg-x11-drv-wacom
# fonts needed for xterm
# xorg-x11-fonts-misc

%end

