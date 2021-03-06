# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-sidplay/gst-plugins-sidplay-0.10.10.ebuild,v 1.1 2008/12/05 22:10:11 ssuominen Exp $

inherit gst-plugins-ugly

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="=media-libs/libsidplay-1.3*
	 >=media-libs/gstreamer-0.10.21
	 >=media-libs/gst-plugins-base-0.10.21"
