# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-portmap/selinux-portmap-20050908.ebuild,v 1.2 2005/10/09 23:58:29 spb Exp $

TEFILES="portmap.te"
FCFILES="portmap.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for portmap"

KEYWORDS="amd64 mips ppc sparc x86"
#KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
