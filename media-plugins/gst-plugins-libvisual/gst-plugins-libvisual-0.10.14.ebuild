# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libvisual/gst-plugins-libvisual-0.10.14.ebuild,v 1.6 2007/11/01 14:03:57 armin76 Exp $

inherit gst-plugins-base

KEYWORDS="amd64 ppc ppc64 sparc x86"

IUSE=""
RDEPEND=">=media-libs/gst-plugins-base-0.10.13.1
	 >=media-libs/libvisual-0.4"

DEPEND="${RDEPEND}"
