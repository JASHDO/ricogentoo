# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haddock/haddock-2.4.2.ebuild,v 1.11 2012/09/14 07:03:20 qnikst Exp $

CABAL_FEATURES="bin lib"
# don't enable profiling as the 'ghc' package is not built with profiling
inherit haskell-cabal autotools pax-utils

GHCPATHS_PN="ghc-paths"
GHCPATHS_PV="0.1.0.5"
GHCPATHS_P="${GHCPATHS_PN}-${GHCPATHS_PV}"

DESCRIPTION="A documentation-generation tool for Haskell libraries"
HOMEPAGE="http://www.haskell.org/haddock/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz
	mirror://hackage/packages/archive/${GHCPATHS_PN}/${GHCPATHS_PV}/${GHCPATHS_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

# haddock-2.4.2 also deps on the upgradeable package dev-haskell/filepath.
# however, it's included in >=ghc-6.10, so we use the core package without
# stating the dependency in DEPEND.

# we bundle the dep on ghc-paths to reduce the dependencies on this critical
# package. ghc-paths would like to be compiled with USE=doc, which pulls in
# haddock, which requires ghc-paths, which pulls in haddock...

# doesn't build with ghc-6.10.1, but that has never been in portage
RDEPEND="=dev-lang/ghc-6.10*"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6
		doc? (  ~app-text/docbook-xml-dtd-4.2
				app-text/docbook-xsl-stylesheets
				>=dev-libs/libxslt-1.1.2 )"

src_unpack() {
	unpack ${A}

	# use ghc-paths directly, not as a library
	sed -e "s|build-depends: ghc-paths|hs-source-dirs: ../${GHCPATHS_P}|" \
		-e "s|Simple|Custom|" \
		-i "${S}/${PN}.cabal"

	# ghc-paths has a custom Setup.hs, haddock has the default Setup.lhs.
	# we use a somewhat modified ghc-paths Setup.hs that works better for our
	# purposes.
	rm "${S}/Setup.lhs"
	cp "${FILESDIR}/${P}-Setup.hs" "${S}/Setup.hs"

	if use doc; then
	  cd "${S}/doc"
	  eautoreconf
	fi

}

src_compile () {
	cabal_src_compile
	if use doc; then
		cd "${S}/doc"
		./configure --prefix="${D}/usr/" \
			|| die 'error configuring documentation.'
		emake html || die 'error building documentation.'
	fi
}

src_install () {
	cabal_src_install
	# haddock uses GHC-api to process TH source.
	# TH requires GHCi which needs mmap('rwx') (bug #299709)
	pax-mark -m "${D}/usr/bin/${PN}"

	if use doc; then
		dohtml -r "${S}/doc/haddock/"*
	fi
	dodoc CHANGES README
}
