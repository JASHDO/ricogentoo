# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/formencode/formencode-0.7.1-r2.ebuild,v 1.1 2007/10/01 17:16:22 hawking Exp $

# TODO: Add pudge support via "doc" flag
#       currently broken with 0.6 and 0.7 releases

NEED_PYTHON=2.3

inherit distutils eutils

MY_PN="FormEncode"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="HTML form validation, generation, and conversion package"
HOMEPAGE="http://formencode.org"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-python/setuptools"

PYTHON_MODNAME=$MY_PN
S="${WORKDIR}/${MY_P}"

src_unpack() {
	distutils_src_unpack

	# fix domain verification. bug 194093
	epatch "${FILESDIR}/${P}-verify_domain.patch"
}

src_install() {
	distutils_src_install

	dodoc docs/*.txt

	insinto /usr/share/doc/${PF}
	doins -r examples
}
