# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmenuedit/kmenuedit-4.0.0.ebuild,v 1.1 2008/01/17 23:26:45 ingmar Exp $

EAPI="1"

KMNAME=kdebase-workspace
inherit kde4-meta

DESCRIPTION="KDE menu editor"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

KMEXTRACTONLY="menu"
