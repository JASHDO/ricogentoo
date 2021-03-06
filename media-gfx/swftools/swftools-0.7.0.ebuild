# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/swftools/swftools-0.7.0.ebuild,v 1.8 2007/04/30 22:48:48 genone Exp $

inherit eutils

DESCRIPTION="SWF Tools is a collection of SWF manipulation and generation utilities"
HOMEPAGE="http://www.swftools.org/"
SRC_URI="http://www.swftools.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-libs/t1lib-1.3.1
	media-libs/freetype
	media-libs/jpeg"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug 135393
	epatch "${FILESDIR}"/${PN}-0.7.0-gcc41.patch
}

src_install() {
	einstall || die "Install died."
	dodoc AUTHORS ChangeLog FAQ TODO
}

pkg_postinst() {
	elog
	elog "avifile and ungif are currently not supported."
	elog "Therefore, avi2swf and gif2swf were not installed."
	elog
}
