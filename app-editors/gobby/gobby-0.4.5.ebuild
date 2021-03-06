# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gobby/gobby-0.4.5.ebuild,v 1.7 2008/07/27 13:26:50 loki_val Exp $

EAPI=1

inherit base eutils

DESCRIPTION="GTK-based collaborative editor"
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="avahi gnome"

RDEPEND=">=dev-cpp/glibmm-2.6
	>=dev-cpp/gtkmm-2.6
	>=dev-libs/libsigc++-2.0
	>=net-libs/obby-0.4.4
	>=dev-cpp/libxmlpp-2.6
	x11-libs/gtksourceview:1.0
	gnome? ( gnome-base/gnome-vfs )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# There's only one test and it needs X
RESTRICT="test"

PATCHES=( "${FILESDIR}/${PN}-0.4.5-gcc43.patch" )

pkg_setup() {
	if use avahi && ! built_with_use net-libs/obby avahi ; then
		eerror "Please reinstall net-libs/obby with the avahi USE-flag enabled"
		eerror "for zeroconf/DNS-SD support or disable it for this package."
		die "Missing 'avahi' USE-flag for net-libs/obby"
	fi
}

src_compile() {
	econf \
		$(use_with gnome) \
		 || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	domenu contrib/gobby.desktop
}
