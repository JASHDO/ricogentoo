# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Set-IntSpan/Set-IntSpan-1.11.ebuild,v 1.5 2007/07/13 17:45:05 armin76 Exp $

inherit perl-module

DESCRIPTION="Manages sets of integers"
SRC_URI="mirror://cpan/authors/id/S/SW/SWMCD/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~swmcd/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ia64 ~ppc sparc x86"
SRC_TEST="do"

DEPEND="dev-lang/perl"
