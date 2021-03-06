# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/freevo/freevo-1.5.4.ebuild,v 1.11 2007/11/27 11:14:27 zzam Exp $

inherit distutils

IUSE="matrox dvd encode lirc X nls"
DESCRIPTION="Digital video jukebox (PVR, DVR)."
HOMEPAGE="http://www.freevo.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

DEPEND=">=dev-python/pygame-1.5.6
	>=dev-python/imaging-1.1.3
	>=dev-python/pyxml-0.8.2
	>=dev-python/twisted-2
	>=dev-python/twisted-web-0.5.0-r1
	>=dev-python/mmpython-0.4.5
	>=media-video/mplayer-0.92
	>=media-libs/freetype-2.1.4
	>=media-libs/libsdl-1.2.5
	dvd? ( >=media-video/xine-ui-0.9.22 >=media-video/lsdvd-0.10 )
	encode? ( >=media-sound/cdparanoia-3.9.8 >=media-sound/lame-3.93.1 )
	matrox? ( >=media-video/matroxset-0.3 )
	lirc? ( app-misc/lirc >=dev-python/pylirc-0.0.3 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use media-libs/sdl-image png; then
		eerror "media-libs/sdl-image must be emerged with the 'png' use flag"
		eerror "Please fix and re-emerge freevo."
		die "fix use flags"
	fi
}

src_install() {
	distutils_src_install

	insinto /etc/freevo
	doins "${T}/freevo.conf"
	newins local_conf.py.example local_conf.py

	if [ "${PROFILE_ARCH}" == "xbox" ]; then
		sed -i -e "s/# MPLAYER_AO_DEV.*/MPLAYER_AO_DEV='alsa1x'/" "${D}"/etc/freevo/local_conf.py
		newins "${FILESDIR}"/xbox-lircrc lircrc
	fi

	newinitd "${FILESDIR}/freevo.rc6" freevo
	newconfd "${FILESDIR}/freevo.conf" freevo

	rm -rf "${D}/usr/share/doc"
	newdoc Docs/README README.docs
	dodoc BUGS COPYING ChangeLog FAQ INSTALL PKG-INFO README TODO \
		Docs/{CREDITS,NOTES,plugins/*.txt}
	cp -r Docs/{installation,plugin_writing} "${D}/usr/share/doc/${PF}"

	use nls || rm -rf "${D}"/usr/share/locale
}

pkg_postinst() {
	elog "If you want to schedule programs, emerge xmltv now."
	elog

	elog "Please check /etc/freevo/freevo.conf and"
	elog "/etc/freevo/local_conf.py before starting Freevo."
	elog "To rebuild freevo.conf with different parameters,"
	elog "please run:"
	elog "    freevo setup"
	elog

	if [ -e "${ROOT}/opt/freevo" ] ; then
		ewarn "Please remove ${ROOT}/opt/freevo because it is no longer used."
	fi
	if [ -e "${ROOT}/etc/freevo/freevo_config.py" ] ; then
		ewarn "Please remove ${ROOT}/etc/freevo/freevo_config.py."
	fi
	if [ -e "${ROOT}/etc/init.d/freevo-record" ] ; then
		ewarn "Please remove ${ROOT}/etc/init.d/freevo-record"
	fi
	if [ -e "${ROOT}/etc/init.d/freevo-web" ] ; then
		ewarn "Please remove ${ROOT}/etc/init.d/freevo-web"
	fi

	local myconf
	if [ "`/bin/ls -l /etc/localtime | grep -e "Europe\|GMT"`" ] ; then
		myconf="${myconf} --tv=pal"
	fi
	if [ "${PROFILE_ARCH}" == "xbox" ]; then
		myconf="${myconf} --geometry=640x480 --display=x11"
	elif use matrox ; then
		myconf="${myconf} --geometry=768x576 --display=mga"
	elif use X ; then
		myconf="${myconf} --geometry=800x600 --display=x11"
	else
		myconf="${myconf} --geometry=800x600 --display=fbdev"
	fi

	"/usr/bin/freevo" setup ${myconf} || die "configure problem"
}
