# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-6.3.7.9.ebuild,v 1.4 2008/01/21 00:32:26 maekke Exp $

inherit eutils multilib perl-app

MY_PN=ImageMagick
MY_P=${MY_PN}-${PV%.*}
MY_P2=${MY_PN}-${PV%.*}-${PV#*.*.*.}

DESCRIPTION="A collection of tools and libraries for many image formats"
HOMEPAGE="http://www.imagemagick.org/"
SRC_URI="ftp://ftp.imagemagick.org/pub/${MY_PN}/${MY_P2}.tar.bz2"

LICENSE="imagemagick"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="bzip2 djvu doc fontconfig fpx graphviz gs hdri jbig jpeg jpeg2k lcms nocxx
	openexr perl png q8 q32 svg tiff truetype X wmf xml zlib"

RDEPEND="bzip2? ( app-arch/bzip2 )
	djvu? ( app-text/djvu )
	fontconfig? ( media-libs/fontconfig )
	fpx? ( media-libs/libfpx )
	graphviz? ( >=media-gfx/graphviz-2.6 )
	gs? ( virtual/ghostscript )
	jbig? ( media-libs/jbigkit )
	jpeg? ( >=media-libs/jpeg-6b )
	jpeg2k? ( media-libs/jasper )
	lcms? ( >=media-libs/lcms-1.06 )
	openexr? ( media-libs/openexr )
	perl? ( >=dev-lang/perl-5.8.6-r6 !=dev-lang/perl-5.8.7 )
	png? ( media-libs/libpng )
	svg? ( >=gnome-base/librsvg-2.9.0 )
	tiff? ( >=media-libs/tiff-3.5.5 )
	xml? ( >=dev-libs/libxml2-2.4.10 )
	truetype? ( =media-libs/freetype-2* media-fonts/corefonts )
	wmf? ( >=media-libs/libwmf-0.2.8 )
	zlib? ( sys-libs/zlib )
	X? (
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libICE
		x11-libs/libSM
	)
	!dev-perl/perlmagick
	!sys-apps/compare"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	>=sys-devel/libtool-1.5.2-r6
	X? ( x11-proto/xextproto )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use djvu && ! built_with_use app-text/djvu threads; then
		eerror "app-text/djvu has to be built with threads support."
		die "build app-text/djvu with USE=\"threads\""
	fi
}

src_unpack() {
	unpack ${A}

	# fix doc dir, bug 91911
	epatch "${FILESDIR}"/${P}-doc.patch
}

src_compile() {
	local quantum
	if use q32 ; then
		quantum="${quantum} --with-quantum-depth=32"
	elif use q8 ; then
		quantum="${quantum} --with-quantum-depth=8"
	else
		quantum="${quantum} --with-quantum-depth=16"
	fi

	econf \
		--with-threads \
		--with-modules \
		$(use_with perl) \
		--with-gs-font-dir=/usr/share/fonts/default/ghostscript \
		${quantum} \
		$(use_enable hdri) \
		$(use_with truetype windows-font-dir /usr/share/fonts/corefonts) \
		$(use_with !nocxx magick-plus-plus) \
		$(use_with bzip2 bzlib) \
		$(use_with djvu) \
		$(use_with fontconfig) \
		$(use_with fpx) \
		$(use_with gs dps) \
		$(use_with gs gslib) \
		$(use_with graphviz gvc) \
		$(use_with jbig) \
		$(use_with jpeg jpeg) \
		$(use_with jpeg2k jp2) \
		$(use_with lcms) \
		$(use_with png) \
		$(use_with svg rsvg) \
		$(use_with tiff) \
		$(use_with truetype freetype) \
		$(use_with wmf) \
		$(use_with xml) \
		$(use_with zlib) \
		$(use_with X x) \
		$(use_with openexr) \
		|| die "econf failed"
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation of files into image failed"

	# dont need these files with runtime plugins
	rm -f "${D}"/usr/$(get_libdir)/*/*/*.{la,a}

	! use doc && rm -r "${D}"/usr/share/doc/${PF}/html
	dodoc NEWS ChangeLog AUTHORS README.txt

	# Fix perllocal.pod file collision
	use perl && fixlocalpod
}
