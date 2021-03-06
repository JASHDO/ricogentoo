# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konsole/konsole-4.9.3.ebuild,v 1.1 2012/11/08 23:26:43 creffett Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_DOC_DIRS="doc/manual"
VIRTUALX_REQUIRED="test"
inherit kde4-base

DESCRIPTION="X terminal for use with KDE"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

COMMONDEPEND="
	!aqua? (
		$(add_kdebase_dep libkonq)
		x11-libs/libX11
		x11-libs/libXext
		>=x11-libs/libxklavier-3.2
		x11-libs/libXrender
		x11-libs/libXtst
	)
"
DEPEND="${COMMONDEPEND}
	!aqua? (
		x11-apps/bdftopcf
		x11-proto/kbproto
		x11-proto/renderproto
	)
"
RDEPEND="${COMMONDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-4.7.0-tests.patch"
)
