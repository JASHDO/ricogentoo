# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/fwlanusb/fwlanusb-1.00.00-r1.ebuild,v 1.1 2008/01/06 00:20:37 sbriesen Exp $

inherit eutils rpm linux-mod

DESCRIPTION="AVM kernel 2.6 modules for Fritz WLAN Stick"
HOMEPAGE="http://opensuse.foehr-it.de/"
SRC_URI="http://opensuse.foehr-it.de/rpms/10_3/src/${P%.*}-${P##*.}.src.rpm"

LICENSE="AVM-FW"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/fritz"

pkg_setup() {
	linux-mod_pkg_setup

	if ! kernel_is 2 6; then
		die "This package works only with 2.6 kernel!"
	fi

	BUILD_TARGETS="all"
	BUILD_PARAMS="KDIR=${KV_DIR} LIBDIR=${S}/src"
	MODULE_NAMES="${PN}(net:${S}/src)"
}

src_unpack() {
	rpm_src_unpack ${A} || die "failed to unpack ${A} file"
	convert_to_m "${S}/src/Makefile"
}

src_install() {
	linux-mod_src_install
	dodoc config-wpa*
	dohtml *.html
}
