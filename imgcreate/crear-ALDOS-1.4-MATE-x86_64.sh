#!/bin/bash
RUTA=(`pwd`)
FECHA=(`date +%Y%m%d`)
sudo cp -a *.ks /etc/comps.xml /usr/share/alcancelibre-release-notes/
sudo mkdir -p /var/tmp/livecd/x86_64
sudo modprobe loop > /dev/null 2>&1 ||:
sudo rm -fr ${RUTA}/CACHE/FC14/*/ALDOS/
sudo rm -f ${RUTA}/ALDOS-1.4.16-Xfce-x86_64-$FECHA.*
sudo rm -f ${RUTA}/ALDOS-1.4.16-Xfce-x86_64.log
date > tiempos_mate-mate-x86_64.txt
sudo livecd-creator -v -d \
	--logfile=${RUTA}/ALDOS-1.4.16-Xfce-x86_64.log \
	--compression-type=xz \
	--cache=/var/tmp/livecd/x86_64/CACHE/FC14/x86_64 \
	--tmpdir=/var/tmp/livecd/x86_64/ALDOS-$FECHA \
	--fslabel=ALDOS64$FECHA \
	-c ${RUTA}/ALDOS-1.4-MATE-x86_64.ks || exit 1
mv ALDOS64$FECHA.iso ALDOS-1.4.16-MATE-x86_64-$FECHA.iso
sudo md5sum ALDOS-1.4.16-MATE-x86_64-$FECHA.iso > ${RUTA}/ALDOS-1.4.16-MATE-x86_64-$FECHA.md5sum || exit 1
sudo sha512sum ALDOS-1.4.16-MATE-x86_64-$FECHA.iso > ${RUTA}/ALDOS-1.4.16-MATE-x86_64-$FECHA.sha512sum || exit 1
sudo chown jbarrios:jbarrios ${RUTA}/ || exit 1
date >> tiempos_x86_64.txt
sudo rm -fr ${RUTA}/base ${RUTA}/updates ${RUTA}/adobe ${RUTA}/ALDOS ${RUTA}/ALDOS-beta* ${RUTA}/ALDOS-updates ${RUTA}/ALDOS-mate* ${RUTA}/CACHE/* ${RUTA}/ALDOS-nonfree* ${RUTA}/eudev /tmp/ALDOS-$FECHA /tmp/CACHE ${RUTA}/Extras
sudo rm -fr ALDOS ALDOS-beta ALDOS-beta-nonfree ALDOS-mate ALDOS-mate-updates ALDOS-next ALDOS-nonfree ALDOS-nonfree-updates ALDOS-updates  > /dev/null 2&>1 ||:
sleep 10
sudo losetup --detach-all
sudo rm -fr /var/tmp/livecd/x86_64

