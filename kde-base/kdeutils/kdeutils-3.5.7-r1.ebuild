# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.5.7-r1.ebuild,v 1.2 2008/01/06 21:18:52 philantrop Exp $

inherit kde-dist eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdeutils-3.5-patchset-02.tar.bz2"

DESCRIPTION="KDE utilities."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="crypt kdehiddenvisibility pbbuttonsd snmp xscreensaver"

BOTH_DEPEND="~kde-base/kdebase-${PV}
	snmp? ( net-analyzer/net-snmp )
	pbbuttonsd? ( app-laptop/pbbuttonsd )
	dev-lang/python
	dev-libs/gmp
	x11-libs/libXtst"

RDEPEND="${BOTH_DEPEND}
	crypt? ( app-crypt/gnupg
			app-crypt/pinentry )
	!x11-misc/superkaramba"

DEPEND="${BOTH_DEPEND}
	xscreensaver? ( x11-libs/libXScrnSaver )
	x11-libs/libX11
	x11-proto/xproto
	virtual/os-headers"

PATCHES="${FILESDIR}/klaptopdaemon-3.5.7-libXss-linking.patch
		${FILESDIR}/superkaramba-3.5.7-network_sensor.patch
		${FILESDIR}/klaptopdaemon-3.5.7-has_acpi_sleep.patch"
EPATCH_EXCLUDE="klaptopdaemon-3.5-suspend2+xsession-errors.diff"

pkg_setup() {
	if use crypt && ! built_with_use app-crypt/pinentry gtk && ! built_with_use app-crypt/pinentry qt3 ; then
		eerror "kgpg needs app-crypt/pinentry built with either the gtk or qt3 USE flag."
		eerror "Please enable either USE flag and re-install app-crypt/pinentry."
		die "app-crypt/pinentry needs to be rebuilt with gtk or qt3 support."
	fi

	kde_pkg_setup
}

src_unpack() {
	kde_src_unpack
	sed -i -e "s:Hidden=true:Hidden=false:" ksim/ksim.desktop || die "sed failed"
}

src_compile() {
	local myconf="$(use_with snmp) $(use_with pbbuttonsd powerbook)
					--without-xmms"
	myconf="${myconf} $(use_with xscreensaver)"

	use crypt || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kgpg"

	kde_src_compile
}

src_install() {
	kde_src_install
	# see bug 144731
	rm "${D}${KDEDIR}/share/applications/kde/ksim.desktop"
}
