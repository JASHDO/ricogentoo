# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgee/libgee-0.6.3.ebuild,v 1.4 2012/01/18 20:22:59 maekke Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 multilib

DESCRIPTION="GObject-based interfaces and classes for commonly used data structures."
HOMEPAGE="http://live.gnome.org/Libgee"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-linux"
IUSE="+introspection"

RDEPEND=">=dev-libs/glib-2.12:2
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog* MAINTAINERS NEWS README"
	G2CONF="${G2CONF} $(use_enable introspection)"
}
