# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ttcut/ttcut-0.19.5-r1.ebuild,v 1.1 2007/08/18 21:49:35 zzam Exp $

inherit eutils qt4

DESCRIPTION="Tool for removing advertisements from recorded MPEG files"
HOMEPAGE="http://ttcut.tritime.org/"
SRC_URI="mirror://berlios/${PN}/${P/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="$(qt4_min_version 4.1)
	>=media-libs/libmpeg2-0.4.0
	virtual/opengl"

RDEPEND="${DEPEND}
	media-video/mplayer
	media-video/transcode"

S=${WORKDIR}/${PN}

pkg_setup() {
	if ! built_with_use media-video/transcode mjpeg ; then
		eerror "In order to have encoding mode working with ttcut"
		eerror "you need to recompile transcode with mjpeg USE flag enabled."
		die "Recompile transcode with mjpeg USE flag enabled"
	fi
}

src_compile() {
	eqmake4 ttcut.pro -o Makefile.ttcut
	emake -f Makefile.ttcut || die "emake failed"
}

src_install() {
	dobin ttcut || die "Couldn't install ttcut"
	make_desktop_entry ttcut TTCut "" "AudioVideo;Video;AudioVideoEditing" || \
		die "Couldn't make ttcut desktop entry"

	dodoc AUTHORS BUGS CHANGELOG \
		README.DE README.EN TODO || die "Couldn't install documentation"
}
