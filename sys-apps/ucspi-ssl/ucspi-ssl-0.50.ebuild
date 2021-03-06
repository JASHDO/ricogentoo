# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-ssl/ucspi-ssl-0.50.ebuild,v 1.6 2008/01/25 22:57:30 bangert Exp $

inherit eutils

IUSE=""
DESCRIPTION="Command-line tools for building SSL client-server applications."
HOMEPAGE="http://www.superscript.com/ucspi-ssl/intro.html"
SRC_URI="http://www.superscript.com/ucspi-ssl/${P}.tar.gz"
DEPEND="virtual/libc
	>=dev-libs/openssl-0.9.6g
	sys-apps/ucspi-tcp"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-errno.patch

	echo "gcc ${CFLAGS} -DTLS -I." > conf-cc
	echo "/usr/" > conf-home
}

src_compile() {
	make || die
}

src_install() {
	for i in sslserver sslclient sslcat sslconnect https\@
	do
		dobin $i
	done
	dodoc CHANGES FILES README SYSDEPS TARGETS TODO UCSPI-SSL VERSION
}
