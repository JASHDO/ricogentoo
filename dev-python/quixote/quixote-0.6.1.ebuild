# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/quixote/quixote-0.6.1.ebuild,v 1.8 2008/02/23 23:04:32 hollow Exp $

inherit distutils

MY_P=${P/q/Q}

DESCRIPTION="Python HTML templating framework for developing web applications."
HOMEPAGE="http://quixote.ca"
SRC_URI="http://www.mems-exchange.org/software/files/${PN}/${MY_P}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2"

S="${WORKDIR}"/${MY_P}

src_install() {
	DOCS="ACKS CHANGES"
	distutils_src_install
	dodoc doc/*.txt
	dohtml doc/*.html
	dodir /usr/share/${PN}/demo
	insinto /usr/share/${PN}/demo
	doins demo/*
}
