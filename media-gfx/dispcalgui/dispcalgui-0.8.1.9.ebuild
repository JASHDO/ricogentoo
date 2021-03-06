# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/dispcalgui/dispcalgui-0.8.1.9.ebuild,v 1.1 2011/12/30 09:16:57 hwoarang Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils fdo-mime

MY_PN="dispcalGUI"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Display Calibration and Characterization powered by Argyll CMS"
HOMEPAGE="http://dispcalgui.hoech.net/"
SRC_URI="http://dispcalgui.hoech.net/download.php?version=${PV}&suffix=.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-gfx/argyllcms-1.1.0
	>=dev-python/wxpython-2.8.10.1
	>=x11-libs/libX11-1.3.3
	>=x11-apps/xrandr-1.3.2
	>=x11-libs/libXxf86vm-1.1.0
	>=x11-proto/xineramaproto-1.2
	>=x11-libs/libXinerama-1.1"
RDEPEND="${DEPEND}
	>=dev-python/numpy-1.2.1"

# Just in case someone renames the ebuild
S=${WORKDIR}/${MY_P}

DOCS=(
	README.html
)

src_prepare() {
#	Prohibit setup from running xdg-* programs, resulting to sandbox violation
	cd "${S}/dispcalGUI" || die "Cannot cd to source directory."
	sed -e 's/if which(\"xdg-icon-resource\"):/if which(\"xdg-icon-resource-non-existant\"):/' \
	-e 's/if which(\"xdg-desktop-menu\"):/if which(\"xdg-desktop-menu-non-existant\"):/' \
	-i postinstall.py || die "sed'ing out the xdg-* setup functions failed"

	distutils_src_prepare
}

pkg_postinst() {
#	Run xdg-* programs the Gentoo way since we removed this functionality from the original package
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	distutils_pkg_postinst
}

pkg_postrm() {
#	Run xdg-* programs the Gentoo way since we removed this functionality from the original package
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	distutils_pkg_postrm
}
