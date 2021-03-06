# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmahjongg/kmahjongg-4.1.4.ebuild,v 1.1 2009/01/13 22:16:32 alexxy Exp $

EAPI="2"
KMNAME=kdegames
inherit kde4-meta

DESCRIPTION="Mahjongg for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"
DEPEND="${DEPEND}
		>=kde-base/libkmahjongg-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdegames libkmahjongg"
