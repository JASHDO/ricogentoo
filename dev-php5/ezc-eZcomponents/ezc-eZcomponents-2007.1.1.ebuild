# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-eZcomponents/ezc-eZcomponents-2007.1.1.ebuild,v 1.4 2007/10/08 19:03:18 jokey Exp $

DESCRIPTION="eZ components is an enterprise ready general purpose PHP platform."
HOMEPAGE="http://ez.no/products/ez_components"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="
	>=dev-php5/ezc-Archive-1.2.3
	>=dev-php5/ezc-Authentication-1.0
	>=dev-php5/ezc-AuthenticationDatabaseTiein-1.0
	>=dev-php5/ezc-Base-1.3.1
	>=dev-php5/ezc-Cache-1.2
	>=dev-php5/ezc-Configuration-1.2
	>=dev-php5/ezc-ConsoleTools-1.3
	>=dev-php5/ezc-Database-1.3
	>=dev-php5/ezc-DatabaseSchema-1.2
	>=dev-php5/ezc-Debug-1.1
	>=dev-php5/ezc-EventLog-1.1
	>=dev-php5/ezc-EventLogDatabaseTiein-1.0.2
	>=dev-php5/ezc-Execution-1.0.4
	>=dev-php5/ezc-File-1.1.1
	>=dev-php5/ezc-Graph-1.1
	>=dev-php5/ezc-GraphDatabaseTiein-1.0
	>=dev-php5/ezc-ImageAnalysis-1.1.2
	>=dev-php5/ezc-ImageConversion-1.3
	>=dev-php5/ezc-Mail-1.3.1
	>=dev-php5/ezc-PersistentObject-1.3
	>=dev-php5/ezc-PersistentObjectDatabaseSchemaTiein-1.2
	>=dev-php5/ezc-PhpGenerator-1.0.4
	>=dev-php5/ezc-SignalSlot-1.1
	>=dev-php5/ezc-SystemInformation-1.0.5
	>=dev-php5/ezc-Template-1.2
	>=dev-php5/ezc-Translation-1.1.4
	>=dev-php5/ezc-TranslationCacheTiein-1.1.2
	>=dev-php5/ezc-Url-1.1
	>=dev-php5/ezc-UserInput-1.1.2
	>=dev-php5/ezc-Workflow-1.0.1
	>=dev-php5/ezc-WorkflowDatabaseTiein-1.0
	>=dev-php5/ezc-WorkflowEventLogTiein-1.0
"
