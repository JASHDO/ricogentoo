# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aria2/aria2-0.11.5.ebuild,v 1.2 2007/11/22 15:13:05 dev-zero Exp $

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

MY_P=${P/_p/+}

DESCRIPTION="A download utility with resuming and segmented downloading with HTTP/HTTPS/FTP/BitTorrent support."
HOMEPAGE="http://aria2.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE="ares bittorrent gnutls metalink nls ssl test"

# Tests are broken again on amd64
RESTRICT="test"

CDEPEND="ssl? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( dev-libs/openssl ) )
	ares? ( >=net-dns/c-ares-1.3.1 )
	bittorrent? ( gnutls? ( dev-libs/libgcrypt ) )
	metalink? ( >=dev-libs/libxml2-2.6.26 )"
DEPEND="${CDEPEND}
	nls? ( sys-devel/gettext )
	test? ( >=dev-util/cppunit-1.12.0 )"
RDEPEND="${CDEPEND}
	nls? ( virtual/libiconv virtual/libintl )"

S=${WORKDIR}/${MY_P}

src_compile() {
	use ssl && \
		myconf="${myconf} $(use_with gnutls) $(use_with !gnutls openssl)"

	# Note:
	# - we don't have ares, only libcares
	# - depends on libgcrypt only when using openssl
	econf \
		$(use_enable nls) \
		$(use_enable metalink) \
		$(use_enable bittorrent) \
		--without-ares \
		$(use_with ares libcares) \
		$(use_with metalink libxml2) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README AUTHORS TODO NEWS
}
