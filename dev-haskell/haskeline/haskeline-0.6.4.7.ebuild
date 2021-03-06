# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haskeline/haskeline-0.6.4.7.ebuild,v 1.3 2012/10/23 10:51:57 slyfox Exp $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit base haskell-cabal

DESCRIPTION="A command-line interface for user input, written in Haskell."
HOMEPAGE="http://trac.haskell.org/haskeline"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-haskell/mtl-1.1[profile?]
		<dev-haskell/mtl-2.2[profile?]
		>=dev-haskell/terminfo-0.3.1.3[profile?]
		<dev-haskell/terminfo-0.4[profile?]
		>=dev-haskell/utf8-string-0.3.6[profile?]
		<dev-haskell/utf8-string-0.4[profile?]
		>=dev-lang/ghc-6.10.4"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

PATCHES=("${FILESDIR}/${PN}-0.6.4.7-ghc-7.5.patch"
	"${FILESDIR}/${PN}-0.6.4.7-ghc-7.6.patch"
	"${FILESDIR}/${PN}-0.6.4.7-ghc-6.12.patch"
	)
