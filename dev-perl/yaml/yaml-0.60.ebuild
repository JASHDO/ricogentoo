# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/yaml/yaml-0.60.ebuild,v 1.5 2007/07/10 23:33:30 mr_bones_ Exp $

inherit perl-module

MY_P="YAML-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="YAML Ain't Markup Language (tm)"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/I/IN/INGY/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
SRC_TEST="do"

src_compile() {
	echo "" | perl-module_src_compile
}

DEPEND="dev-lang/perl"
