# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amsynth/amsynth-1.0.0.ebuild,v 1.13 2007/01/05 17:21:41 flameeyes Exp $

IUSE="oss alsa jack"

inherit eutils

MY_P=${P/_rc/-rc}
MY_P=${MY_P/amsynth/amSynth}

DESCRIPTION="A retro analogue - modelling softsynth"
HOMEPAGE="http://amsynthe.sourceforge.net/"
SRC_URI="mirror://sourceforge/amsynthe/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

# libsndfile support is actually optional, but IMHO this package should have it
DEPEND="=dev-cpp/gtkmm-1.2* \
	media-libs/libsndfile \
	alsa? ( media-libs/alsa-lib \
		media-sound/alsa-utils ) \
	jack? ( media-sound/jack-audio-connection-kit )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i "/#include <alsa\\/asoundlib.h>/i\\#define ALSA_PCM_OLD_HW_PARAMS_API 1\\" src/drivers/ALSAmmapAudioDriver.h
	sed -i "/#include <alsa\\/asoundlib.h>/i\\#define ALSA_PCM_OLD_HW_PARAMS_API 1\\" src/drivers/ALSAAudioDriver.h

	epatch ${FILESDIR}/${PN}-pthread.patch
}

src_compile() {
	econf `use_with oss` `use_with alsa` `use_with jack` || die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	elog
	elog "amSynth has been installed normally."
	elog "If you would like to use the virtual"
	elog "keyboard option, then do"
	elog "emerge vkeybd"
	elog "and make sure you emerged amSynth"
	elog "with alsa support (USE=alsa)"
	elog
}
