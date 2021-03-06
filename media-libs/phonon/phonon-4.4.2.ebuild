# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/phonon/phonon-4.4.2.ebuild,v 1.5 2012/09/11 10:33:18 johu Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="KDE multimedia API"
HOMEPAGE="http://phonon.kde.org"
SRC_URI="mirror://kde/stable/phonon/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE="alsa aqua debug +gstreamer pulseaudio"

RDEPEND="
	!!x11-libs/qt-phonon:4
	>=x11-libs/qt-test-4.6.0:4[aqua=]
	>=x11-libs/qt-dbus-4.6.0:4[aqua=]
	>=x11-libs/qt-gui-4.6.0:4[aqua=]
	>=x11-libs/qt-opengl-4.6.0:4[aqua=]
	gstreamer? (
		media-libs/gstreamer:0.10
		media-plugins/gst-plugins-meta:0.10[alsa?]
	)
	pulseaudio? (
		dev-libs/glib:2
		>=media-sound/pulseaudio-0.9.21[glib]
	)
"
DEPEND="${RDEPEND}
	!!x11-libs/qt-phonon:4
	>=dev-util/automoc-0.9.87
"

S=${WORKDIR}/${P/.0}

pkg_setup() {
	if use !gstreamer && use !aqua; then
		die "you must at least select one backend for phonon"
	fi
}

src_prepare() {
	# Fix the qt7 backend for MacOS 10.6.
	[[ ${CHOST} == *-darwin10 ]] && epatch "${FILESDIR}"/${PN}-4.4-qt7.patch

	# On MacOS we additionally want the gstreamer plugin.
	if use aqua && use gstreamer; then
		sed -e "/add_subdirectory(qt7)/a add_subdirectory(gstreamer)" \
			-i CMakeLists.txt \
			|| die "failed to enable GStreamer backend"
	fi

	base_src_prepare
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with alsa)
		$(cmake-utils_use_build aqua PHONON_QT7)
		$(cmake-utils_use_with gstreamer GStreamer)
		$(cmake-utils_use_with gstreamer GStreamerPlugins)
		$(cmake-utils_use_with pulseaudio PulseAudio)
		$(cmake-utils_use_with pulseaudio GLib2)
		-DWITH_Xine=OFF
		-DWITH_XCB=OFF
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use aqua; then
		local MY_PV=4.4.0

		install_name_tool \
			-id "${EPREFIX}/usr/lib/libphonon.${MY_PV::1}.dylib" \
			"${ED}/usr/lib/libphonon.${MY_PV}.dylib" \
			|| die "failed to fix libphonon.${MY_PV}.dylib"

		install_name_tool \
			-id "${EPREFIX}/usr/lib/libphononexperimental.${MY_PV::1}.dylib" \
			-change "libphonon.${MY_PV::1}.dylib" \
				"${EPREFIX}/usr/lib/libphononexperimental.${MY_PV::1}.dylib" \
			"${ED}/usr/lib/libphononexperimental.${MY_PV}.dylib" \
			|| die "failed to fix libphononexperimental.${MY_PV}.dylib"

		# fake the framework for the qt-apps depending on qt-frameworks (qt-webkit)
		dodir /usr/lib/qt4/phonon.framework/Versions/${MY_PV::1}
		dosym ${MY_PV::1} /usr/lib/qt4/phonon.framework/Versions/Current \
			|| die "failed to create symlink"
		dosym ../../../../libphonon.${MY_PV::1}.dylib /usr/lib/qt4/phonon.framework/Versions/${MY_PV::1}/phonon \
			|| die "failed to create symlink"
		dosym Versions/${MY_PV::1}/phonon /usr/lib/qt4/phonon.framework/phonon \
			|| die "failed to create symlink"
	fi
}
