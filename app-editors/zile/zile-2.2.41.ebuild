# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/zile/zile-2.2.41.ebuild,v 1.7 2007/10/10 07:17:42 ulm Exp $

DESCRIPTION="Zile is a small Emacs clone"
HOMEPAGE="http://zile.sourceforge.net/"
SRC_URI="mirror://sourceforge/zile/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses
	>=sys-apps/texinfo-4.3"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README THANKS || die "dodoc failed"
}
