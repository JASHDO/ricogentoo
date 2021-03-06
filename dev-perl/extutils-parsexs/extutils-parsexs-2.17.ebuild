# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-parsexs/extutils-parsexs-2.17.ebuild,v 1.6 2007/04/16 06:48:46 corsair Exp $

inherit perl-module

MY_P=ExtUtils-ParseXS-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Converts Perl XS code into C code"
HOMEPAGE="http://search.cpan.org/~kwilliams/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ia64 m68k ~mips ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-perl/ExtUtils-CBuilder
	dev-perl/module-build
	dev-lang/perl"

SRC_TEST="do"
