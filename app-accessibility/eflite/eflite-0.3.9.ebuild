# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/eflite/eflite-0.3.9.ebuild,v 1.4 2007/12/26 22:13:14 phreak Exp $

IUSE=""

inherit eutils

DESCRIPTION="A speech server for emacspeek and other screen readers that allows them to interact with festival lite."
HOMEPAGE="http://eflite.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

RDEPEND=">=app-accessibility/flite-1.2"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:/etc/es.conf:/etc/eflite/es.conf:g' *
	econf || die "configuration failed"
}

src_compile() {
	emake || die "compile failed"
}

src_install() {
	einstall || die
	dodoc ChangeLog README INSTALL eflite_test.txt

	insinto /etc/eflite
	doins "${FILESDIR}"/es.conf

	newinitd "${FILESDIR}"/eflite.rc eflite
}

pkg_postinst() {
	enewgroup speech
	elog "To test eflite, you can run:"
	elog "gzcat /usr/share/doc/${PF}/eflite_test.txt.gz | eflite"
}
