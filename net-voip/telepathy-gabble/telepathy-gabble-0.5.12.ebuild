# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-gabble/telepathy-gabble-0.5.12.ebuild,v 1.2 2007/06/30 17:40:08 peper Exp $

DESCRIPTION="A Jabber/XMPP connection manager, this handles single and multi user chats and voice calls."
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.4
	>=dev-libs/dbus-glib-0.72
	>=net-libs/telepathy-glib-0.5.13
	>=dev-lang/python-2.3
	>=net-libs/loudmouth-1.1.1
	!<net-voip/telepathy-gabble-0.5.10"

DEPEND="${RDEPEND}
	dev-libs/libxslt"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable debug backtrace) \
		$(use_enable debug handle-leak-debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_test() {
	vecho ">>> Test phase [check]: ${CATEGORY}/${PF}"
	if ! dbus-launch emake -j1 check; then
		die "Make check failed. See above for details."
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog
}
