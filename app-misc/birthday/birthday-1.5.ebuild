# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/birthday/birthday-1.5.ebuild,v 1.15 2007/12/17 19:16:06 armin76 Exp $

inherit toolchain-funcs

DESCRIPTION="Displays a list of events happening in the near future"
HOMEPAGE="http://users.zetnet.co.uk/mortia/source/"
SRC_URI="http://users.zetnet.co.uk/mortia/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Don't strip, install in correct share dir and respect CFLAGS
	sed -i -e "s:install -s:install:g" -e "s:#SHARE:SHARE:g" -e "s:-O2:${CFLAGS}:g" \
		Makefile.in
}

src_compile() {
	emake CC=$(tc-getCC) birthday || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
