# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-3.0.3.ebuild,v 1.1 2013/08/25 16:25:04 eva Exp $

EAPI="5"
VALA_MIN_API_VERSION="0.18"

inherit eutils vala

DESCRIPTION="Spell checking widget for GTK"
HOMEPAGE="http://gtkspell.sourceforge.net/"
MY_P="${PN}3-${PV}"
SRC_URI="mirror://sourceforge/project/${PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2+"
SLOT="3/0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE="+introspection vala"

RDEPEND="
	>=app-text/enchant-1.1.6
	app-text/iso-codes
	dev-libs/glib:2
	x11-libs/gtk+:3[introspection?]
	>=x11-libs/pango-1.8.0[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-1.30 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.17
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
	vala? ( $(vala_depend) )
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	use vala && vala_src_prepare
}

src_configure() {
	econf \
		--disable-static \
		$(use_enable introspection) \
		$(use_enable vala)
}

src_install() {
	default
	prune_libtool_files
}
