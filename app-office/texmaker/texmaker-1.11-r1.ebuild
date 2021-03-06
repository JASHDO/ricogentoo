# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmaker/texmaker-1.11-r1.ebuild,v 1.10 2007/07/22 10:07:43 calchan Exp $

inherit kde-functions eutils

DESCRIPTION="a nice LaTeX-IDE"

HOMEPAGE="http://www.xm1math.net/texmaker/"
SRC_URI="http://www.xm1math.net/texmaker/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64 ppc sparc x86"

IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/libXext"

RDEPEND="${DEPEND}
	virtual/tetex
	app-text/psutils
	virtual/ghostscript
	media-libs/netpbm"

need-qt 3.2

src_compile() {
	einfo "using QTDIR: '$QTDIR'."

	# from BUILD.sh:
	PATH=${QTDIR}/bin:${PATH}
	LD_LIBRARY_PATH=${QTDIR}/lib:${LD_LIBRARY_PATH}
	DYLD_LIBRARY_PATH=${QTDIR}/lib:${DYLD_LIBRARY_PATH}
	export QTDIR PATH LD_LIBRARY_PATH DYLD_LIBRARY_PATH

	${QTDIR}/bin/qmake -unix texmaker.pro || die "qmake failed"

	emake || die "emake failed"
}

src_install() {
	dobin texmaker || die "doexe failed"

	insinto /usr/share/pixmaps/texmaker
	doins utilities/texmaker*.png || die "doins failed."

	dodoc utilities/{AUTHORS,COPYING} || die "dodoc failed"

	dohtml utilities/*.{html,gif,css,txt} utilities/doc*.png || die "dohtml failed"

	dosym /usr/share/doc/${PF}/html /usr/share/${PN} || die "dosym failed"

	make_desktop_entry texmaker Texmaker "/usr/share/pixmaps/texmaker/texmaker48x48.png" Office
}

pkg_postinst() {
	elog "A user manual with many screenshots is available at:"
	elog "/usr/share/doc/${PF}/html/usermanual.html"
}
