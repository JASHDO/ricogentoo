# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kate-plugins/kate-plugins-3.5.10.ebuild,v 1.1 2008/09/13 23:57:28 carlo Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kate"
EAPI="1"
inherit kde-meta

DESCRIPTION="kate plugins and docs"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="|| ( >=kde-base/kate-${PV}:${SLOT} >=kde-base/kdebase-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"
