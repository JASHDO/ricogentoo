# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-0.8.6-r1.ebuild,v 1.9 2006/10/04 16:57:51 grobian Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit libtool eutils autotools

PATCHLEVEL="2"

DESCRIPTION="the audio output library"
HOMEPAGE="http://www.xiph.org/ao/"
SRC_URI="http://downloads.xiph.org/releases/ao/${P}.tar.gz
	http://digilander.libero.it/dgp85/gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="alsa arts esd nas mmap"

RDEPEND="alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( >=media-sound/esound-0.2.22 )
	nas? ( media-libs/nas )"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake"

src_unpack() {
	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/${PV}

	AT_M4DIR="${WORKDIR}/${PV}/m4" eautoreconf
	elibtoolize
}

src_compile() {
	# this is called alsa09 even if it is alsa 1.0
	econf \
		$(use_enable alsa alsa09) \
		$(use_enable mmap alsa09-mmap) \
		$(use_enable arts) \
		$(use_enable esd) \
		$(use_enable nas) \
		--enable-shared \
		--enable-static \
		|| die

	# See bug #37218.  Build problems with parallel make.
	emake -j1 || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS CHANGES README TODO
	dohtml -A c doc/*.html
}
