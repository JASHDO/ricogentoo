# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/attal/attal-0.9.3.ebuild,v 1.7 2006/06/29 13:39:04 wolf31o2 Exp $

inherit eutils flag-o-matic games

MY_P="${PN}-src-${PV}"
DESCRIPTION="turn-based strategy game project"
HOMEPAGE="http://www.attal-thegame.org/"
SRC_URI="mirror://sourceforge/attal/${MY_P}.tar.bz2
	mirror://sourceforge/attal/themes-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="=x11-libs/qt-3*
	media-libs/libsdl"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:\"\./:\"${GAMES_BINDIR}/:" \
		server/serverInterface.cpp \
		client/clientInterface.cpp \
		|| die "sed failed"
	sed -i \
		-e "s:\"\./:\"${GAMES_DATADIR}/${PN}/:" \
		libCommon/displayHelp.cpp \
		|| die "sed failed"
	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake -o Makefile Makefile.pro || die "qmake failed"
	sed -i \
		"s:\./themes/:${GAMES_DATADIR}/${PN}/themes/:" \
		$(grep -Rl '\./themes/' *) \
		|| die "fixing theme loc"
	find "${WORKDIR}"/themes-${PV} -name .cvsignore -print0 | xargs -0 rm -f
}

src_compile() {
	# broken deps in the makefiles ...
	append-flags -fPIC
	emake \
		CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		sub-libCommon || die "emake sub-libCommon failed"
	emake \
		CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		sub-{libFight,libClient,libServer} || die "emake libs failed"
	emake \
		CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dogamesbin attal-* || die "dogamesbin failed"
	into "${GAMES_PREFIX}"
	dolib.so lib*.so* || die "dolib.so failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins HOWTOPLAY.html
	insinto "${GAMES_DATADIR}"/${PN}/themes
	doins -r "${WORKDIR}"/themes-${PV}/* || die "doins themes failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
