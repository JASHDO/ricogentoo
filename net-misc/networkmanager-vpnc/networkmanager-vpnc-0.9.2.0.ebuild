# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-vpnc/networkmanager-vpnc-0.9.2.0.ebuild,v 1.2 2011/11/28 20:11:40 pacho Exp $

EAPI="4"
GNOME_ORG_MODULE="NetworkManager-${PN##*-}"

inherit gnome.org

DESCRIPTION="NetworkManager VPNC plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome test"

RDEPEND="
	>=net-misc/networkmanager-${PV}
	>=dev-libs/dbus-glib-0.74
	>=net-misc/vpnc-0.5
	gnome? (
		>=x11-libs/gtk+-2.91.4:3
		gnome-base/gnome-keyring
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

src_prepare() {
	# Test will fail if the machine doesn't have a particular locale installed
	sed '/test_non_utf8_import (plugin/ d' \
		-i properties/tests/test-import-export.c || die "sed failed"

	# Drop DEPRECATED flags, bug #384987
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		auth-dialog/Makefile.am auth-dialog/Makefile.in \
		properties/Makefile.am properties/Makefile.in \
		src/Makefile.am src/Makefile.in || die
}

src_configure() {
	ECONF="--disable-more-warnings
		--disable-static
		--with-dist-version=Gentoo
		--with-gtkver=3
		$(use_with gnome)
		$(use_with test tests)"

	econf ${ECONF}
}

src_install() {
	default
	# Remove useless .la files
	find "${D}" -name '*.la' -exec rm -f {} +
}
