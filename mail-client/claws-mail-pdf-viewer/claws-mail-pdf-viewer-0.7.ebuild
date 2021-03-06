# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-pdf-viewer/claws-mail-pdf-viewer-0.7.ebuild,v 1.1 2007/11/29 22:56:38 ticho Exp $

MY_P="${P#claws-mail-}"
MY_P="${MY_P/-/_}"

DESCRIPTION=" Enables viewing of PDF and PostScript attachments using the Poppler lib and GhostScript"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=">=mail-client/claws-mail-3.1.0
		app-text/poppler-bindings"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f "${D}"/usr/lib*/claws-mail/plugins/*.{a,la}
}
