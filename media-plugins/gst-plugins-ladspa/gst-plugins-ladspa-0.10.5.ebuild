# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ladspa/gst-plugins-ladspa-0.10.5.ebuild,v 1.3 2007/12/30 12:20:51 jokey Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 x86"

DEPEND=">=media-libs/ladspa-sdk-1.12-r2
	>=media-libs/gst-plugins-base-0.10.13
	>=media-libs/gstreamer-0.10.13"

RDEPEND="${DEPEND}"
