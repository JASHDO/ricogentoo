# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/axel/axel-1.0b.ebuild,v 1.7 2008/02/03 16:13:18 grobian Exp $

DESCRIPTION="light Unix download accelerator"
HOMEPAGE="http://wilmer.gaast.net/main.php/axel.html"
SRC_URI="http://wilmer.gaast.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc x86"
IUSE="debug"

DEPEND="virtual/libc"

src_compile() {
	local myconf

	use debug && myconf="--debug=1"
	econf \
		--strip=0 \
		--etcdir=/etc \
		${myconf} \
		|| die
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc API CHANGES CREDITS README axelrc.example
}
