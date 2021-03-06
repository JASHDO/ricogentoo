# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-fsguard/xfce4-fsguard-0.3.0.ebuild,v 1.13 2007/09/29 08:00:06 drac Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit xfce44 eutils autotools

xfce44

DESCRIPTION="Filesystem guard panel plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

DEPEND=">=xfce-extra/xfce4-dev-tools-${XFCE_MASTER_VERSION}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	AT_M4DIR=/usr/share/xfce4/dev-tools/m4macros eautoreconf
}

xfce44_goodies_panel_plugin
