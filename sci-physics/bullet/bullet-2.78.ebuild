# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/bullet/bullet-2.78.ebuild,v 1.2 2011/11/28 22:25:42 bicatali Exp $

EAPI=2

inherit eutils cmake-utils

DESCRIPTION="Continuous Collision Detection and Physics Library"
HOMEPAGE="http://www.bulletphysics.com/"
SRC_URI="http://bullet.googlecode.com/files/${P}-r2387.tgz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="doc double-precision examples extras"

RDEPEND="
	media-libs/freeglut
	virtual/opengl"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}"-soversion.patch
	)

src_configure() {
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_CPU_DEMOS=OFF
		-DBUILD_DEMOS=OFF
		-DUSE_GRAPHICAL_BENCHMARK=OFF
		-DINSTALL_LIBS=ON
		-DINSTALL_EXTRA_LIBS=ON
		$(cmake-utils_use_build extras EXTRAS)
		$(cmake-utils_use_use double-precision DOUBLE_PRECISION)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc README ChangeLog AUTHORS
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins *.pdf || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r Extras Demos || die
	fi
}
