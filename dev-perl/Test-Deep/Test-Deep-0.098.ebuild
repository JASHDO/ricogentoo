# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Deep/Test-Deep-0.098.ebuild,v 1.4 2008/01/13 21:48:02 dertobi123 Exp $

inherit perl-module
IUSE=""

DESCRIPTION="Test::Deep - Extremely flexible deep comparison"
SRC_URI="mirror://cpan/authors/id/F/FD/FDALY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~fdaly/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

SRC_TEST="do"
DEPEND="dev-perl/Test-NoWarnings
	dev-perl/Test-Tester
	dev-lang/perl"
