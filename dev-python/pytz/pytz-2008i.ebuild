# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytz/pytz-2008i.ebuild,v 1.1 2009/01/14 16:54:04 bicatali Exp $

NEED_PYTHON=2.3
EAPI=2
inherit eutils distutils

DESCRIPTION="World Timezone Definitions for Python"
HOMEPAGE="http://pytz.sourceforge.net/"
SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-libs/timezone-data-${PV}"

DOCS="CHANGES.txt"

src_prepare() {
	# use timezone-data zoneinfo
	epatch "${FILESDIR}"/${P}-zoneinfo.patch
}

src_test() {
	PYTHONPATH=. "${python}" pytz/tests/test_tzinfo.py || die "test failed"
}

src_install() {
	distutils_src_install
	rm -rf "${D}"/usr/lib*/python*/site-packages/pytz/zoneinfo
}
