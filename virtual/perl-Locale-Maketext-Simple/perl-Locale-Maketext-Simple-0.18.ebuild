# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Locale-Maketext-Simple/perl-Locale-Maketext-Simple-0.18.ebuild,v 1.2 2008/11/03 16:45:52 mr_bones_ Exp $

DESCRIPTION="Locale::Maketext::Simple - Simple interface to Locale::Maketext::Lexicon"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"

IUSE=""
DEPEND=""

RDEPEND="|| ( ~dev-lang/perl-5.10.0 ~perl-core/Locale-Maketext-Simple-${PV} )"
