# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/protux/protux-0.20.1.ebuild,v 1.10 2007/07/22 08:23:59 drac Exp $

inherit eutils kde-functions

DESCRIPTION="Professional Audio Tools for GNU/Linux"
HOMEPAGE="http://www.nongnu.org/protux"
SRC_URI="http://savannah.nongnu.org/download/protux/${P}.tar.gz"

IUSE="static"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"

DEPEND="x11-libs/libXt
	=x11-libs/qt-3*
	>=media-libs/libmustux-0.20.1"

set-qtdir 3

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-gentoo.patch
}

src_compile() {
	export QT_MOC=${QTDIR}/bin/moc
	econf $(use_enable static) || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed."
	dodoc AUTHORS ChangeLog README
}
