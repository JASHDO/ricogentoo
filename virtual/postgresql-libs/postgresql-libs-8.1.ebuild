# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/postgresql-libs/postgresql-libs-8.1.ebuild,v 1.1 2007/10/03 05:10:19 dev-zero Exp $

DESCRIPTION="Virtual for PostgreSQL libraries"
HOMEPAGE="http://www.postgresql.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="${PV}"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="=dev-db/libpq-${PV}*"
