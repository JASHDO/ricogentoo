# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-1.3.20040120-r1.ebuild,v 1.6 2006/06/15 20:32:59 truedfx Exp $

inherit eutils

IUSE="gnome esd nls audiofile"

# detect cvs snapshots; fex. 1.3.20040120
if [[ $PV == *.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] ]]; then
	sawfishsnapshot=true
else
	sawfishsnapshot=false
fi

DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
HOMEPAGE="http://sawmill.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
if $sawfishsnapshot; then
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
	S=${WORKDIR}/${PN}
else
	SRC_URI="mirror://sourceforge/sawmill/${P}.tar.gz"
	S=${WORKDIR}/${P}
fi

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=x11-libs/rep-gtk-0.17
	>=dev-libs/librep-0.16
	>=x11-libs/gtk+-2.0.8
	audiofile? ( >=media-libs/audiofile-0.2.3 )
	esd? ( >=media-sound/esound-0.2.23 )
	nls? ( sys-devel/gettext )"

# cvs snapshots require automake/autoconf
if $sawfishsnapshot; then
	DEPEND="${DEPEND} sys-devel/automake sys-devel/autoconf"
fi

src_compile() {
	local myconf

	# Make sure we include freetype2 headers before freetype1 headers,
	# else Xft2 borks, <azarah@gentoo.org> (13 Dec 2002)
	export C_INCLUDE_PATH="${C_INCLUDE_PATH}:/usr/include/freetype2"
	export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include/freetype2"

	# If this is a snapshot then we need to create the autoconf stuff
	if $sawfishsnapshot; then
		aclocal || die "aclocal failed"
		autoconf || die "autoconf failed"
	fi

	if use gnome; then
		myconf="--with-gnome-prefix=/usr \
			--enable-gnome-widgets --enable-capplet"
	else
		myconf="--disable-gnome-widgets --disable-capplet"
	fi

	econf \
		--enable-themer \
		--with-gdk-pixbuf \
		$(useq nls || echo --disable-linguas) \
		$(use_with audiofile) \
		$(use_with esd) \
		${myconf} || die

	# The following two lines allow sawfish to compile with gcc 2.95
	# (see bug 18294)
	sed -i -e 's:REP_CFLAGS=:REP_CFLAGS=-I/usr/include/freetype2 :' Makedefs

	# Parallel build doesn't work
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog DOC FAQ NEWS README THANKS TODO OPTIONS

	# Add to Gnome CC's Window Manager list
	if use gnome; then
		insinto /usr/share/gnome/wm-properties
		doins ${S}/Sawfish.desktop
	fi
}
