# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/leechcraft-lmp/leechcraft-lmp-9999.ebuild,v 1.2 2011/12/16 18:37:57 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft Media Player, Phonon-based audio/video player."

SLOT="0"
KEYWORDS=""
IUSE="debug kde"

DEPEND="~net-misc/leechcraft-core-${PV}
		kde? ( media-libs/phonon )
		!kde? ( x11-libs/qt-phonon )"
RDEPEND="${DEPEND}"
