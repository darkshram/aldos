# fedora-live-base.ks
#
# Defines the basics for all kickstarts in the fedora-live branch
# Does not include package selection (other then mandatory)
# Does not include localization packages or configuration
#
# Does includes "default" language configuration (kickstarts including
# this template can override these settings)

%packages
-@base-x
@base
@core
-@admin-tools
@dial-up
@hardware-support
@printing
kernel
memtest86+
filesystem
kmod-staging
-VirtualBox*
-kmod-VirtualBox*
setup
efibootmgr
-grub
-grub-efi
grub2
grub2-efi
anaconda-livesys

# Specific to ALDOS
alcancelibre-bookmarks
alcancelibre-icons
alcancelibre-logos
alcancelibre-release-notes
# because the grub theme background image
grub2-starfield-theme

# extra firmware
b43-openfwwf
bcm43xx-fwcutter
ipw2100-firmware
ipw2200-firmware
iwl1000-firmware
iwl100-firmware
iwl3945-firmware
iwl4965-firmware
iwl5000-firmware
iwl6000-firmware
iwl6000g2a-firmware
iwl6000g2b-firmware
iwl6050-firmware
iwl7260-firmware
libertas-sd8686-firmware
libertas-usb8388-firmware
linux-firmware
#firstaidkit-plugin-all

# save some space
-esc
-samba-client
-a2ps
axel
aria2
bolt
bwping
-mpage
redhat-lsb-printing
sox
-sendmail
#ssmtp
-numactl
-isdn4k-utils
-autofs
# smartcards won't really work on the livecd.
-coolkey
-ccid
# duplicate functionality
-pinfo
wget
# lose the compat stuff
-compat*
-aircrack-ng
arp-scan
-atop
-biosdevname
bmon
btrfs-progs
bwm-ng
cmus
kernel-tools
cryptopp-progs
crypto-utils
curl
-darkstat
dateutils
ddgr
-dnf
dnstop
dstat
-duplicity
eudev
-exfat-utils
exfatprogs
-f2fs-tools
ftp
-fuse-exfat
fuse-sshfs
glances
gst123
hping3
httping
htop
ifstat
iftop
iotop
iptraf-ng
iptstate
ipv6calc
jpegoptim
keyutils
kmod-exfat
lftp
-libressl*
libselinux-utils
links
-lynx
ModemManager
mtx
nbtscan
netcalc
nethogs
-netmonitor
netsniff-ng
ngrep
nload
nmap
nmap-ncat
nscd
nss-mdns
-omping
openldap
opensmtpd
optipng
-plowshare
policycoreutils
-procmail
#rfkill
rpmorphan
sc
screen
screenfetch
sdparm
sg3_utils
sipcalc
-smtpping
spectre-meltdown-checker
speedtest-cli
-sslscan
sysvinit-tools
tcalc
tcpcopy
tcpflow
tcpick
tcpreplay
-tcptrack
telnet
tnftp
trafshow
udftools
ugrep
-uperf
whatmask
whereami
whowatch
xfsprogs
youtube-dl
yum-plugin-tmprepo
zerofree
zip

# Init systems
upstart
#epoch

# qlogic firmwares
#-ql2100-firmware
#-ql2200-firmware
#-ql23xx-firmware
#-ql2400-firmware

# scanning takes quite a bit of space :/
-xsane
-xsane-gimp
-sane-backends

# livecd bits to set up the livecd and be able to install
anaconda
isomd5sum

# commented out to avoid warning
# # make sure debuginfo doesn't end up on the live image
#-*debuginfo
%end

%post
# Force changed blocks to disk, update the super block.
# echo "Force changed blocks to disk, update the super block."
# sync

#touch /.epoch-default-init
if [ -f /.epoch-default-init ] ; then
echo -e "Setting Epoch as default init system."
# Remove upstart components.
rm -f /sbin/init
rm -f /sbin/halt
rm -f /sbin/poweroff
rm -f /sbin/reboot
rm -f /sbin/runlevel
rm -f /sbin/shutdown
rm -f /sbin/telinit
# Epoch components.
ln -sf ../lib/epoch/epoch /bin/wall
ln -sf ../lib/epoch/epoch /sbin/init
ln -sf ../lib/epoch/epoch /sbin/poweroff
ln -sf ../lib/epoch/epoch /sbin/reboot
ln -sf ../lib/epoch/epoch /sbin/shutdown
ln -sf ../lib/epoch/halt /sbin/halt
ln -sf ../lib/epoch/runlevel /sbin/runlevel
ln -sf ../lib/epoch/telinit /sbin/telinit
fi
rm -f /.epoch-default-init

