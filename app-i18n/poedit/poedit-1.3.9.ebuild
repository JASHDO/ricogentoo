# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/poedit/poedit-1.3.9.ebuild,v 1.1 2007/12/23 18:31:34 dirtyepic Exp $

EAPI=1
WX_GTK_VER=2.8

inherit eutils wxwidgets flag-o-matic fdo-mime

DESCRIPTION="Cross-platform gettext catalogs (.po files) editor."
SRC_URI="mirror://sourceforge/poedit/${P}.tar.gz"
HOMEPAGE="http://poedit.sourceforge.net/"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="spell"

DEPEND="x11-libs/wxGTK:2.8
	>=sys-libs/db-3.1
	spell? ( >=app-text/gtkspell-2.0.0 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# http://sourceforge.net/tracker/index.php?func=detail&aid=1857103&group_id=27043&atid=389153
	epatch "${FILESDIR}"/${P}-sobsolete.patch
}

src_compile() {
	append-flags -fno-strict-aliasing

	econf \
		$(use_enable spell spellchecking) \
		|| die "Configure failed!"

	emake || die "Build failed!"
}

src_install () {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS NEWS README TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
