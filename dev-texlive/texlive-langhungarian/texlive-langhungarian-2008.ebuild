# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langhungarian/texlive-langhungarian-2008.ebuild,v 1.11 2009/06/10 14:13:10 alexxy Exp $

TEXLIVE_MODULE_CONTENTS="magyar hyphen-hungarian collection-langhungarian
"
TEXLIVE_MODULE_DOC_CONTENTS="magyar.doc hyphen-hungarian.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Hungarian"

LICENSE="GPL-2 LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2008
"
RDEPEND="${DEPEND}"
