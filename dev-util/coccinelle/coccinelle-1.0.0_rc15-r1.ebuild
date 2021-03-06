# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/coccinelle/coccinelle-1.0.0_rc15-r1.ebuild,v 1.1 2012/08/31 21:28:13 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="python? 2"

inherit multilib eutils python bash-completion-r1 elisp-common autotools

MY_P="${P/_/-}"
DESCRIPTION="Program matching and transformation engine"
HOMEPAGE="http://coccinelle.lip6.fr/"
SRC_URI="http://coccinelle.lip6.fr/distrib/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc emacs ocaml +ocamlopt pcre python test vim-syntax"

# ocaml enables ocaml scripting (uses findlib)
CDEPEND=">=dev-lang/ocaml-3.10[ocamlopt?]
	dev-ml/sexplib
	emacs? ( virtual/emacs )
	ocaml? ( dev-ml/findlib )
	pcre? ( dev-ml/pcre-ocaml )"

RDEPEND="${CDEPEND}
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )"

# dev-texlive/texlive-fontsextra contains 'ifsym.sty'
DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? (
		virtual/latex-base
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-fontsextra
	)"

REQUIRED_USE="test? ( ocaml python )"

DOCS=( authors.txt bugs.txt changes.txt credits.txt readme.txt )

S=${WORKDIR}/${MY_P}

SITEFILE=50coccinelle-gentoo.el

pkg_setup() {
	if use python ; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	if use python ; then
		# Fix python install location
		sed -i -e "s:\$(SHAREDIR)/python:$(python_get_sitedir):" \
			-e "s:PYTHON_TARGET:PYTHON_INSTALL_TARGET:" Makefile || die
	fi

	sed -i "s:^SHAREDIR=.*:SHAREDIR=/usr/$(get_libdir)/ocaml/${PN}/:" scripts/spatch.sh.in || die

	epatch "${FILESDIR}"/${PN}-1.0.0_rc14-findtool.patch
	cp Makefile Makefile.orig || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable python) \
		$(use_enable ocaml) \
		$(use_enable pcre) \
		$(use_enable pcre pcre-syntax)

	sed -i -e "s:^LIBDIR=.*:LIBDIR=/usr/$(get_libdir)/ocaml/stublibs/:" \
		-e "s:^SHAREDIR=.*:SHAREDIR=/usr/$(get_libdir)/ocaml/${PN}/:" \
		Makefile.config || die

	cp Makefile.orig Makefile || die
}

src_compile() {
	emake depend
	emake

	use ocamlopt && emake opt

	if use doc ; then
		VARTEXFONTS="${T}"/fonts emake docs
	fi

	if use emacs ; then
		elisp-compile editors/emacs/cocci.el || die
	fi
}

src_test() {
	source env.sh # needed for built in-place python plugin
	./spatch standard.h -parse_c -dir tests/ || die
	yes | ./spatch -iso_file standard.iso -macro_file_builtins standard.h -testall || die
	if use ocamlopt ; then
		./spatch.opt -iso_file standard.iso -macro_file_builtins standard.h -testall ||	die
	fi
}

src_install() {
	default

	use doc && dodoc docs/manual/*.pdf
	newbashcomp scripts/spatch.bash_completion spatch

	if use emacs ; then
		elisp-install ${PN} editors/emacs/*
		elisp-site-file-install "${FILESDIR}"/${SITEFILE}
	fi

	if use vim-syntax ; then
		newdoc editors/vim/README README-vim
		rm editors/vim/README || die
		insinto /usr/share/vim/vimfiles
		doins -r editors/vim/*
	fi

	export STRIP_MASK='*/coccinelle/spatch'
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
