# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/eigen/eigen-2.0.16.ebuild,v 1.8 2012/10/17 14:16:25 jer Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="C++ template library for linear algebra: vectors, matrices, and related algorithms"
HOMEPAGE="http://eigen.tuxfamily.org/"
SRC_URI="https://bitbucket.org/eigen/eigen/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
SLOT="2"
IUSE="debug doc examples"

COMMON_DEPEND="
	examples? (
		x11-libs/qt-gui:4
		x11-libs/qt-opengl:4
	)"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )"
RDEPEND="${COMMON_DEPEND}
	!dev-cpp/eigen:0"

MAKEOPTS+=" -j1"

src_unpack() {
	unpack ${A}
	mv ${PN}* ${P} || die
}

src_configure() {
	# benchmarks (BTL) brings up damn load of external deps including fortran
	# compiler
	# library hangs up complete compilation proccess, test later
	mycmakeargs=(
		-DEIGEN_BUILD_LIB=OFF
		-DEIGEN_BUILD_BTL=OFF
		-DEIGEN_BUILD_PKGCONFIG=ON
		$(cmake-utils_use examples EIGEN_BUILD_DEMOS)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use doc; then
		cd "${CMAKE_BUILD_DIR}"
		emake doc
	fi
}

src_install() {
	cmake-utils_src_install
	if use doc; then
		cd "${CMAKE_BUILD_DIR}"/doc
		dohtml -r html/*
	fi
	if use examples; then
		cd "${CMAKE_BUILD_DIR}"/demos
		dobin mandelbrot/mandelbrot opengl/quaternion_demo
	fi
}

src_test() {
	mycmakeargs=(
		-DEIGEN_BUILD_TESTS=ON
		-DEIGEN_TEST_NO_FORTRAN=ON
	)
	cmake-utils_src_configure
	cmake-utils_src_compile
	cmake-utils_src_test
}
