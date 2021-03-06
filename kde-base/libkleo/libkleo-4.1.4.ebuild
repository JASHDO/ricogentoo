# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkleo/libkleo-4.1.4.ebuild,v 1.1 2009/01/13 23:17:17 alexxy Exp $

EAPI="2"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="KDE library for encryption handling."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="app-crypt/gnupg
	>=kde-base/kdepimlibs-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

src_configure() {
	mycmakeargs="${mycmakeargs} -DWITH_QGPGME=ON"

	kde4-meta_src_configure
}
