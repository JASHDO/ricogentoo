# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libisofs/libisofs-1.2.4.ebuild,v 1.7 2012/09/30 18:58:14 armin76 Exp $

EAPI=4

DESCRIPTION="libisofs is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia-project.org/"
SRC_URI="http://files.libburnia-project.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc ppc64 x86"
IUSE="acl debug static-libs verbose-debug xattr zlib"

RDEPEND="acl? ( virtual/acl )
	xattr? ( sys-apps/attr )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
	$(use_enable static-libs static) \
	$(use_enable debug) \
	$(use_enable verbose-debug) \
	$(use_enable acl libacl) \
	$(use_enable xattr) \
	$(use_enable zlib) \
	--disable-libjte \
	--disable-ldconfig-at-install
}

src_install() {
	default

	dodoc Roadmap doc/{checksums.txt,susp_aaip*,Tutorial,zisofs_format.txt}

	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
