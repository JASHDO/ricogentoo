# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnomesword/gnomesword-2.3.1-r1.ebuild,v 1.1 2008/01/07 03:01:27 beandog Exp $

inherit libtool gnome2 eutils

DESCRIPTION="Gnome Bible study software"
HOMEPAGE="http://gnomesword.sf.net/"
SRC_URI="mirror://sourceforge/gnomesword/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="firefox seamonkey spell xulrunner"
DEPEND=">=gnome-extra/gtkhtml-3.14
	=app-text/sword-1.5.10*
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libglade-2
	dev-libs/libxml2
	xulrunner? ( net-libs/xulrunner )
	!xulrunner? ( firefox? ( www-client/mozilla-firefox ) )
	!xulrunner? ( !firefox? ( seamonkey? ( www-client/seamonkey ) ) )
	spell? (
		app-text/gnome-spell
		>=gnome-base/libbonoboui-2 )
	>=dev-util/pkgconfig-0.12
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.3.14"
G2CONF="${G2CONF} $(use_enable spell pspell)"
DOCS="NEWS ChangeLog README TODO"

pkg_postinst() {
	gnome2_pkg_postinst

	einfo "Gnomesword requires modules to be of any use. You may install the"
	einfo "sword-modules package, or download modules individually from the"
	einfo "sword website: http://crosswire.org/sword/"
}
