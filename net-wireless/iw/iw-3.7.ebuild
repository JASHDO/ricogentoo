# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iw/iw-3.7.ebuild,v 1.1 2012/10/17 03:30:18 zerochaos Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="nl80211-based configuration utility for wireless devices using the mac80211 kernel stack"
HOMEPAGE="http://wireless.kernel.org/en/users/Documentation/iw"
SRC_URI="http://linuxwireless.org/download/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/libnl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	tc-export CC LD
}
