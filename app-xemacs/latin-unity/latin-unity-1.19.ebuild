# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/latin-unity/latin-unity-1.19.ebuild,v 1.4 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: find single ISO 8859 character set to encode a buffer."
PKG_CAT="mule"

RDEPEND="app-xemacs/mule-base
app-xemacs/latin-euro-standards
app-xemacs/mule-ucs
app-xemacs/leim
app-xemacs/fsf-compat
app-xemacs/dired
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
