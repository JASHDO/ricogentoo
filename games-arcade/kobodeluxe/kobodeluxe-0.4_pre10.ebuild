# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kobodeluxe/kobodeluxe-0.4_pre10.ebuild,v 1.17 2007/09/23 16:02:14 josejx Exp $

inherit eutils games

MY_P="KoboDeluxe-${PV/_/}"
DESCRIPTION="An SDL port of xkobo, a addictive space shoot-em-up"
HOMEPAGE="http://www.olofson.net/kobodl/"
SRC_URI="http://www.olofson.net/kobodl/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE="opengl"

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	opengl? ( virtual/opengl )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc41.patch
	# Fix paths
	sed -i \
		-e 's:\$(datadir)/games/kobo-deluxe:$(datadir)/kobodeluxe:' \
		-e 's:\$(prefix)/games/kobo-deluxe/scores:$(localstatedir)/kobodeluxe:' \
		configure || die "sed configure failed"
	sed -i \
		-e 's:\$(datadir)/games/kobo-deluxe:$(datadir)/kobodeluxe:' \
		data/Makefile.in || die "sed data/Makefile.in failed"
}

src_compile() {
	egamesconf $(use_enable opengl) || die
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/logo3.png ${PN}.png
	make_desktop_entry kobodl "Kobo Deluxe"
	dodoc ChangeLog README* TODO
	insinto "${GAMES_STATEDIR}"/${PN}
	doins 501 || die "doins failed"
	prepgamesdirs
	fperms 2775 "${GAMES_STATEDIR}"/${PN}
}

pkg_postinst() {
	games_pkg_postinst
	elog "The location of the highscore files has changed.  If this isn't the"
	elog "first time you've installed ${PN} and you'd like to keep the high"
	elog "scores from a previous version of ${PN}, please move all the files"
	elog "in /var/lib/games/kobodeluxe/ to ${GAMES_STATEDIR}/${PN}. If you"
	elog "have a /var/lib/games/kobodeluxe/ directory it may be removed."
}
