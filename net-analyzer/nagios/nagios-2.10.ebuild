# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios/nagios-2.10.ebuild,v 1.3 2008/01/13 19:43:23 ranger Exp $

DESCRIPTION="The Nagios metapackage - merge this to pull install all of the
nagios packages"
HOMEPAGE="http://www.nagios.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="~net-analyzer/nagios-core-${PV}
	>=net-analyzer/nagios-plugins-1.4
	>=net-analyzer/nagios-nrpe-1.8
	>=net-analyzer/nagios-nsca-2.3
	>=net-analyzer/nagios-imagepack-1.0"

pkg_postrm() {
	elog "Note: this is a META ebuild for ${P}."
	elog "to remove it completely or before re-emerging"
	elog "either use 'depclean', or remove/re-emerge these packages:"
	elog
	for dep in ${RDEPEND}; do
		elog "     ${dep}"
	done
	echo
}
