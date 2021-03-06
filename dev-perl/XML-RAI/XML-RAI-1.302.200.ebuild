# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RAI/XML-RAI-1.302.200.ebuild,v 1.2 2011/12/18 16:15:16 armin76 Exp $

EAPI=3

MODULE_AUTHOR=TIMA
MODULE_VERSION=1.3022
inherit perl-module

DESCRIPTION="RSS Abstraction Interface."

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

#SRC_TEST="do"

DEPEND=">=dev-perl/TimeDate-1.16
	dev-perl/XML-Elemental
		>=dev-perl/XML-RSS-Parser-4
		dev-perl/Class-XPath
	dev-lang/perl"
