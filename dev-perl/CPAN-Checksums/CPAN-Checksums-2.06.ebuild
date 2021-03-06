# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Checksums/CPAN-Checksums-2.06.ebuild,v 1.1 2010/10/29 02:04:32 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=ANDK
inherit perl-module

DESCRIPTION="Write a CHECKSUMS file for a directory as on CPAN"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE="test"

RDEPEND="virtual/perl-IO-Compress
	dev-perl/Compress-Bzip2
	dev-perl/Data-Compare
	virtual/perl-Digest-SHA
	virtual/perl-Digest-MD5
	virtual/perl-File-Temp
	virtual/perl-IO"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"

src_test() {
	# online test
	mv "${S}"/t/00signature.t{,.disable} || die
	perl-module_src_test
}
