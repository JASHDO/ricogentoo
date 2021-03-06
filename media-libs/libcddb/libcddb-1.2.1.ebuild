# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcddb/libcddb-1.2.1.ebuild,v 1.14 2007/03/09 02:51:10 beandog Exp $

inherit libtool

DESCRIPTION="A library for accessing a CDDB server"
HOMEPAGE="http://libcddb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="test"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	elibtoolize
}

src_compile() {
	econf --without-cdio || die
	emake || die

	# Create API docs if needed and possible
	if use doc; then
		cd doc
		doxygen doxygen.conf || die
	fi
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	# Create API docs if needed and possible
	use doc && dohtml doc/html/*
}