# work around for poor key import UI in PackageKit
rm -f /var/lib/rpm/__db*
echo "Import AL-RPM-KEY"
rpm --import /etc/pki/rpm-gpg/AL-RPM-KEY
if [ -f /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux ]
then
echo "Import RPM-GPG-KEY-adobe-linux"
	rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
fi

echo "limpia directorio de trabajo"
rm -fr /home/jbarrios/rpmbuild/TMP
rm -fr /home/jbarrios/rpmbuild
rmdir /home/jbarrios >/dev/null 2>&1
rm -f /etc/rpm/macros.imgcreate /etc/rpm/macros.lang

if [ -f /usr/share/applications/gparted.desktop ]
then
echo "NoDisplay=true" >> /usr/share/applications/gparted.desktop
fi

if [ -f /usr/share/applications/org.kde.partitionmanager.desktop ]
then
echo "NoDisplay=true" >> /usr/share/applications/org.kde.partitionmanager.desktop
fi

# mate-terminal crashes a lot. Not sure about the following script.
#if [ -f /usr/share/applications/mate-terminal.desktop ]
#then
#echo "NoDisplay=true" >> /usr/share/applications/mate-terminal.desktop
#fi

if [ -f /usr/share/applications/fedora-lash-panel.desktop ]
then
echo "NoDisplay=true" >> /usr/share/applications/fedora-lash-panel.desktop
fi

echo "blacklist jmb38x_ms"
echo "blacklist jmb38x_ms" > /etc/modprobe.d/blacklist-jmb38x.conf

echo "Create liveinst.desktop"
echo -e "[Desktop Entry]\nName=Install ALDOS in this machine\nName[es]=Instalar ALDOS en este equipo\nGenericName=Install\nGenericName[es]=Instalar\nComment=Install the ALDOS live CD in your machine\nComment[es]=Instalar el CD vivo de ALDOS en su equipo\nCategories=System;Utility;X-Red-Hat-Base;X-Fedora;GNOME;GTK;\nExec=/usr/bin/liveinst\nTerminal=false\nType=Application\nIcon=package-install\nEncoding=UTF-8\nStartupNotify=true\nNoDisplay=true\nX-Desktop-File-Install-Version=0.15" > /usr/share/applications/liveinst.desktop

echo "Set default system-config-firewall"
echo -e "# Configuration file for system-config-firewall\n\n--enabled\n--service=ipp-client\n--service=samba-client\n--service=mdns\n--service=ssh" > /etc/sysconfig/system-config-firewall

echo "Set default iptables options"
echo -e "IPTABLES_MODULES=\"nf_conntrack_netbios_ns\"\nIPTABLES_MODULES_UNLOAD=\"yes\"\nIPTABLES_SAVE_ON_STOP=\"no\"\nIPTABLES_SAVE_ON_RESTART=\"no\"\nIPTABLES_SAVE_COUNTER=\"no\"\nIPTABLES_STATUS_NUMERIC=\"yes\"\nIPTABLES_STATUS_VERBOSE=\"no\"\nIPTABLES_STATUS_LINENUMBERS=\"yes\"\n" > /etc/sysconfig/iptables-config

echo -e "IP6TABLES_MODULES=\"nf_conntrack_netbios_ns\"\nIP6TABLES_MODULES_UNLOAD=\"yes\"\nIP6TABLES_SAVE_ON_STOP=\"no\"\nIP6TABLES_SAVE_ON_RESTART=\"no\"\nIP6TABLES_SAVE_COUNTER=\"no\"\nIP6TABLES_STATUS_NUMERIC=\"yes\"\nIP6TABLES_STATUS_VERBOSE=\"no\"\nIP6TABLES_STATUS_LINENUMBERS=\"yes\"" > /etc/sysconfig/ip6tables-config

