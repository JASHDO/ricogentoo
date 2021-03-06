# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-autoplaylist/gmpc-autoplaylist-0.14.0.ebuild,v 1.2 2007/04/15 15:29:57 ticho Exp $

DESCRIPTION="The plugin allows you to generate a playlist based on a set of rules"
HOMEPAGE="http://sarine.nl/gmpc-plugins-autoplaylist"
SRC_URI="http://download.sarine.nl/gmpc-${PV}/plugins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-sound/gmpc-${PV}
		dev-libs/libxml2"

src_compile ()
{
	econf || die
	emake || die
}

src_install ()
{
	make DESTDIR="${D}" install || die
}
