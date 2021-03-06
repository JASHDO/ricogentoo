# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/kramdown/kramdown-0.13.4.ebuild,v 1.1 2011/12/18 13:57:18 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18 jruby"

RAKE_FAKEGEM_DOCDIR="htmldoc/rdoc"
RUBY_FAKEGEM_EXTRADOC="README ChangeLog"

inherit ruby-fakegem

DESCRIPTION="yet-another-markdown-parser but fast, pure Ruby, using a strict syntax definition."
HOMEPAGE="http://kramdown.rubyforge.org/"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/rdoc )
	test? ( >=dev-ruby/coderay-1.0.0 )"

all_ruby_prepare() {
	# Remove metadata since it confused jruby.
	rm ../metadata || die
}

all_ruby_compile() {
	if use doc; then
		rdoc-2 -o htmldoc/rdoc --main README --title kramdown lib README || die "Unable to generate documentation"
	fi
}

all_ruby_install() {
	all_fakegem_install

	doman man/man1/kramdown.1
}
