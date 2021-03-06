# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klaptopdaemon/klaptopdaemon-3.5.5.ebuild,v 1.12 2007/07/22 10:40:26 omp Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdeutils-3.5-patchset-01.tar.bz2"

DESCRIPTION="KLaptopdaemon - KDE battery monitoring and management for laptops."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RESTRICT="strip"

RDEPEND="x11-libs/libXtst"

DEPEND="${RDEPEND}
	x11-libs/libX11
	x11-proto/xproto
	virtual/os-headers"
