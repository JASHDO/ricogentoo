# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-1.0.2.ebuild,v 1.1 2009/08/27 01:07:33 robbat2 Exp $

EAPI="2"

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/libusb/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 -x86-fbsd"
IUSE="debug doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_configure() {
	econf \
		$(use_enable debug debug-log)
}

src_compile() {
	default

	if use doc ; then
		cd doc
		emake docs || die "making docs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS PORTING README THANKS TODO

	if use doc ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c

		dohtml doc/html/*
	fi
}
