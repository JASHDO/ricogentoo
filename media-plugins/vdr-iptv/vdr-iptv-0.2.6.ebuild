# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-iptv/vdr-iptv-0.2.6.ebuild,v 1.1 2009/03/22 19:41:12 zzam Exp $

EAPI="2"

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: Add a logical device capable of receiving IPTV"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/iptv/"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/iptv/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( >=media-video/vdr-1.6.0[iptv]
			>=media-video/vdr-1.6.0[pluginparam] )"
RDEPEND="${DEPEND}"

src_prepare() {
	fix_vdr_libsi_include sidscanner.c
	vdr-plugin_src_prepare
}
