# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbv/fbv-0.99.ebuild,v 1.9 2005/07/20 10:00:29 dragonheart Exp $

inherit toolchain-funcs

DESCRIPTION="simple program to view pictures on a linux framebuffer device"
HOMEPAGE="http://s-tech.elsat.net.pl/fbv/"
SRC_URI="http://s-tech.elsat.net.pl/fbv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc64"
IUSE="png gif jpeg"

DEPEND="gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )"

src_compile() {
	local myconf
	sed -e 's/-lungif/-lgif/g' -i Makefile -i configure
	use png || myconf="${myconf} --without-libpng"
	use gif || myconf="${myconf} --without-libungif"
	use jpeg || myconf="${myconf} --without-libjpeg"
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		${myconf} || die "econf failed"

	emake CC="$(tc-getCC) ${CFLAGS}" || die
}

src_install() {
	dobin fbv || die
	doman fbv.1
	dodoc ChangeLog README TODO VERSION
}
