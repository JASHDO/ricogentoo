# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gnulib/gnulib-9999.ebuild,v 1.2 2007/10/28 21:03:33 vapier Exp $

EGIT_REPO_URI="git://git.savannah.gnu.org/gnulib.git"

inherit eutils git

DESCRIPTION="Gnulib is a library of common routines intended to be shared at the source level."
HOMEPAGE="http://www.gnu.org/software/gnulib"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${PN}

src_compile() {
	emake -C doc info html || die "emake failed"
}

src_install() {
	dodoc README COPYING ChangeLog
	dohtml doc/gnulib.html
	doinfo doc/gnulib.info

	insinto /usr/share/${PN}
	doins -r lib
	doins -r m4
	doins -r modules

	# remove CVS dirs
	#find "${D}" -name CVS -type d -print0 | xargs -0 rm -r

	# install the real script
	exeinto /usr/share/${PN}
	doexe gnulib-tool

	# create and install the wrapper
	dosym /usr/share/${PN}/gnulib-tool /usr/bin/gnulib-tool
}
