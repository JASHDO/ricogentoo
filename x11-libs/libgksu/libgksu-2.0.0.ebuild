# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libgksu/libgksu-2.0.0.ebuild,v 1.21 2007/05/27 04:03:12 kumba Exp $

inherit gnome2 eutils

MY_PN="${PN}2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A library for integration of su into applications"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="nls doc"

DEPEND="doc? ( >=dev-util/gtk-doc-1.2-r1 )
	nls? ( >=sys-devel/gettext-0.14.1 )
	>=x11-libs/gtk+-2.4
	>=gnome-base/gconf-2
	>=gnome-base/gnome-keyring-0.4.4
	>=gnome-base/libgtop-2
	>=gnome-base/libglade-2
	>=dev-util/pkgconfig-0.19
	x11-libs/startup-notification"
RDEPEND="${DEPEND}
	app-admin/sudo
	dev-util/intltool"

USEDESTDIR="1"
G2CONF="$(use_enable nls)"
DOCS="AUTHORS ChangeLog"

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}"/${P}-fbsd.patch
}
