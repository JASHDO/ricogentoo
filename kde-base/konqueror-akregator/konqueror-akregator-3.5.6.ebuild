# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror-akregator/konqueror-akregator-3.5.6.ebuild,v 1.1 2007/01/16 21:00:32 flameeyes Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="konq-plugins/akregator"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="konqueror's akregator plugin"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/konqueror)"
RDEPEND="${DEPEND}
$(deprange 3.5.4 $MAXKDEVER kde-base/kdeaddons-docs-konq-plugins)
$(deprange-dual $PV $MAXKDEVER kde-base/akregator)"
