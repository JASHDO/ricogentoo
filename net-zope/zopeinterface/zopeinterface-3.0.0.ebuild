# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zopeinterface/zopeinterface-3.0.0.ebuild,v 1.4 2006/01/27 02:52:36 vapier Exp $

inherit distutils

MY_PN="ZopeInterface"
DESCRIPTION="Standalone Zope interface library"
HOMEPAGE="http://zope.org/Products/ZopeInterface"
SRC_URI="http://www.zope.org/Products/${MY_PN}/${PV}/${MY_PN}-${PV}.tgz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND="=dev-lang/python-2.3*"

S=${WORKDIR}/${MY_PN}-${PV}

src_install() {
	distutils_src_install

	if use doc ; then
		cp -a $MY_PN ${D}/usr/share/doc/${PF}/
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
}
