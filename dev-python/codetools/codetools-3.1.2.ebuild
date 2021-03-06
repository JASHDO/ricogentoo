# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/codetools/codetools-3.1.2.ebuild,v 1.1 2010/10/18 13:08:58 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="CodeTools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite code analysis and execution tools"
HOMEPAGE="http://code.enthought.com/projects/code_tools.php http://pypi.python.org/pypi/CodeTools"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="doc examples test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-python/numpy
	>=dev-python/traits-3.5.0"
DEPEND="dev-python/setuptools
	doc? ( dev-python/setupdocs )
	test? ( dev-python/nose )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	distutils_src_prepare

	sed -i \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		setup.py || die "sed setup.py failed"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		"$(PYTHON -f)" setup.py build_docs --formats=html,pdf || die "Generation of documentation failed"
	fi
}

src_install() {
	find "${S}" -name "*LICENSE.txt" -delete
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r build/docs/html || die
		doins build/docs/latex/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
