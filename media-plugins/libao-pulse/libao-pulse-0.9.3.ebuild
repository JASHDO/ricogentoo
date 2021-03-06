# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/libao-pulse/libao-pulse-0.9.3.ebuild,v 1.21 2008/01/14 12:45:41 flameeyes Exp $

DESCRIPTION="libao output driver for PulseAudio"
HOMEPAGE="http://0pointer.de/lennart/projects/libao-pulse/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libao-0.8.5
	>=media-sound/pulseaudio-0.9.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	# Lynx is used during make dist basically
	econf \
		--disable-static \
		--disable-dependency-tracking \
		--disable-lynx || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dohtml -r doc
	dodoc README doc/todo
}
