# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-3.5.10.ebuild,v 1.2 2008/09/14 04:24:57 mr_bones_ Exp $

KMNAME=kdepim

EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5-patchset-05.tar.bz2"

DESCRIPTION="KDE news feed aggregator."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/kontact-${PV}:${SLOT}
	!net-www/akregator"
RDEPEND="${DEPEND}"

KMCOPYLIB="libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="libkdepim
	kontact/interfaces"
KMEXTRA="kontact/plugins/akregator"
