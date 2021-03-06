# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ghamachi/ghamachi-0.8.1.ebuild,v 1.5 2008/01/25 19:11:49 caleb Exp $

inherit eutils

DESCRIPTION="gHamachi is a GUI for the Hamachi tunneling software package."
HOMEPAGE="http://www.penguinbyte.com/software/ghamachi/"
LICENSE="as-is"
SRC_URI="http://purebasic.myftp.org/files/3/projects/hamachi/v.${PV}/gHamachi_${PV}.tar.gz"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="strip mirror"
RDEPEND="net-misc/hamachi
	=x11-libs/gtk+-2*"

src_unpack() {
	unpack gHamachi_${PV}.tar.gz
	mv "${WORKDIR}"/README "${WORKDIR}"/README.gHamachi
}

src_install() {
	einfo "Installing GUI"
	insinto /usr/bin
	insopts -m0755
	doins "${WORKDIR}"/ghamachi
	dodoc "${WORKDIR}"/README.gHamachi
}
