# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/magicrescue/magicrescue-1.1.6.ebuild,v 1.3 2011/05/29 00:26:12 radhermit Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Find deleted files in block devices"
HOMEPAGE="http://www.itu.dk/people/jobr/magicrescue/"
SRC_URI="http://www.itu.dk/people/jobr/magicrescue/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	CC="$(tc-getCC)" ./configure --prefix=/usr || die "configure script failed"
	emake || die "emake failed"
}

src_install() {
	dodir /usr
	make PREFIX="${D}/usr" install || die "make install failed"
	mv "${D}/usr/man" "${D}/usr/share"
}
