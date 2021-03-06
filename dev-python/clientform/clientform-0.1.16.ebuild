# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/clientform/clientform-0.1.16.ebuild,v 1.5 2005/02/01 06:11:13 pythonhead Exp $

inherit distutils

MY_P="ClientForm-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Parse, fill out, and return HTML forms on the client side"
HOMEPAGE="http://wwwsearch.sourceforge.net/ClientForm/"
SRC_URI=http://wwwsearch.sourceforge.net/ClientForm/src/${MY_P}.tar.gz
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DOCS="COPYING README.txt PKG-INFO MANIFEST.in ChangeLog"

src_install() {
	distutils_src_install
	dohtml README.html
}
