# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/skrooge/skrooge-1.1.1.ebuild,v 1.2 2012/01/18 14:46:30 johu Exp $

EAPI=4
KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB eo es et fr ga gl hu it ja lt nb
nl pl pt pt_BR ro ru sk sv tr ug zh_CN"
KDE_DOC_DIRS="doc"
KDE_HANDBOOK=optional
inherit kde4-base

DESCRIPTION="personal finances manager for KDE4, aiming at being simple and intuitive"
HOMEPAGE="http://www.skrooge.org/"
SRC_URI="http://www.skrooge.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	app-crypt/qca:2
	dev-libs/grantlee
	>=dev-libs/libofx-0.9.1
	x11-libs/qt-sql:4[sqlite]
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdesdk-scripts)
"

DOCS="AUTHORS CHANGELOG README TODO"

src_test() { :; }
# tests are not included in tarball, bug 372315
