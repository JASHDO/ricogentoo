# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-screen-cyrillic/font-screen-cyrillic-1.0.1.ebuild,v 1.10 2008/03/24 13:52:02 maekke Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Screen cyrillic fonts"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf"
