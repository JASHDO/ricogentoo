# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kttsd/kttsd-3.5.8.ebuild,v 1.1 2007/10/19 23:40:40 philantrop Exp $
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE text-to-speech subsystem"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="akode alsa"
DEPEND="akode? ( media-libs/akode )
	alsa? ( media-libs/alsa-lib )
	$(deprange-dual $PV $MAXKDEVER kde-base/kcontrol)
	!arts? ( !alsa? ( media-libs/akode ) )"

RDEPEND="${DEPEND}
	|| ( app-accessibility/festival
		app-accessibility/epos
		app-accessibility/flite
		app-accessibility/freetts )"

pkg_setup() {
	kde_pkg_setup
	if ! use arts && ! use alsa && ! use akode ; then
		ewarn "No audio backend chosen. Defaulting to media-libs/akode."
	fi
}

src_unpack() {
	kde-meta_src_unpack

	sed -i -e "s:^MimeTypes=::" "${S}/kttsd/kttsmgr/kttsmgr.desktop" \
		|| die "sed to fix the desktop file failed"
}

src_compile() {
	local myconf="$(use_with alsa) --without-gstreamer"

	if ! use arts && ! use alsa ; then
		myconf="${myconf} --with-akokde"
	else
		myconf="${myconf} $(use_with akode)"
	fi

	kde-meta_src_compile
}