echo "Set default iptables rules"
echo -e "# Firewall configuration written by system-config-firewall\n# Manual customization of this file is not recommended.\n*filter\n:INPUT ACCEPT [0:0]\n:FORWARD ACCEPT [0:0]\n:OUTPUT ACCEPT [0:0]\n-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT\n-A INPUT -p icmp -j ACCEPT\n-A INPUT -i lo -j ACCEPT\n-A INPUT -m state --state NEW -m udp -p udp --dport 631 -j ACCEPT\n-A INPUT -m state --state NEW -m udp -p udp --dport 137 -j ACCEPT\n-A INPUT -m state --state NEW -m udp -p udp --dport 138 -j ACCEPT\n-A INPUT -m state --state NEW -m udp -p udp --dport 5353 -d 224.0.0.251 -j ACCEPT\n-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT\n-A INPUT -j REJECT --reject-with icmp-host-prohibited\n-A FORWARD -j REJECT --reject-with icmp-host-prohibited\nCOMMIT\n" > /etc/sysconfig/iptables

echo "Set default ip6tables rules"
echo -e "# Firewall configuration written by system-config-firewall\n# Manual customization of this file is not recommended.\n*filter\n:INPUT ACCEPT [0:0]\n:FORWARD ACCEPT [0:0]\n:OUTPUT ACCEPT [0:0]\n-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT\n-A INPUT -p ipv6-icmp -j ACCEPT\n-A INPUT -i lo -j ACCEPT\n-A INPUT -m state --state NEW -m udp -p udp --dport 631 -j ACCEPT\n-A INPUT -m state --state NEW -m udp -p udp --dport 137 -j ACCEPT\n-A INPUT -m state --state NEW -m udp -p udp --dport 138 -j ACCEPT\n-A INPUT -m state --state NEW -m udp -p udp --dport 5353 -d ff02::fb -j ACCEPT\n-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT\n-A INPUT -j REJECT --reject-with icmp6-adm-prohibited\n-A FORWARD -j REJECT --reject-with icmp6-adm-prohibited\nCOMMIT" > /etc/sysconfig/ip6tables

echo "Set default permision for iptables/ip6tables rules files"
chmod 600 /etc/sysconfig/ip*tables*

echo -e "passwd:     files sss\nshadow:     files sss\ngroup:      files sss\ninitgroups: files\nhosts:      files mdns4_minimal [NOTFOUND=return] dns wins mdns4\nbootparams: nisplus [NOTFOUND=return] files\nethers:     files\nnetmasks:   files\nnetworks:   files\nprotocols:  files\nrpc:        files\nservices:   files sss\nnetgroup:   nisplus sss\npublickey:  nisplus\nautomount:  files nisplus\naliases:    files nisplus\n" > /etc/nsswitch.conf

echo "Disabling zram in the livecd."
echo -e "manual" > /etc/init/zram.override

echo "LiveCD fixes."
cat << EOF > /etc/init/fixes-livecd.conf
# Re-enable zram
# Zram is disabled in the liveCD to prevent conflict with anaconda installer.
# This script removes /etc/init/zram.override and itself after the very first
# system boot.

start on runlevel [12345]

task

script
sed -i -e 's,ONBOOT="no",ONBOOT="yes",g' /etc/sysconfig/network-scripts/ifcfg-eth0 >/dev/null 2>&1 || :
sed -i -e 's,ONBOOT="no",ONBOOT="yes",g' /etc/sysconfig/network-scripts/ifcfg-em1 >/dev/null 2>&1 || :
rm -f /etc/init/fixes-livecd.conf
rm -f /etc/init/zram.override
end script
EOF

# go ahead and pre-make the man -k cache (#455968)
if [ -f /usr/sbin/makewhatis ]
then
/usr/sbin/makewhatis -w
fi

# save a little bit of space at least...
rm -f /boot/initrd*
# make sure there aren't core files lying around
rm -f /core*

