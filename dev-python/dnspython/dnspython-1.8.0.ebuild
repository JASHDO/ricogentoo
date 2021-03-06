# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dnspython/dnspython-1.8.0.ebuild,v 1.8 2010/08/16 16:50:27 grobian Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="DNS toolkit for Python"
HOMEPAGE="http://www.dnspython.org/ http://pypi.python.org/pypi/dnspython"
SRC_URI="http://www.dnspython.org/kits/${PV}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="examples"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="dns"
DOCS="TODO"

src_test() {
	cd tests
	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib:${PYTHONPATH}" emake
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "Documentation is sparse at the moment. Use pydoc,"
	elog "or read the HTML documentation at the dnspython's home page."
}
