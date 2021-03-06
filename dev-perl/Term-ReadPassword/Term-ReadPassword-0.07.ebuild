# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ReadPassword/Term-ReadPassword-0.07.ebuild,v 1.6 2007/09/17 07:04:21 opfer Exp $

inherit perl-module

DESCRIPTION="Term::ReadPassword - Asking the user for a password"
SRC_URI="mirror://cpan/authors/id/P/PH/PHOENIX/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/P/PH/PHOENIX/Term-ReadPassword-0.06.readme"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 x86"

# Tests are interactive
#SRC_TEST="do"

DEPEND="dev-lang/perl"
