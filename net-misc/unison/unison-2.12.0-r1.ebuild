# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/unison/unison-2.12.0-r1.ebuild,v 1.2 2005/09/21 21:35:41 mattam Exp $

inherit eutils

IUSE="gtk static debug threads"

DESCRIPTION="Two-way cross-platform file synchronizer"
HOMEPAGE="http://www.cis.upenn.edu/~bcpierce/unison/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 sparc"

DEPEND=">=dev-lang/ocaml-3.04
	gtk? ( >=dev-ml/lablgtk-2.2 )"

RDEPEND="gtk? ( >=dev-ml/lablgtk-2.2
|| ( net-misc/x11-ssh-askpass net-misc/gtk2-ssh-askpass ) )"

SRC_URI="mirror://gentoo/${P}.tar.gz"

src_unpack() {
	unpack ${P}.tar.gz

	# Fix for coreutils change of tail syntax
	cd ${S}
	sed -i -e 's/tail -1/tail -n 1/' Makefile.OCaml
	# Fix for bad button behavior
	epatch ${FILESDIR}/unison-2.12.0-gtk2-bug.patch
}

src_compile() {
	local myconf

	if use threads; then
		myconf="$myconf THREADS=true"
	fi

	if use static; then
		myconf="$myconf STATIC=true"
	fi

	if use debug; then
		myconf="$myconf DEBUGGING=true"
	fi

	if use gtk; then
		myconf="$myconf UISTYLE=gtk2"
	else
		myconf="$myconf UISTYLE=text"
	fi

	make $myconf CFLAGS="" || die "error making unsion"
}

src_install () {
	# install manually, since it's just too much
	# work to force the Makefile to do the right thing.
	dobin unison || die
	dodoc BUGS.txt CONTRIB COPYING INSTALL NEWS \
	      README ROADMAP.txt TODO.txt || die
}
