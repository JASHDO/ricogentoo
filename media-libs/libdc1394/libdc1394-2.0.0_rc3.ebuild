# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdc1394/libdc1394-2.0.0_rc3.ebuild,v 1.2 2007/07/22 09:35:30 dberkholz Exp $

inherit eutils

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="library for controling IEEE 1394 conforming based cameras"
HOMEPAGE="http://sourceforge.net/projects/libdc1394/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="X"

RDEPEND=">=sys-libs/libraw1394-1.2.0
		X? ( x11-libs/libSM x11-libs/libXv )"
DEPEND="!=sys-libs/libdc1394-2*
	${RDEPEND}
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-update-iso_channel.patch
}

src_compile() {
	econf \
		--program-suffix=2 \
		$(use_with X x) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc NEWS README AUTHORS ChangeLog
}
