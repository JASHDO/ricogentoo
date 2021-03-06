# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-activeldap/ruby-activeldap-0.8.3.1.ebuild,v 1.1 2007/11/07 10:40:55 graaff Exp $

inherit ruby gems

DESCRIPTION="Ruby/ActiveLDAP provides an activerecord inspired object oriented interface to LDAP"
HOMEPAGE="http://raa.ruby-lang.org/project/ruby-activeldap/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"

DEPEND=">=dev-lang/ruby-1.8
	>=dev-ruby/ruby-ldap-0.8.2
	>=dev-ruby/log4r-1.0.4
	dev-ruby/activerecord
	>=dev-ruby/hoe-1.2.0"