# Force required setgids and setuids
echo "Fix required setgids and setuids."
/bin/chmod 755 /sys
/bin/chgrp disk /lib/udev/devices/loop* > /dev/null 2>&1 ||:
if [ -f /etc/localtime ] ; then
/bin/chmod 644 /etc/localtime > /dev/null 2>&1 ||:
fi
if [ -f /sbin/netreport ] ; then
/bin/chmod 2755 /sbin/netreport > /dev/null 2>&1 ||:
fi
if [ -f /usr/bin/lockfile ] ; then
/bin/chgrp mail /usr/bin/lockfile > /dev/null 2>&1 ||:
/bin/chmod 2755 /usr/bin/lockfile > /dev/null 2>&1 ||:
fi
if [ -f /usr/bin/ssh-agent ] ; then
/bin/chgrp nobody /usr/bin/ssh-agent > /dev/null 2>&1 ||:
/bin/chmod 2111 /usr/bin/ssh-agent > /dev/null 2>&1 ||:
fi
if [ -f /usr/bin/wall ] ; then
/bin/chgrp tty /usr/bin/wall > /dev/null 2>&1 ||:
/bin/chmod 2555 /usr/bin/wall > /dev/null 2>&1 ||:
fi
if [ -f /usr/bin/write ] ; then
/bin/chgrp tty /usr/bin/write > /dev/null 2>&1 ||:
/bin/chmod 2755 /usr/bin/write > /dev/null 2>&1 ||:
fi
if [ -f /usr/libexec/openssh/ssh-keysign ] ; then
/bin/chgrp ssh_keys /usr/libexec/openssh/ssh-keysign > /dev/null 2>&1 ||:
/bin/chmod 2111 /usr/libexec/openssh/ssh-keysign > /dev/null 2>&1 ||:
fi
if [ -f /usr/sbin/lockdev ] ; then
/bin/chgrp lock /usr/sbin/lockdev > /dev/null 2>&1 ||:
/bin/chmod 2711 /usr/sbin/lockdev > /dev/null 2>&1 ||:
fi
if [ -f /usr/sbin/sendmail.sendmail ] ; then
/bin/chgrp smmsp /usr/sbin/sendmail.sendmail > /dev/null 2>&1 ||:
/bin/chmod 2755 /usr/sbin/sendmail.sendmail > /dev/null 2>&1 ||:
fi
if [ -f /usr/bin/procmail ] ; then
/bin/chgrp mail /usr/bin/procmail > /dev/null 2>&1 ||:
fi
if [ -f /usr/lib*/vte/gnome-pty-helper ] ; then
/bin/chgrp utmp /usr/lib*/vte/gnome-pty-helper > /dev/null 2>&1 ||:
/bin/chmod 2711 /usr/lib*/vte/gnome-pty-helper > /dev/null 2>&1 ||:
fi
if [ -f /usr/lib*/vte-2.91/gnome-pty-helper ] ; then
/bin/chgrp utmp /usr/lib*/vte-2.91/gnome-pty-helper > /dev/null 2>&1 ||:
/bin/chmod 2711 /usr/lib*/vte-2.91/gnome-pty-helper > /dev/null 2>&1 ||:
fi
if [ -f /bin/mount ] ; then
/bin/chmod 4755 /bin/mount > /dev/null 2>&1 ||:
fi
if [ -f /bin/umount ] ; then
/bin/chmod 4755 /bin/umount > /dev/null 2>&1 ||:
fi
if [ -f /usr/bin/at ] ; then
/bin/chmod 4755 /usr/bin/at > /dev/null 2>&1 ||:
fi
if [ -f /usr/bin/chfn ] ; then
/bin/chmod 4711 /usr/bin/chfn > /dev/null 2>&1 ||:
fi
if [ -f /usr/bin/chsh ] ; then
/bin/chmod 4711 /usr/bin/chsh > /dev/null 2>&1 ||:
fi
if [ -f /usr/sbin/usernetctl ] ; then
/bin/chmod 4755 /usr/sbin/usernetctl > /dev/null 2>&1 ||:
fi
if [ -f /lib*/dbus-1/dbus-daemon-launch-helper ] ; then
/bin/chgrp dbus /lib*/dbus-1/dbus-daemon-launch-helper > /dev/null 2>&1 ||:
/bin/chmod 4750 /lib*/dbus-1/dbus-daemon-launch-helper > /dev/null 2>&1 ||:
fi
if [ -d /var/lib/pulse ] ; then
/bin/chown pulse:pulse /var/lib/pulse > /dev/null 2>&1 ||:
fi
if [ -d /var/spool/clientmqueue ] ; then
/bin/chown smmsp:smmsp /var/spool/clientmqueue > /dev/null 2>&1 ||:
fi
if [ -d /var/spool/mqueue ] ; then
/bin/chgrp mail /var/spool/mqueue > /dev/null 2>&1 ||:
fi
if [ -d /var/lock/lockdev ] ; then
/bin/chgrp lock /var/lock/lockdev > /dev/null 2>&1 ||:
/bin/chmod 775 /var/lock/lockdev > /dev/null 2>&1 ||:
fi
if [ -d /var/lib/lightdm ] ; then
/bin/chgrp lightdm /var/lib/lightdm > /dev/null 2>&1 ||:
fi
if [ -d /var/lib/lightdm-data ] ; then
/bin/chgrp lightdm /var/lib/lightdm-data > /dev/null 2>&1 ||:
fi
if [ -d /var/log/lightdm ] ; then
/bin/chgrp lightdm /var/log/lightdm > /dev/null 2>&1 ||:
fi
if [ -d /var/cache/lightdm ] ; then
/bin/chgrp lightdm /var/cache/lightdm > /dev/null 2>&1 ||:
fi
if [ -f /etc/cups/client.conf ] ; then
/bin/chgrp lp /etc/cups/client.conf > /dev/null 2>&1 ||:
fi
if [ -f /etc/cups/cupsd.conf.default ] ; then
/bin/chgrp lp /etc/cups/cupsd.conf.default > /dev/null 2>&1 ||:
fi
if [ -f /etc/cups/lpoptions ] ; then
/bin/chgrp lp /etc/cups/lpoptions > /dev/null 2>&1 ||:
fi
if [ -f /etc/cups/snmp.conf ] ; then
/bin/chgrp lp /etc/cups/snmp.conf > /dev/null 2>&1 ||:
fi
if [ -f /etc/cups/subscriptions.conf ] ; then
/bin/chgrp lp /etc/cups/subscriptions.conf > /dev/null 2>&1 ||:
fi
if [ -d /var/log/cups ] ; then
/bin/chown lp:sys /var/log/cups > /dev/null 2>&1 ||:
/bin/chmod 755 /var/log/cups > /dev/null 2>&1 ||:
fi
if [ -d /var/spool/at ] ; then
/bin/chown daemon:daemon /var/spool/at > /dev/null 2>&1 ||:
/bin/chown daemon:daemon /var/spool/at/spool > /dev/null 2>&1 ||:
/bin/chmod 700 /var/spool/at > /dev/null 2>&1 ||:
/bin/chmod 700 /var/spool/at/spool > /dev/null 2>&1 ||:
fi
if [ -d /var/run/hplip ] ; then
/bin/chgrp lp /var/run/hplip > /dev/null 2>&1 ||:
/bin/chmod 775 /var/run/hplip > /dev/null 2>&1 ||:
fi
if [ -d /usr/libexec/utempter ] ; then
/bin/chgrp utempter /usr/libexec/utempter  > /dev/null 2>&1 ||:
/bin/chmod 755 /usr/libexec/utempter  > /dev/null 2>&1 ||:
fi
if [ -f /usr/libexec/utempter/utempter ] ; then
/bin/chgrp utmp /usr/libexec/utempter/utempter > /dev/null 2>&1 ||:
/bin/chmod 2711 /usr/libexec/utempter/utempter > /dev/null 2>&1 ||:
fi
if [ -d /etc/ntp/crypto ] ; then
/bin/chgrp ntp /etc/ntp/crypto > /dev/null 2>&1 ||:
/bin/chmod 750 /etc/ntp/crypto > /dev/null 2>&1 ||:
fi
if [ -d /var/lib/ntp ] ; then
/bin/chgrp ntp /var/lib/ntp > /dev/null 2>&1 ||:
/bin/chmod 755 /var/lib/ntp > /dev/null 2>&1 ||:
fi
if [ -d /var/log/ntpstats ] ; then
/bin/chgrp ntp /var/log/ntpstats  > /dev/null 2>&1 ||:
/bin/chmod 755 /var/lib/ntp > /dev/null 2>&1 ||:
fi
if [ -d /var/lib/samba/winbindd_privileged ] ; then
/bin/chgrp wbpriv /var/lib/samba/winbindd_privileged > /dev/null 2>&1 ||:
/bin/chmod 750 /var/lib/samba/winbindd_privileged > /dev/null 2>&1 ||:
fi
if [ -f /etc/tcsd.conf ] ; then
/bin/chown tss:tss /etc/tcsd.conf > /dev/null 2>&1 ||:
/bin/chmod 600 /etc/tcsd.conf > /dev/null 2>&1 ||:
fi
if [ -d /var/lib/tpm ] ; then
/bin/chown tss:tss /var/lib/tpm > /dev/null 2>&1 ||:
/bin/chmod 700 /var/lib/tpm > /dev/null 2>&1 ||:
fi
if [ -f /etc/dumpdates ] ; then
/bin/chgrp disk /etc/dumpdates > /dev/null 2>&1 ||:
/bin/chmod 664 /etc/dumpdates > /dev/null 2>&1 ||:
fi
if [ -f /etc/ppp/peers/wvdial ] ; then
/bin/chgrp daemon /etc/ppp/peers/wvdial > /dev/null 2>&1 ||:
/bin/chmod 600 /etc/ppp/peers/wvdial > /dev/null 2>&1 ||:
fi
if [ -d /var/spool/mail ] ; then
/bin/chgrp mail /var/spool/mail > /dev/null 2>&1 ||:
/bin/chmod 775 /var/spool/mail > /dev/null 2>&1 ||:
fi
if [ -d /var/run/darkstat ] ; then
/bin/chown darkstat /var/run/darkstat > /dev/null 2>&1 ||:
/bin/chgrp darkstat /var/run/darkstat > /dev/null 2>&1 ||:
fi
if [ -d /var/lib/geoclue ] ; then
/bin/chown -R geoclue /var/lib/geoclue > /dev/null 2>&1 ||:
/bin/chgrp -R geoclue /var/lib/geoclue > /dev/null 2>&1 ||:
fi
if [ -d /etc/polkit-1/rules.d ] ; then
/bin/chown polkitd /etc/polkit-1/rules.d > /dev/null 2>&1 ||:
/bin/chown polkitd /usr/share/polkit-1/rules.d  > /dev/null 2>&1 ||:
fi
if [ -d /var/lib/colord ] ; then
/bin/chown -R colord /var/lib/colord > /dev/null 2>&1 ||:
/bin/chgrp -R colord /var/lib/colord > /dev/null 2>&1 ||:
fi

