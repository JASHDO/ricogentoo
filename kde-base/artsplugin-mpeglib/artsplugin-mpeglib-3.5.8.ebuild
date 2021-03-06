# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-mpeglib/artsplugin-mpeglib-3.5.8.ebuild,v 1.1 2007/10/19 21:47:40 philantrop Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=mpeglib_artsplug
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="mpeglib plugin for arts"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
DEPEND="$(deprange 3.5.6 $MAXKDEVER kde-base/mpeglib)"

KMCOPYLIB="libmpeg mpeglib/lib/"
KMEXTRACTONLY="mpeglib/"
