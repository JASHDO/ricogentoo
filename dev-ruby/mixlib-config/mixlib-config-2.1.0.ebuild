# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mixlib-config/mixlib-config-2.1.0.ebuild,v 1.2 2014/10/11 05:27:04 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST="none"

RUBY_FAKEGEM_EXTRADOC="NOTICE README.md"

inherit ruby-fakegem

DESCRIPTION="Simple class based Config mechanism"
HOMEPAGE="http://github.com/opscode/mixlib-config"
SRC_URI="https://github.com/opscode/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="test"

ruby_add_bdepend "test? (
	dev-ruby/rspec:2
	dev-util/cucumber
)"

each_ruby_test() {
	ruby-ng_rspec
	ruby-ng_cucumber
}
