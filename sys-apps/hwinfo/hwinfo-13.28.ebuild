# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwinfo/hwinfo-13.28.ebuild,v 1.4 2008/07/16 12:59:19 nixnut Exp $

inherit eutils

DESCRIPTION="hwinfo is the hardware detection tool used in SuSE Linux."
HOMEPAGE="http://www.suse.com"
DEBIAN_PV="1"
DEBIAN_BASE_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/"
SRC_URI="${DEBIAN_BASE_URI}/${PN}_${PV}.orig.tar.gz
		 ${DEBIAN_BASE_URI}/${PN}_${PV}-${DEBIAN_PV}.diff.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RDEPEND=">=sys-fs/sysfsutils-2
		sys-apps/hal
		sys-apps/dbus"
# this package won't work on *BSD
DEPEND="${RDEPEND}
		>=sys-kernel/linux-headers-2.6.17"

src_unpack (){
	unpack ${PN}_${PV}.orig.tar.gz
	EPATCH_OPTS="-p1 -d ${S}" epatch "${DISTDIR}"/${PN}_${PV}-${DEBIAN_PV}.diff.gz
	rm "${S}"/debian/patches/series
	EPATCH_OPTS="-p0 -d ${S}" EPATCH_SUFFIX="" EPATCH_FORCE="yes" epatch "${S}"/debian/patches/
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-13.11-makefile-fixes.patch
	#sed -i -e "s,^LIBS[ \t]*= -lhd,LIBS = -lhd -lsysfs," ${S}/Makefile
	#sed -i -e "s,^LIBDIR[ \t]*= /usr/lib$,LIBDIR = /usr/$(get_libdir)," ${S}/Makefile
	echo 'libs: $(LIBHD) $(LIBHD_SO)' >>${S}/Makefile
}

src_compile(){
	# build is NOT parallel safe
	emake -j1 EXTRA_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	[[ "$(get_libdir)" != "lib" ]] && mv "${D}"/usr/lib "${D}/usr/$(get_libdir)"
	dodoc VERSION README
	doman doc/hwinfo.8
}
