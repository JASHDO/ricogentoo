# Copyright 2000-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/tinyscheme/tinyscheme-1.38.ebuild,v 1.1 2007/06/09 18:24:32 hkbst Exp $

MY_P=${PN}${PV}
DESCRIPTION="Lightweight scheme interpreter"
HOMEPAGE="http://tinyscheme.sourceforge.net"
SRC_URI="http://tinyscheme.sourceforge.net/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack "${A}"; cd ${S}
	sed 's/PLATFORM_FEATURES = -DUSE_STRLWR=0/#PLATFORM_FEATURES = -DUSE_STRLWR=0/' -i makefile
	sed 's/CC = gcc -fpic/CC = gcc -fpic ${CFLAGS}/' -i makefile
	sed 's/LDFLAGS/LOCAL_LDFLAGS/g' -i makefile
	sed 's/LOCAL_LDFLAGS = -shared/LOCAL_LDFLAGS = -shared ${LDFLAGS}/' -i makefile
	sed 's/DEBUG=-g -Wno-char-subscripts -O/DEBUG=/' -i makefile
}

src_install() {
	INIT_DIR=/usr/share/tinyscheme/
	newbin scheme tinyscheme
	dolib libtinyscheme.a libtinyscheme.so
	insinto ${INIT_DIR}
	doins init.scm
	dodir /etc/env.d/ && echo "TINYSCHEMEINIT=\"${INIT_DIR}\"" > ${D}/etc/env.d/50tinyscheme
}
