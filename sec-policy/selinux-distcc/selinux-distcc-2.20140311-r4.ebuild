# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-distcc/selinux-distcc-2.20140311-r4.ebuild,v 1.1 2014/08/01 21:04:29 swift Exp $
EAPI="5"

IUSE=""
MODS="distcc"
BASEPOL="2.20140311-r4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for distcc"

KEYWORDS="~amd64 ~x86"
