# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bwwhois/bwwhois-5.5.2.ebuild,v 1.3 2012/10/31 12:01:15 pinkbyte Exp $

EAPI=4

inherit perl-app

MY_P=${P/bw/}

DESCRIPTION="Perl-based whois client designed to work with the new Shared Registration System"
SRC_URI="http://whois.bw.org/dist/${MY_P}.tgz"
HOMEPAGE="http://whois.bw.org/"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	virtual/perl-Getopt-Long"

S=${WORKDIR}/${MY_P}

src_install() {
	exeinto usr/bin
	newexe whois bwwhois

	newman whois.1 bwwhois.1

	insinto /etc/whois
	doins whois.conf tld.conf sd.conf

	perlinfo
	insinto "${VENDOR_LIB}"
	doins bwInclude.pm
}
