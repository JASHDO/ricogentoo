# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usb_modeswitch/usb_modeswitch-1.1.9.ebuild,v 1.3 2011/10/04 21:31:28 phajdan.jr Exp $

EAPI="4"
inherit multilib toolchain-funcs

MY_PN="${PN/_/-}"
MY_P="${MY_PN}-${PV}"
DATA_VER="20110805"

DESCRIPTION="USB_ModeSwitch is a tool for controlling 'flip flop' (multiple devices) USB gear like UMTS sticks"
HOMEPAGE="http://www.draisberghof.de/usb_modeswitch/"
SRC_URI="http://www.draisberghof.de/${PN}/${MY_P}.tar.bz2
	http://www.draisberghof.de/${PN}/${MY_PN}-data-${DATA_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}
	dev-lang/tcl" # usb_modeswitch script is tcl

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e 's/-s //' Makefile || die 'sed failed.'
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	local udevdir="${D}/$(get_libdir)/udev"
	emake DESTDIR="${D}" UDEVDIR="${udevdir}" install

	cd ../"${MY_PN}-data-${DATA_VER}"
	emake DESTDIR="${D}" RULESDIR="${udevdir}/rules.d" files-install db-install
}
