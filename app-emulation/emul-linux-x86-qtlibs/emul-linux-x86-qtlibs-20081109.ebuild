# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-20081109.ebuild,v 1.1 2008/11/10 03:30:26 kingtaco Exp $

inherit eutils emul-linux-x86

LICENSE="|| ( QPL-1.0 GPL-2 ) GPL-2 LGPL-2"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND=">=app-emulation/emul-linux-x86-baselibs-20081109
		>=app-emulation/emul-linux-x86-soundlibs-20081109
		>=app-emulation/emul-linux-x86-xlibs-20081109"

pkg_setup() {
	if ! built_with_use app-emulation/emul-linux-x86-soundlibs arts; then
		eerror
		eerror "\t ${PN} requires arts support in app-emulation/emul-linux-x86-soundlibs."
		eerror "\t Please compile app-emulation/emul-linux-x86-soundlibs with USE=arts "
		eerror "\t enabled and then re-merge this package."
		eerror
		die "app-emulation/emul-linux-x86-soundlibs must have arts useflag turned on"
	fi
}

src_unpack() {
	emul-linux-x86_src_unpack
	NEEDED="(libDCOP.so|libkdecore.so|libkdefx.so|libqt-mt.so|libqt.so|libqui.so|libqt-mt.so.3)"
	find "${S}" -name '*.so*' | egrep -v "${NEEDED}" | xargs rm -f
}
