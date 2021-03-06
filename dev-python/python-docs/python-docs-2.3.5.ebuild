# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-docs/python-docs-2.3.5.ebuild,v 1.12 2007/05/07 12:46:26 kloeri Exp $

DESCRIPTION="HTML documentation for Python"
HOMEPAGE="http://www.python.org/doc/2.3/"
SRC_URI="http://www.python.org/ftp/python/doc/${PV}/html-${PV}.tar.bz2"

LICENSE="PSF-2.2"
SLOT="2.3"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_install() {
	docinto html
	cp -R ${S}/Python-Docs-${PV}/* ${D}/usr/share/doc/${PF}/html
}

pkg_preinst() {
	dodir /etc/env.d
	echo "PYTHONDOCS=/usr/share/doc/${PF}/html/lib" > ${D}/etc/env.d/50python-docs
}
