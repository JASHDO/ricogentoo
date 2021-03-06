# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2x00/rt2x00-9999.ebuild,v 1.22 2007/08/29 19:05:19 genstef Exp $

inherit linux-mod cvs

DESCRIPTION="Driver for the RaLink RT2x00 wireless chipsets"
HOMEPAGE="http://rt2x00.serialmonkey.com"
LICENSE="GPL-2"

ECVS_SERVER="rt2400.cvs.sourceforge.net:/cvsroot/rt2400"
ECVS_MODULE="source/rt2x00"
ECVS_LOCALNAME="${P}"

KEYWORDS="-* ~amd64 ~x86"
RDEPEND="net-wireless/wireless-tools"

IUSE_RT2X00_DEVICES="rt2400pci rt2500pci rt2500usb rt61pci rt73usb"
IUSE_RT2X00_EXTRA="rfkill"
IUSE="asm debug"

for x in ${IUSE_RT2X00_DEVICES} ${IUSE_RT2X00_EXTRA} ; do
	IUSE="${IUSE} ${x}"
done

pkg_setup() {
	CONFIG_CHECK="WIRELESS_EXT"
	ERROR_WIRELESS_EXT="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_WIRELESS_EXT)."

	# dScape requires some crypto
	CONFIG_CHECK="${CONFIG_CHECK} CRYPTO_AES CRYPTO_ARC4"
	ERROR_CRYPTO_AES="${P} requires support for AES Cryptography (CONFIG_CRYPTO_AES)."
	ERROR_CRYPTO_ARC4="${P} requires support for ARC4 Cryptography (CONFIG_CRYPTO_ARC4)."

	if use rfkill ; then
		CONFIG_CHECK="${CONFIG_CHECK} INPUT"
	fi

	if use rt2400pci \
		|| use rt2500pci \
		|| use rt61pci ; then
		CONFIG_CHECK="${CONFIG_CHECK} PCI"
	fi

	if use rt2500usb || use rt73usb ; then
		CONFIG_CHECK="${CONFIG_CHECK} USB"
	fi

	if use rt61pci || use rt73usb ; then
		CONFIG_CHECK="${CONFIG_CHECK} FW_LOADER"
		ERROR_FW_LOADER="${P} requires support for Firmware module loading (CONFIG_FW_LOADER)."
	fi

	if use debug ; then
		CONFIG_CHECK="${CONFIG_CHECK} DEBUG_FS"
		ERROR_DEBUG_FS="${P} requires Kernel Debug FS support (CONFIG_DEBUG_FS)"
	fi

	kernel_is lt 2 6 17 && die "${P} requires at least kernel 2.6.17"
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNDIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
	BUILD_TARGETS=" " # Target "module" is not supported, so we blank it
}

src_compile() {
	local m= asm="n" button="n" debug="n" full="y" yn= M=

	use asm && asm="y"
	use debug && debug="y"

	for m in ${IUSE_RT2X00_DEVICES} ; do
		if use "${m}" ; then
			full="n"
			break
		fi
	done

	if [[ ${full} == "n" ]] ; then
		use rfkill && button="y"
	else
		ewarn "No module specified in USE flags - building everything."
		button="y"
	fi

	# Generate the config file now
	echo "# Config file generated by portage" > config
	# D80211 module
	echo "CONFIG_D80211=y" >> config
	echo "CONFIG_D80211_DEBUG=${debug}" >> config
	echo "CONFIG_D80211_ASM=${asm}" >> config
	MODULE_NAMES="80211(rt2x00:) rc80211_simple(rt2x00:)"

	# Enable the rt2x00lib module
	echo "CONFIG_RT2X00=y" >> config
	echo "CONFIG_RT2X00_ASM=${asm}" >> config
	MODULE_NAMES="${MODULE_NAMES} rt2x00lib(rt2x00:)"

	# Enable the new DEBUGFS module
	if use debug ; then
		echo "CONFIG_RT2X00_DEBUG=y" >> config
		echo "CONFIG_RT2X00_DEBUGFS=y" >> config
		MODULE_NAMES="${MODULE_NAMES} rt2x00debug(rt2x00:)"
	fi

	# RT61 and RT73 require CONFIG_CRC_ITU_T
	if [[ ${full} == "y" ]] || \
		use rt61pci || use rt73usb ; then
		echo "CONFIG_CRC_ITU_T=y" >> config
		echo "CONFIG_CRC_ITU_T_ASM=${asm}" >> config
		MODULE_NAMES="${MODULE_NAMES} crc-itu-t(rt2x00:)"
	fi

	# rt2400pci, rt2500pci and rt61pci require the EEPROM module
	if use rt2400pci || use rt2500pci || use rt61pci || [[ ${full} == "y" ]] ; then
		echo "CONFIG_EEPROM_93CX6=y" >> config
		echo "CONFIG_EEPROM_93CX6_ASM=${asm}" >> config
		MODULE_NAMES="${MODULE_NAMES} eeprom_93cx6(rt2x00:)"
	fi

	for m in ${IUSE_RT2X00_EXTRA} ${IUSE_RT2X00_DEVICES} ; do
		local yn="n" M=$(echo "${m}" | tr '[:lower:]' '[:upper:]')

		if [[ ${full} == "y" ]] || use "${m}" ; then
			yn="y"
		fi
		echo "CONFIG_${M}=${yn}" >> config
		echo "CONFIG_${M}_BUTTON=${button}" >> config

		if [[ ${yn} == "y" ]] ; then
			MODULE_NAMES="${MODULE_NAMES} ${m}(rt2x00:)"
		fi
	done

	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dodoc CHANGELOG COPYING README THANKS
}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn
	ewarn "This is a CVS ebuild - please report any bugs to the rt2x00 forums"
	ewarn "http://rt2x00.serialmonkey.com/phpBB2/viewforum.php?f=5"
	ewarn
	ewarn "Any bugs reported to Gentoo will be marked INVALID"
	ewarn
}
