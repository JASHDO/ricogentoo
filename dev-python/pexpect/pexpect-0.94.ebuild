# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pexpect/pexpect-0.94.ebuild,v 1.13 2005/01/09 06:19:23 cryos Exp $

IUSE=""

DESCRIPTION="Pexpect is a pure Python module for spawning child applications; controlling them; and responding to expected patterns in their output"
HOMEPAGE="http://pexpect.sourceforge.net/"
SRC_URI="mirror://sourceforge/pexpect/pexpect-0.94.tgz"
LICENSE="PYTHON"
SLOT="0"
KEYWORDS="x86 ppc ~alpha sparc"
DEPEND="dev-lang/python"

src_compile() {
	python -c 'import compileall; compileall.compile_dir(".",force=1)'
}

src_install () {
	local pv=`python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:'`
	insinto "/usr/lib/python${pv}/site-packages"

	doins pexpect.py*
	dodoc README.txt
}