#mkdir -m 0700 -p /var/lib/authconfig/last
#touch /var/lib/authconfig/last/openldap.conf
#touch /var/lib/authconfig/last/libuser.conf
#touch /var/lib/authconfig/last/login.defs
#touch /var/lib/authconfig/last/nsswitch.conf

# limpia base de datos YUM
echo "limpia base de datos YUM"
rm -fr /var/lib/yum/{groups,history,repos,rpmdb-indexes,uuid,yumdb}
mkdir -p /var/lib/yum/{history,yumdb}

touch /etc/resolv.conf

# Force changed blocks to disk, update the super block.
# echo "Force changed blocks to disk and update the super block, again."
# killall authconfig >/dev/mull 2> /dev/null ||:
sync
sleep 30s

%end

%post --nochroot
echo -e "Copiando archivos *.ks"
mkdir -p $LIVE_ROOT/config/
cp /usr/share/alcancelibre-release-notes/ALDOS-1.4-i686.ks $LIVE_ROOT/config/
cp /usr/share/alcancelibre-release-notes/ALDOS-1.4-x86_64.ks $LIVE_ROOT/config/
cp /usr/share/alcancelibre-release-notes/ALDOS-1.4-Base.ks $LIVE_ROOT/config/
cp /usr/share/alcancelibre-release-notes/ALDOS-1.4-Desktop.ks $LIVE_ROOT/config/

echo -e "Creando fichero licencia..."
cp /usr/share/alcancelibre-release-notes/Licencia.txt $LIVE_ROOT/Licencia.txt

echo -e "Creando fichero LEEME.txt"
cp /usr/share/alcancelibre-release-notes/LEEME.txt $LIVE_ROOT/LEEME.txt

# only works on x86, x86_64
if [ "$(uname -i)" = "i386" -o "$(uname -i)" = "x86_64" ]; then
  if [ ! -d $LIVE_ROOT/LiveOS ]; then mkdir -p $LIVE_ROOT/LiveOS ; fi
  cp /usr/bin/livecd-iso-to-disk $LIVE_ROOT/LiveOS
fi

#hack to try to stop umount probs
#while (/usr/bin/lsof /dev/loop* | grep -v "$0" | grep "$INSTALL_ROOT")
#do
#	sleep 5s
#done

%end
