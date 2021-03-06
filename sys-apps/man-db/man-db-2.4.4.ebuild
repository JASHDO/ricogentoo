# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man-db/man-db-2.4.4.ebuild,v 1.1 2007/04/13 10:19:41 vapier Exp $

inherit eutils

DESCRIPTION="a man replacement that utilizes berkdb instead of flat files"
HOMEPAGE="http://www.nongnu.org/man-db/"
SRC_URI="http://download.savannah.nongnu.org/releases/man-db/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )
	sys-libs/db"
RDEPEND="sys-libs/db
	!sys-apps/man"
PROVIDE="virtual/man"

pkg_setup() {
	enewgroup man 15
	enewuser man 13 -1 /usr/share/man man
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-sections.patch
}

src_compile() {
	econf $(use_enable nls) || die
	emake -j1 || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README docs/{ChangeLog,NEWS,ToDo}
}
