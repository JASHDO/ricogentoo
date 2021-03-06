# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libqxt/libqxt-0.4.ebuild,v 1.1 2009/01/05 03:09:41 yngwin Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="The Qt eXTension library provides cross-platform utility classes for the Qt toolkit"
HOMEPAGE="http://libqxt.org/"
SRC_URI="mirror://sourceforge/libqxt/${P}.tar.gz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="berkdb crypt debug doc sql web"

RDEPEND="|| ( ( x11-libs/qt-gui:4
		x11-libs/qt-script:4
		berkdb? ( x11-libs/qt-sql:4 )
		sql? ( x11-libs/qt-sql:4 ) )
	=x11-libs/qt-4.3*:4[png] )
	berkdb? ( sys-libs/db )
	crypt? ( >=dev-libs/openssl-0.9.8
		|| ( x11-libs/qt-core:4[ssl] =x11-libs/qt-4.3*:4[ssl] ) )
	web? ( >=dev-libs/fcgi-2.4 )"
DEPEND="${DEPEND}
	doc? ( app-doc/doxygen )"

src_configure() {
	local myconf
	myconf="-prefix /usr \
		-libdir /usr/$(get_libdir) \
		-docdir /usr/share/doc/${PF} \
		-qmake-bin /usr/bin/qmake \
		$(use debug && echo -debug) \
		$(use !berkdb && echo -no-db -nomake berkeley) \
		$(use !crypt && echo -nomake crypto -no-openssl) \
		$(use !sql && echo -nomake sql) \
		$(use !web && echo -nomake web)"

	./configure ${myconf} || die "configure failed"
}

src_compile() {
	# parallel compilation fails, bug #194730
	emake -j1 || die "make failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc {AUTHORS,README,LICENSE,cpl1.0.txt}

	if use doc; then
		doxygen Doqsyfile
		dohtml -r deploy/docs/*
	fi
}
