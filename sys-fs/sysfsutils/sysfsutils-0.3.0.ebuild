# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sysfsutils/sysfsutils-0.3.0.ebuild,v 1.6 2005/03/03 16:52:31 corsair Exp $

inherit libtool

DESCRIPTION="System Utilities Based on Sysfs"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"
SRC_URI="mirror://sourceforge/linux-diag/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	elibtoolize
	econf || die "./configure failed"

	# Make sure we do not link with external libsysfs ..
	sed -i '/^LIBS/ s/-lsysfs//' cmd/Makefile

	emake || die
}

src_install() {
	einstall includedir=${D}/usr/include/sysfs || die

	# We do not distribute this
	rm -f ${D}/usr/bin/dlist_test

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	# FIXME: cmd/GPL and lib/LGPL do not exist - should we
	#        then rather add them manually ?
	dodoc cmd/GPL lib/LGPL docs/libsysfs.txt
}
