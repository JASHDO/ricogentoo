# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/beagle/beagle-3.0.1.ebuild,v 1.3 2008/05/17 10:09:03 bicatali Exp $

IUSE="doc"

DESCRIPTION="Open BEAGLE, a versatile EC/GA/GP framework"
SRC_URI="mirror://sourceforge/beagle/${P}.tar.gz"
HOMEPAGE="http://www.gel.ulaval.ca/~beagle/index.html"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

RDEPEND="sys-libs/zlib
	!app-misc/beagle"

DEPEND="${DEPEND}
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s:@LIBS@:@LIBS@ -lpthread:" \
		-i PACC/Threading/Makefile.in || \
		die "Failed to fix threading libs makefile."
}

src_compile() {
	econf --enable-optimization || die "Configure failed."
	emake || die "Make failed."

	if use doc; then
		make doc || die "Failed to generate docs."
	fi
}

src_install () {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO

	if use doc; then
		cp -pPR examples "${D}"/usr/share/doc/${PF} || \
			die "Failed to install examples."
		dohtml -r refman/* || die "Failed to install manual."
	fi
}
