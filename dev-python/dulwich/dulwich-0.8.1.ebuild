# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dulwich/dulwich-0.8.1.ebuild,v 1.8 2012/09/30 18:18:33 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Dulwich is a pure-Python implementation of the Git file formats and protocols."
HOMEPAGE="http://samba.org/~jelmer/dulwich/ http://pypi.python.org/pypi/dulwich"
SRC_URI="http://samba.org/~jelmer/dulwich/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="dev-python/setuptools
	test? ( || ( dev-lang/python:2.7 dev-python/unittest2 ) )"
RDEPEND=""

src_prepare() {
	distutils_src_prepare
	sed -e "s/test_fetch_from_dulwich(/_&/" -i dulwich/tests/compat/server_utils.py
}

distutils_src_test_pre_hook() {
	local module
	for module in _diff_tree _objects _pack; do
		ln -fs "../$(ls -d build-${PYTHON_ABI}/lib.*)/dulwich/${module}.so" "dulwich/${module}.so" || die "Symlinking dulwich/${module}.so failed with $(python_get_implementation_and_version)"
	done
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/dulwich/tests"
	}
	python_execute_function -q delete_tests
}
