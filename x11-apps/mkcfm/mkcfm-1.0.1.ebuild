# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/mkcfm/mkcfm-1.0.1.ebuild,v 1.4 2006/10/10 23:55:18 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="create summaries of font metric files in CID font directories"
KEYWORDS="~ppc64 ~x86 ~ppc"
# >=x11-libs/libXfont-0.99.3-r1 for always-on cid support
RDEPEND=">=x11-libs/libXfont-0.99.3-r1
	x11-libs/libX11
	x11-libs/libFS"
DEPEND="${RDEPEND}
	x11-proto/fontsproto"
