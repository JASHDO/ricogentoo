# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detox/detox-1.1.0.ebuild,v 1.3 2007/07/12 03:35:11 mr_bones_ Exp $

inherit eutils

DESCRIPTION="detox safely removes spaces and strange characters from filenames"
HOMEPAGE="http://detox.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips ~hppa"
IUSE=""

DEPEND="dev-libs/popt
	sys-devel/flex
	sys-devel/bison"

RDEPEND="dev-libs/popt"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-destdir.patch
	epatch ${FILESDIR}/${P}-parallel_build.patch
}

src_compile() {
	econf --with-popt || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README CHANGES
}
