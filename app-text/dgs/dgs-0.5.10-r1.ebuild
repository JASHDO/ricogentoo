# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dgs/dgs-0.5.10-r1.ebuild,v 1.38 2008/03/18 13:24:47 flameeyes Exp $

WANT_AUTOCONF="2.1"
WANT_AUTOMAKE="latest"

inherit eutils autotools

DESCRIPTION="A Ghostscript based Display Postscript (DPS) server"
HOMEPAGE="http://www.gyve.org/dgs/"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/old/dgs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 hppa mips ppc64 ia64"
IUSE="tcpd"
RDEPEND="=dev-libs/glib-1.2*
	!<x11-base/xorg-x11-7"
DEPEND="${RDEPEND}
	sys-apps/texinfo
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gs-time_.h-gentoo.diff
	epatch ${FILESDIR}/${P}-tcpd-gentoo.diff
	epatch ${FILESDIR}/${P}-gcc-3.4.diff
	epatch ${FILESDIR}/${PV}-workaround-include-in-comments.patch

	eautoconf
}

src_compile() {
	econf --with-x $(use_enable tcpd) || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	rm -rf ${D}/usr/share/man/manm
	newman ${S}/DPS/demos/xepsf/xepsf.man xepsf.1
	newman ${S}/DPS/demos/dpsexec/dpsexec.man dpsexec.1
	newman ${S}/DPS/clients/makepsres/makepsres.man makepsres.1

	dodoc ANNOUNCE ChangeLog FAQ NEWS NOTES README STATUS TODO Version
}
