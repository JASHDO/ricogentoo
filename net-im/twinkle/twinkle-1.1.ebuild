# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/twinkle/twinkle-1.1.ebuild,v 1.3 2007/12/24 09:59:13 dragonheart Exp $

ARTS_REQUIRED="never"
inherit eutils qt3 kde

DESCRIPTION="a soft phone for your VOIP communcations using SIP"
HOMEPAGE="http://www.twinklephone.com/"
SRC_URI="http://www.xs4all.nl/~mfnboer/twinkle/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="arts speex ilbc zrtp kdehiddenvisibility"

# Requires libqt-mt actually...  Is that *always* built, or do we need to check?
RDEPEND=">=net-libs/ccrtp-1.5.0
	>=dev-cpp/commoncpp2-1.4.2
	$(qt_min_version 3.3.0)
	media-libs/libsndfile
	dev-libs/boost
	speex? ( media-libs/speex )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	zrtp? ( net-libs/libzrtpcpp )
	media-libs/alsa-lib"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if use speex && has_version '~media-libs/speex-1.2_beta2' &&
		! built_with_use 'media-libs/speex' 'wideband' ; then
		eerror "You need to build media-libs/speex with USE=wideband enabled."
		die "Speex w/o wideband-support detected."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.4.1-badcflags.patch
	epatch "${FILESDIR}"/twinkle.desktop.patch
}

src_compile() {
	local myconf=" \
			$(use_with ilbc) \
			$(use_with arts) \
			$(use_with zrtp) \
			$(use_with speex)"
	set-kdedir
	kde_src_compile
}

src_install() {
	kde_src_install
	dodoc THANKS
	domenu twinkle.desktop
}

pkg_postinst() {
	elog "if you get crashes on startup re-emerge commoncpp2 ccrtp and	twinkle"
	elog "see http://www.xs4all.nl/~mfnboer/twinkle/faq.html#crash_startup"
	kde_pkg_postinst
}
