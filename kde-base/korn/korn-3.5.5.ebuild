# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/korn/korn-3.5.5.ebuild,v 1.9 2007/04/09 14:21:52 carlo Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mailbox checker"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange 3.5.4 $MAXKDEVER kde-base/mimelib)
	$(deprange 3.5.3 $MAXKDEVER kde-base/libkmime)"

RDEPEND="${DEPEND}
	$(deprange-dual $PV $MAXKDEVER kde-base/kdebase-kioslaves)
	$(deprange $PV $MAXKDEVER kde-base/kdepim-kioslaves)"
KMCOPYLIB="libmimelib mimelib
	libkmime libkmime"
# libkcal is installed because a lot of headers are needed, but it don't have to be compiled
KMEXTRACTONLY="
	mimelib/
	libkmime/
	libkdenetwork/"
