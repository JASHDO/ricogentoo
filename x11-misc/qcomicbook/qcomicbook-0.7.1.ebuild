# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qcomicbook/qcomicbook-0.7.1.ebuild,v 1.1 2010/11/27 09:45:55 xarthisius Exp $

EAPI=2
CMAKE_IN_SOURCE_BUILD=1
inherit cmake-utils flag-o-matic

DESCRIPTION="A viewer for comic book archives containing jpeg/png images."
HOMEPAGE="http://qcomicbook.linux-projects.net/"
SRC_URI="http://${PN}.linux-projects.net/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

src_configure() {
	use !debug && append-cppflags -DQT_NO_DEBUG_OUTPUT
	cmake-utils_src_configure
}

pkg_postinst() {
	elog "For using QComicBook with compressed archives you may want to install:"
	elog "    app-arch/p7zip"
	elog "    app-arch/unace"
	elog "    app-arch/unrar or app-arch/rar"
	elog "    app-arch/unzip"
}
