# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/galicesms/galicesms-1.61.ebuild,v 1.1 2007/08/18 07:01:32 mrness Exp $

DESCRIPTION="GTK2 GUI interface for sending SMS messages via Rosso Alice (Italian ADSL service)"
HOMEPAGE="http://www.marzocca.net/linux/galicesms.html"
SRC_URI="http://www.marzocca.net/linux/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/gtk2-perl
	dev-perl/libwww-perl
	dev-perl/URI"

S="${WORKDIR}"

src_install() {
	dobin "${PN}"
}
