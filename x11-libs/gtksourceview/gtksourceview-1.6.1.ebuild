# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtksourceview/gtksourceview-1.6.1.ebuild,v 1.12 2007/10/10 15:01:21 remi Exp $

inherit gnome2

DESCRIPTION="A text widget implementing syntax highlighting and other features"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="1.0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.8
	>=dev-libs/libxml2-2.5
	>=gnome-base/libgnomeprint-2.8
	>=dev-libs/glib-2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.31
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"

pkg_setup() {
	# Removes the gnome-vfs dep
	G2CONF="${G2CONF} --disable-build-tests"
}
