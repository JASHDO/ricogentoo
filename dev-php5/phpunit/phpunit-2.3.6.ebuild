# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phpunit/phpunit-2.3.6.ebuild,v 1.2 2007/03/18 02:27:55 chtekk Exp $

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~sparc ~x86"

DESCRIPTION="Unit Testing framework for PHP 5."
HOMEPAGE="http://www.phpunit.de/"
SRC_URI="http://pear.phpunit.de/get/PHPUnit-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="!dev-php4/phpunit"
RDEPEND="${DEPEND}
		>=dev-php5/xdebug-2.0.0_rc2
		>=dev-php/PEAR-Benchmark-1.2.2-r1
		>=dev-php/PEAR-Log-1.8.7-r1"

S="${WORKDIR}/PHPUnit-${PV}"

need_php_by_category

pkg_setup() {
	has_php
	require_php_with_use pcre reflection spl xml
}
