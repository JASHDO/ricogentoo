# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnotime/gnotime-2.2.2.ebuild,v 1.5 2007/10/04 19:53:32 eva Exp $

inherit gnome2 eutils

DESCRIPTION="A utility for tracking the amount of time spent on activities, and calculating data, such as pay rates, from those times"
HOMEPAGE="http://gttr.sourceforge.net/"
SRC_URI="mirror://sourceforge/gttr/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnome-2.0
	>=gnome-base/libgnomeui-2.0.3
	>=gnome-base/gnome-vfs-2
	>=dev-libs/glib-2
	>=gnome-base/libglade-2.0
	=gnome-extra/gtkhtml-3.2*
	>=gnome-base/gconf-2.0
	x11-libs/pango
	dev-libs/libxml2
	dev-scheme/guile
	dev-libs/popt"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	=app-text/docbook-xml-dtd-4.2*
	>=app-text/scrollkeeper-0.3.11"

DOCS="AUTHORS ChangeLog NEWS README TODO"

G2CONF="${G2CONF} --disable-schemas-install --without-system-qof"

# Fix for bug #109047, don't parallel build with libqofsql
MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	if has_version ">=dev-scheme/guile-1.8" && ! built_with_use dev-scheme/guile deprecated;then
		   eerror "rebuild dev-scheme/guile with USE=deprecated"
		   die
		fi
}
