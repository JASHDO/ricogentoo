# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/trackballs/trackballs-1.1.2.ebuild,v 1.4 2007/01/10 19:43:17 peper Exp $

inherit eutils games

DESCRIPTION="simple game similar to the classical game Marble Madness"
HOMEPAGE="http://trackballs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${PN}-music-1.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="nls"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	>=dev-scheme/guile-1.6
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's/icons//' share/Makefile.in \
		|| die "sed failed"
	sed -i \
		-e '/^localedir/s:=.*:=/usr/share/locale:' \
		src/Makefile.in \
		po/Makefile.in.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-highscores="${GAMES_STATEDIR}/${PN}-highscores" \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto "${GAMES_DATADIR}/${PN}/music"
	doins "${WORKDIR}"/tb_*.ogg || die "doins failed"
	dodoc AUTHORS ChangeLog README* NEWS
	doicon share/icons/*png || die "doicon failed"
	make_desktop_entry trackballs "Trackballs" trackballs-48x48.png
	prepgamesdirs
}
