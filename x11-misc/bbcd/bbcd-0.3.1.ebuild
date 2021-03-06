# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbcd/bbcd-0.3.1.ebuild,v 1.7 2005/08/06 16:47:54 swegener Exp $

DESCRIPTION="Basic CD Player for blackbox wm"
HOMEPAGE="http://tranber1.free.fr/bbcd.html"
SRC_URI="http://tranber1.free.fr/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/blackbox
		media-libs/libcdaudio"

src_install () {
	make \
		DESTDIR="${D}" \
		install || die
	rm -rf "${D}"/usr/doc
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
