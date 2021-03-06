# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/sptk/sptk-3.0.6.ebuild,v 1.2 2006/01/14 12:38:43 nelchael Exp $

inherit autotools

IUSE="fltk odbc doc"

DESCRIPTION="C++ user interface toolkit for X with database and Excel support"
SRC_URI="http://sptk.tts-sf.com/sptk-${PV}.tbz2"
HOMEPAGE="http://sptk.tts-sf.com"

SLOT="3"
LICENSE="|| ( FLTK GPL-2 )"
KEYWORDS="~amd64 ~mips ~ppc ~sparc x86"

DEPEND="fltk? ( x11-libs/fltk )
	odbc? ( >=dev-db/unixODBC-2.2.6 )
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	# This fixes double ./configure run
	eautoreconf
}

src_compile() {

	local myconf
	myconf="--enable-shared"

	use odbc || myconf="${myconf} --disable-odbc" #default enabled
	use fltk || myconf="${myconf} --disable-fltk"

	econf \
		--prefix=/usr \
		${myconf} || die "Configuration Failed"

	emake || die "Parallel Make Failed"

	if use doc; then
		cd "${S}"
		einfo "Fixing sptk3.doxygen"
		sed -i -e 's,/cvs/sptk3/,,g' sptk3.doxygen
		einfo "Building docs"
		doxygen sptk3.doxygen
	fi

}

src_install () {

	make DESTDIR=${D} install || die "Installation failed"

	dodoc README AUTHORS

	dodir /usr/share/doc/${PF}
	cp -r ${S}/docs/* ${D}/usr/share/doc/${PF}
	if use doc; then
		rm -fr ${D}/usr/share/doc/${PF}/latex
		cp -r ${S}/pictures ${D}/usr/share/doc/${PF}
	fi

}
