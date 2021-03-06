# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Load-Conditional/Module-Load-Conditional-0.30.ebuild,v 1.2 2009/01/20 13:57:08 tove Exp $

MODULE_AUTHOR="KANE"
inherit perl-module

DESCRIPTION="Looking up module information / loading at runtime"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/perl-Module-Load-0.12
	virtual/perl-Locale-Maketext-Simple
	virtual/perl-Params-Check
	virtual/perl-version"
RDEPEND="${DEPEND}"
