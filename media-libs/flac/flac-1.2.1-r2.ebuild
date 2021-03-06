# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/flac/flac-1.2.1-r2.ebuild,v 1.6 2008/05/15 20:39:51 drac Exp $

EAPI=1

inherit autotools eutils

DESCRIPTION="free lossless audio encoder and decoder"
HOMEPAGE="http://flac.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="3dnow altivec +cxx debug doc ogg sse"

RDEPEND="ogg? ( >=media-libs/libogg-1.1.3 )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	!elibc_uclibc? ( sys-devel/gettext )
	dev-util/pkgconfig"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix building with asneeded on non-glibc systems.
	# Fix text relocations. Fix {C,XX}FLAGS.
	epatch "${FILESDIR}"/${P}-asneeded.patch \
		"${FILESDIR}"/${P}-cflags.patch \
		"${FILESDIR}"/${P}-asm.patch

	# Fix build with gcc 4.3, bug #199579
	epatch "${FILESDIR}/${P}-gcc-4.3-includes.patch"

	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf $(use_enable ogg) \
		$(use_enable sse) \
		$(use_enable 3dnow) \
		$(use_enable altivec) \
		$(use_enable debug) \
		$(use_enable cxx cpplibs) \
		--disable-doxygen-docs \
		--disable-dependency-tracking \
		--disable-xmms-plugin

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	rm -rf "${D}"/usr/share/doc/${P}
	dodoc AUTHORS README
	use doc && dohtml -r doc/html/*
}
