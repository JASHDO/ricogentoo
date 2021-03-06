# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/licq-osd/licq-osd-1.2.7.5-r1.ebuild,v 1.1 2005/03/15 12:51:03 voxus Exp $

MY_PN="licq_osd_plugin"
DESCRIPTION="On Screen Display for licq"
HOMEPAGE="http://sourceforge.net/projects/licq-osd"
SRC_URI="mirror://sourceforge/${PN}/osd-${PV}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="nls"
DEPEND=">=net-im/licq-1.3.0_pre
		>=x11-libs/xosd-2.2.2
		nls? ( sys-devel/gettext )"

S=${WORKDIR}/osd-${PV}

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	myconf="${myconf} --with-licq-includes=/usr/include/licq"
	myconf="${myconf} --with-cvs"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc README licq_osd.conf TODO AUTHORS
}
