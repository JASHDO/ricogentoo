# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-apps/plasma-apps-4.1.4.ebuild,v 1.1 2009/01/13 23:29:50 alexxy Exp $

EAPI="2"

KMNAME=kdebase
KMMODULE=apps/plasma
inherit kde4-meta

DESCRIPTION="Additional Applets for Plasma"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="!kde-base/plasma:${SLOT}
	kde-base/libplasma:${SLOT}
	kde-base/libkonq:${SLOT}"
