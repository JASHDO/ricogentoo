# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-PersistentObjectDatabaseSchemaTiein/ezc-PersistentObjectDatabaseSchemaTiein-1.2.ebuild,v 1.3 2007/10/08 19:02:54 jokey Exp $

inherit php-ezc

DESCRIPTION="This eZ component allows the automatic generation of PersistentObject definition files from DatabaseSchema definitions."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""
RDEPEND="${RDEPEND}
	>=dev-php5/ezc-PersistentObject-1.3
	>=dev-php5/ezc-DatabaseSchema-1.2
	>=dev-php5/ezc-ConsoleTools-1.3"
