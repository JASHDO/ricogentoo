# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/fsh/fsh-1.2-r1.ebuild,v 1.5 2005/06/09 16:22:50 pythonhead Exp $

inherit eutils

DESCRIPTION="System to allow fast-reuse of a ssh secure tunnel to avoid connection lag"
HOMEPAGE="http://www.lysator.liu.se/fsh/"
SRC_URI="http://www.lysator.liu.se/fsh/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="net-misc/openssh
	<dev-lang/python-2.4"

src_unpack() {
	unpack ${A}

	# Fix scp invocation parsing when user@host is used
	epatch ${FILESDIR}/${P}-fcpwrap.patch
}

src_compile() {
	./configure --prefix=/usr --infodir=/usr/share/info
	make || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README* THANKS TODO
}
