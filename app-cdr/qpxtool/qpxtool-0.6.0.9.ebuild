# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/qpxtool/qpxtool-0.6.0.9.ebuild,v 1.1 2007/03/19 05:44:44 vapier Exp $

inherit kde-functions qt3 multilib

DESCRIPTION="cd/dvd quality checker for a variety of drives"
HOMEPAGE="http://qpxtool.sourceforge.net/"
SRC_URI="mirror://sourceforge/qpxtool/${P}.tar.bz2
	mirror://gentoo/${P}-gentoo-buildsystem.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=x11-libs/qt-3*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "/^LIBDIR/s:/lib:/$(get_libdir):" Makefile
	# remove precompiled crap
	rm -f lib/lib/*
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README TODO
}
