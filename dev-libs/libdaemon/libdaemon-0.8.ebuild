# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdaemon/libdaemon-0.8.ebuild,v 1.8 2006/02/06 19:44:48 blubb Exp $

DESCRIPTION="Simple library for creating daemon processes in C"
HOMEPAGE="http://0pointer.de/lennart/projects/libdaemon/"
SRC_URI="http://0pointer.de/lennart/projects/libdaemon/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sh sparc x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"

src_compile() {
	econf --disable-lynx || die "econf failed"
	emake || die "emake failed"

	if use doc ; then
		einfo "Building documentation"
		make doxygen || die "make doxygen failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	if use doc; then
		ln -sf doc/reference/html reference
		dohtml -r doc/README.html reference
		doman doc/reference/man/man*/*
	fi

	dodoc README
	docinto examples ; dodoc examples/testd.c
}
