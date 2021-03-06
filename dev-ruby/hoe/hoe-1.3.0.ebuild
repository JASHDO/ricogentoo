# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hoe/hoe-1.3.0.ebuild,v 1.1 2007/08/15 06:26:51 graaff Exp $

inherit ruby gems

DESCRIPTION="Hoe extends rake to provide full project automation."
HOMEPAGE="http://seattlerb.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-lang/ruby-1.8.4
	>=dev-ruby/rake-0.7.3
	>=dev-ruby/rubyforge-0.4.4"
