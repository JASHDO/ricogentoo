# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Build/Module-Build-0.30.ebuild,v 1.2 2008/11/04 10:00:44 vapier Exp $

inherit versionator
MODULE_AUTHOR=KWILLIAMS
MY_PN=Module-Build
MY_P=${MY_PN}-$(delete_version_separator 2)
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Build and install Perl modules"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

# Removing these as hard deps. They are listed as recommended in the Build.PL,
# but end up causing a dep loop since they require module-build to be built.
# ~mcummings 06.16.06
PDEPEND=">=virtual/perl-ExtUtils-CBuilder-0.15
	>=virtual/perl-ExtUtils-ParseXS-1.02"

DEPEND="dev-lang/perl
	dev-perl/yaml
	>=virtual/perl-Archive-Tar-1.09"

SRC_TEST="do"

src_test(){
	HOME= perl-module_src_test
}
