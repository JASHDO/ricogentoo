# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ohai/ohai-0.6.10.ebuild,v 1.1 2012/01/15 14:36:40 graaff Exp $

EAPI=4
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Ohai profiles your system and emits JSON"
HOMEPAGE="http://wiki.opscode.com/display/chef/Ohai"
SRC_URI="https://github.com/opscode/${PN}/tarball/${PV} -> ${P}.tgz"
RUBY_S="opscode-${PN}-*"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:2 dev-ruby/sigar )"

ruby_add_rdepend "
	dev-ruby/yajl-ruby
	dev-ruby/mixlib-cli
	dev-ruby/mixlib-config
	dev-ruby/mixlib-log
	>=dev-ruby/systemu-2.2.0"

all_ruby_prepare() {
	rm Gemfile || die
	# Be more lenient to work with versions of systemu that we have in
	# the tree.
	sed -i -e 's/~> 2.2.0/>= 2.2.0/' ohai.gemspec || die
}

all_ruby_install() {
	all_fakegem_install

	doman docs/man/man1/ohai.1
}
