# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kdenlive/kdenlive-0.7.ebuild,v 1.4 2009/01/04 15:04:37 scarabeus Exp $

EAPI="2"

NEED_KDE="4.1"
KDE_LINGUAS="de zh"
inherit kde4-base eutils

DESCRIPTION="Kdenlive! (pronounced Kay-den-live) is a Non Linear Video Editing Suite for KDE."
HOMEPAGE="http://www.kdenlive.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV/_/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/mlt-0.3.2[ffmpeg,sdl,-qt3]
	>=media-libs/mlt++-0.3.2
	media-video/ffmpeg[X,sdl]"
RDEPEND="${DEPEND}
	>=kde-base/kdebase-data-${NEED_KDE}"

S="${WORKDIR}"/"${PN}-${PV/_/}"

PATCHES=( "${FILESDIR}/${P}-avcodeclink.patch" )
