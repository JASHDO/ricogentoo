# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/povray/povray-3.6.1-r2.ebuild,v 1.16 2007/11/01 21:08:30 lavajoe Exp $

inherit flag-o-matic eutils autotools

DESCRIPTION="The Persistence Of Vision Ray Tracer"
SRC_URI="ftp://ftp.povray.org/pub/povray/Official/Unix/${P}.tar.bz2"
HOMEPAGE="http://www.povray.org/"

SLOT="0"
LICENSE="povlegal-3.6"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="X svga"

DEPEND="media-libs/libpng
	>=media-libs/tiff-3.6.1
	media-libs/jpeg
	sys-libs/zlib
	X? ( x11-libs/libXaw )
	svga? ( media-libs/svgalib )"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.patch
	epatch "${FILESDIR}"/${P}-find-egrep.patch
	eaclocal
	eautoconf
}

src_compile() {
	local myconf

	# closes bug 71255
	if [[ $(get-flag march) == k6-2 ]]; then
		filter-flags -fomit-frame-pointer
	fi

	myconf="${myconf} --disable-optimiz"

	use X && myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"\
		CFLAGS="${CFLAGS} -DX_DISPLAY_MISSING"
	use svga || myconf="${myconf} --without-svga"

	econf COMPILED_BY="${USER} (on `uname -n`)" ${myconf} || die

	# Copy the user configuration into /etc/skel
	cp Makefile Makefile.orig
	sed -e "s:^povconfuser = .*:povconfuser = "${D}"etc/skel/.povray/3.6/:" Makefile.orig >Makefile

	einfo Building povray
	emake || die "build failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
}
