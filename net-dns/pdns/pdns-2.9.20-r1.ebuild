# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/pdns/pdns-2.9.20-r1.ebuild,v 1.6 2007/05/06 09:16:12 genone Exp $

inherit multilib eutils autotools

DESCRIPTION="The PowerDNS Daemon"
SRC_URI="http://downloads.powerdns.com/releases/${P}.tar.gz"
HOMEPAGE="http://www.powerdns.com/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug doc ldap mysql postgres sqlite static tdb"

DEPEND="mysql? ( virtual/mysql )
	postgres? ( >=dev-cpp/libpqpp-4.0-r1 )
	ldap? ( >=net-nds/openldap-2.0.27-r4 )
	sqlite? ( =dev-db/sqlite-2.8* )
	tdb? ( dev-libs/tdb )
	>=dev-libs/boost-1.31"

RDEPEND="${DEPEND}"

DEPEND="${DEPEND}
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/2.9.18-default-mysql-options.patch
	epatch "${FILESDIR}"/2.9.20-ldap-deprecated.patch

	eautoreconf
}

src_compile() {
	local modules="pipe geo" myconf=""

	use mysql && modules="${modules} gmysql"
	use postgres && modules="${modules} gpgsql"
	use sqlite && modules="${modules} gsqlite"
	use ldap && modules="${modules} ldap"
	use tdb && modules="${modules} xdb"
	use debug && myconf="${myconf} --enable-verbose-logging"

	econf \
		--sysconfdir=/etc/powerdns \
		--disable-recursor \
		--with-modules= \
		--with-dynmodules="${modules}" \
		--with-pgsql-includes=/usr/include \
		--with-pgsql-lib=/usr/$(get_libdir) \
		--with-mysql-lib=/usr/$(get_libdir) \
		--with-sqlite-lib=/usr/$(get_libdir) \
		$(use_enable static static-binaries) \
		${myconf} \
		|| die "econf failed"
	emake -j1 || die "emake failed"

	if use doc
	then
		emake -C codedocs codedocs || die "emake codedocs failed"
	fi
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"

	mv "${D}"/etc/powerdns/pdns.conf{-dist,}

	# set defaults: setuid=pdns, setgid=pdns
	sed -i -e 's/^# set\([ug]\)id=$/set\1id=pdns/g' \
		"${D}"/etc/powerdns/pdns.conf

	doinitd "${FILESDIR}"/pdns

	dodoc ChangeLog README TODO
	use doc && dohtml -r codedocs/html/.
}

pkg_preinst() {
	enewgroup pdns
	enewuser pdns -1 -1 /var/empty pdns
}

pkg_postinst() {
	ewarn
	ewarn "ATTENTION: The config files have moved from /etc to /etc/powerdns!"
	ewarn
	ewarn "ATTENTION: The recursor component has been split out to net-dns/pdns-recursor!"
	ewarn
	elog
	elog "pdns now provides multiple instances support. You can create more instances"
	elog "by symlinking the pdns init script to another name."
	elog
	elog "The name must be in the format pdns-<suffix> and PowerDNS will use the"
	elog "/etc/powerdns/pdns-<suffix>.conf configuration file instead of the default."
	elog
	elog "Also all backends, except the bind and random backends, are now compiled as"
	elog "loadable modules and must be loaded with load-modules= in the configuration"
	elog "file."
	elog
}
