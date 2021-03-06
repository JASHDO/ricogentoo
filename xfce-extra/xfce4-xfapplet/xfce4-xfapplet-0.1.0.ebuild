# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xfapplet/xfce4-xfapplet-0.1.0.ebuild,v 1.20 2007/05/25 17:47:28 drac Exp $

inherit xfce44

xfce44

DESCRIPTION="Panel plugin to support GNOME applets"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"

RDEPEND=">=gnome-base/orbit-2.12.5
	gnome-base/gnome-panel"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin
