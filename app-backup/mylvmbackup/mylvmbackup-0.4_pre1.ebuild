# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/mylvmbackup/mylvmbackup-0.4_pre1.ebuild,v 1.4 2008/03/15 00:55:32 robbat2 Exp $

inherit eutils

DESCRIPTION="mylvmbackup is a Perl script for quickly creating backups of MySQL server's data files utilizing LVM snapshots."
HOMEPAGE="http://lenz.homelinux.org/mylvmbackup/"
MY_PV=0.3
SRC_URI="http://lenz.homelinux.org/${PN}/${PN}-${MY_PV}.tar.gz
		mirror://gentoo/${PN}-0.3-to-0.4-changes.patch.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND=">=app-text/asciidoc-8.1.0"
RDEPEND="dev-perl/Config-IniFiles
		>=sys-fs/lvm2-2.02.06
		dev-perl/DBD-mysql
		virtual/mysql"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${PN}-${MY_PV}.tar.gz
	epatch "${DISTDIR}"/${PN}-0.3-to-0.4-changes.patch.gz
	sed -i \
		-e '/^VERSION/s,0.4,0.4_pre1,' \
		-e '/^prefix/s,/usr/local,/usr,' \
		"${S}"/Makefile
	# Clean up one thinko
	sed -i \
		-e '/^my$/d' \
		"${S}"/mylvmbackup.pl.in
}

src_install() {
	emake -j1 install DESTDIR="${D}"
	dodoc ChangeLog README TODO
	keepdir /var/tmp/${PN}/{backup,mnt}
}
