# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Time-HiRes/Time-HiRes-1.97.04.ebuild,v 1.1 2007/01/02 15:38:10 mcummings Exp $

inherit perl-module versionator

MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl Time::HiRes. High resolution alarm, sleep, gettimeofday, interval timers"
HOMEPAGE="http://search.cpan.org/~jhi"
SRC_URI="mirror://cpan/authors/id/J/JH/JHI/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

mydoc="TODO"

SRC_TEST="do"
