# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/insight/insight-6.5.ebuild,v 1.9 2007/07/22 07:24:10 graaff Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="A graphical interface to the GNU debugger"
HOMEPAGE="http://sourceware.org/insight/"
LICENSE="GPL-2 LGPL-2"
RDEPEND="sys-libs/ncurses
	x11-libs/libX11"
DEPEND="x11-libs/libXt
	x11-libs/libX11
	nls? ( sys-devel/gettext )
	sys-libs/ncurses"

SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
SRC_URI="ftp://sources.redhat.com/pub/${PN}/releases/${P}.tar.bz2"

INSIGHTDIR="/opt/insight"

src_unpack() {
	unpack ${A}
	cd ${S}
#	sed -i -e "s/relid'/relid/" {tcl,tk}/unix/configure
}

src_compile() {
	local myconf
	myconf="$(use_enable nls)"

	strip-linguas -i bfd/po opcodes/po

	./configure --prefix="${INSIGHTDIR}" \
		--mandir="${D}${INSIGHTDIR}/share/man"	\
		--infodir="${D}${INSIGHTDIR}/share/info"	\
		${myconf} || die
	emake || die
}

src_install () {
	make \
		prefix="${D}${INSIGHTDIR}" \
		mandir="${D}${INSIGHTDIR}/share/man" \
		infodir="${D}${INSIGHTDIR}/share/info" \
		install || die
	doenvd "${FILESDIR}/99insight"
}
