# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qtcurve/gtk-engines-qtcurve-0.48.4.ebuild,v 1.1 2007/04/07 19:19:36 genstef Exp $

inherit eutils

MY_P="${P/gtk-engines-qtcurve/QtCurve-Gtk2}"
DESCRIPTION="A set of widget styles for GTK2 based apps, also available for KDE"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://home.freeuk.com/cpdrummond/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mozilla"
DEPEND="x11-libs/cairo
	>=x11-libs/gtk+-2.0"
S="${WORKDIR}/${MY_P}"

src_compile() {
	econf $(use_enable mozilla mozilla-mods) || die "econf failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README TODO
}
