# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdc1394/libdc1394-2.0.0.ebuild,v 1.1 2008/01/14 19:19:42 stefaan Exp $

inherit eutils

DESCRIPTION="library for controling IEEE 1394 conforming based cameras"
HOMEPAGE="http://sourceforge.net/projects/libdc1394/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="X juju"

DEPEND=">=sys-libs/libraw1394-1.2.0
		juju? ( >=sys-kernel/linux-headers-2.6.23-r3 )
		X? ( || ( ( x11-libs/libSM x11-libs/libXv )
				  virtual/x11 ) )"

src_compile() {
	econf \
		--program-suffix=2 \
		$(use_with X x) \
		$(use_with juju juju-dir) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc NEWS README AUTHORS ChangeLog
}
