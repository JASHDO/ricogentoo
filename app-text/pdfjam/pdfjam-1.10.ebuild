# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdfjam/pdfjam-1.10.ebuild,v 1.7 2005/04/24 11:41:43 hansmi Exp $

DESCRIPTION="pdfnup, pdfjoin and pdf90"
HOMEPAGE="http://www.warwick.ac.uk/go/pdfjam"
SRC_URI="http://www2.warwick.ac.uk/fac/sci/statistics/staff/academic/firth/software/pdfjam/pdfjam_${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""
S=${WORKDIR}/${PN}

DEPEND="virtual/tetex"

src_compile() {
	for i in pdf90 pdfjoin pdfnup; do
		cp scripts/$i scripts/$i.orig
		sed -e 's,^pdflatex="/usr/local/bin/pdflatex",pdflatex="/usr/bin/pdflatex",' scripts/$i.orig >scripts/$i
	done
}

src_install() {
	dobin scripts/pdf90 scripts/pdfjoin scripts/pdfnup || die
	dodoc PDFjam-README.html || die
}
