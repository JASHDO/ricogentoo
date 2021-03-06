# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ortp/ortp-0.13.1.ebuild,v 1.4 2008/02/12 21:39:09 vapier Exp $

DESCRIPTION="Open Real-time Transport Protocol (RTP) stack"
HOMEPAGE="http://www.linphone.org/index.php/v2/code_review/ortp/"
SRC_URI="http://download.savannah.nongnu.org/releases/linphone/${PN}/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6"

DEPEND="=dev-libs/glib-2*
	>=dev-util/pkgconfig-0.9.0"
RDEPEND="=dev-libs/glib-2*"

src_compile() {
	econf \
		--disable-strict \
		$(use_enable ipv6) \
		|| die 'configure failed'
	emake || die 'make compile failed'
}

src_install() {
	emake DESTDIR="${D}" install || die "Make install failed"
	dodoc README ChangeLog AUTHORS TODO NEWS
	dodoc docs/*.txt
}
