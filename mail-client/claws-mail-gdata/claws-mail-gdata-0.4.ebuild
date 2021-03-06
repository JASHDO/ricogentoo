# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-gdata/claws-mail-gdata-0.4.ebuild,v 1.3 2012/10/31 18:43:46 nativemad Exp $

EAPI=4

inherit multilib

MY_P="${PN#claws-mail-}_plugin-${PV}"

DESCRIPTION="Plugin for Claws to use Google data providers"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND=">=mail-client/claws-mail-3.8.1
	>=dev-libs/libgdata-0.6.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README

	# kill useless files
	rm -f "${D}"/usr/$(get_libdir)/claws-mail/plugins/*.{a,la}

	# going to conflict with libical
	rm -f "${D}"/usr/include/ical.h
}
