# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-asterisk/selinux-asterisk-20050219.ebuild,v 1.3 2007/07/11 02:56:47 mr_bones_ Exp $

inherit selinux-policy

TEFILES="asterisk.te"
FCFILES="asterisk.fc"
IUSE=""

DESCRIPTION="Gentoo SELinux policy for asterisk, a modular open-source PBX system"

KEYWORDS="alpha amd64 mips ppc sparc x86"
