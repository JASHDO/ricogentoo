# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-http/pecl-http-1.7.0.ebuild,v 1.1 2010/11/04 13:41:07 mabi Exp $

PHP_EXT_NAME="http"
PHP_EXT_PECL_PKG="pecl_http"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="docs/examples/tutorial.txt ThanksTo.txt KnownIssues.txt"

EAPI="2"

inherit php-ext-pecl-r1 php-ext-base-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Extended HTTP Support for PHP."
LICENSE="BSD-2 MIT"
SLOT="0"
IUSE=""

DEPEND=">=net-misc/curl-7.19.4
	sys-libs/zlib
	dev-libs/libevent
	|| ( <dev-lang/php-5.3[spl] >=dev-lang/php-5.3 )
	>=dev-lang/php-5[hash,session,iconv]
	"
RDEPEND="${DEPEND}"

src_compile() {
	my_conf="--enable-http \
			--with-http-curl-requests \
			--with-http-zlib-compression \
			--with-http-curl-libevent \
			--with-http-magic-mime"

	php-ext-pecl-r1_src_compile
}

src_install() {
	php-ext-pecl-r1_src_install

	php-ext-base-r1_addtoinifiles "http.etag.mode" "MD5"
	php-ext-base-r1_addtoinifiles "http.force_exit" "1"
	php-ext-base-r1_addtoinifiles "http.log.allowed_methods" ""
	php-ext-base-r1_addtoinifiles "http.log.cache" ""
	php-ext-base-r1_addtoinifiles "http.log.composite" ""
	php-ext-base-r1_addtoinifiles "http.log.not_found" ""
	php-ext-base-r1_addtoinifiles "http.log.redirect" ""
	php-ext-base-r1_addtoinifiles "http.only_exceptions" "0"
	php-ext-base-r1_addtoinifiles "http.persistent.handles.ident" "GLOBAL"
	php-ext-base-r1_addtoinifiles "http.persistent.handles.limit" "-1"
	php-ext-base-r1_addtoinifiles "http.request.datashare.connect" "0"
	php-ext-base-r1_addtoinifiles "http.request.datashare.cookie" "0"
	php-ext-base-r1_addtoinifiles "http.request.datashare.dns" "1"
	php-ext-base-r1_addtoinifiles "http.request.datashare.ssl" "0"
	php-ext-base-r1_addtoinifiles "http.request.methods.allowed" ""
	php-ext-base-r1_addtoinifiles "http.request.methods.custom" ""
	php-ext-base-r1_addtoinifiles "http.send.inflate.start_auto" "0"
	php-ext-base-r1_addtoinifiles "http.send.inflate.start_flags" "0"
	php-ext-base-r1_addtoinifiles "http.send.deflate.start_auto" "0"
	php-ext-base-r1_addtoinifiles "http.send.deflate.start_flags" "0"
	php-ext-base-r1_addtoinifiles "http.send.not_found_404" "1"
}
