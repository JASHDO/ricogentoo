# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/superkaramba/superkaramba-3.5.10.ebuild,v 1.1 2008/09/14 00:00:41 carlo Exp $

KMNAME=kdeutils
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RDEPEND="!x11-misc/superkaramba"

PATCHES="${FILESDIR}/${PN}-3.5.2-multilib-python.diff
		${FILESDIR}/${PN}-3.5.7-network_sensor.patch"
