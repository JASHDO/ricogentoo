# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsndfile/libsndfile-1.0.17-r1.ebuild,v 1.14 2008/04/21 07:15:33 vapier Exp $

inherit eutils libtool autotools

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.mega-nerd.com/libsndfile"
SRC_URI="http://www.mega-nerd.com/libsndfile/${P}.tar.gz
	mirror://gentoo/${P}+flac-1.1.3.patch.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="sqlite flac alsa"

RESTRICT="test"

RDEPEND="flac? ( media-libs/flac )
	alsa? ( media-libs/alsa-lib )
	sqlite? ( >=dev-db/sqlite-3.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}/${P}+flac-1.1.3.patch"
	epatch "${FILESDIR}/${P}-ogg.patch"
	epatch "${FILESDIR}/${P}-flac-buffer-overflow.patch"
	epatch "${FILESDIR}/${P}-dontbuild-tests-examples.patch"
	epatch "${FILESDIR}/${P}-regtests-need-sqlite.patch"
	epatch "${FILESDIR}"/${P}-autotools.patch

	# Fix for autoconf 2.62
	sed -i -e '/AC_MSG_WARN(\[\[/d' acinclude.m4 || die

	eautoreconf
	epunt_cxx
}

src_compile() {
	econf $(use_enable sqlite) \
		$(use_enable flac) \
		$(use_enable alsa) \
		--disable-werror \
		--disable-gcc-pipe \
		--disable-dependency-tracking || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	emake -j1 DESTDIR="${D}" htmldocdir="/usr/share/doc/${PF}/html" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
