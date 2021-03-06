# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/adns-python/adns-python-1.1.1.ebuild,v 1.1 2006/12/29 23:18:50 dev-zero Exp $

inherit distutils eutils

DESCRIPTION="Python bindings for ADNS"
HOMEPAGE="http://dustman.net/andy/python/adns-python"
SRC_URI="http://dustman.net/andy/python/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=net-libs/adns-1.3"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-adns-1.3.patch"
}
