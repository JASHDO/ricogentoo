# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kjsembed/kjsembed-3.5.10.ebuild,v 1.1 2008/09/13 23:58:48 carlo Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE javascript parser and embedder"
HOMEPAGE="http://xmelegance.org/kjsembed/"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="|| ( >=kde-base/kwin-${PV}:${SLOT} >=kde-base/kdebase-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"

PATCHES="$FILESDIR/no-gtk-glib-check.diff"
