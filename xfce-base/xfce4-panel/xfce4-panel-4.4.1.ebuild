# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-panel/xfce4-panel-4.4.1.ebuild,v 1.11 2007/11/18 06:47:01 drac Exp $

inherit xfce44

XFCE_VERSION=4.4.1
xfce44

DESCRIPTION="Panel"
HOMEPAGE="http://www.xfce.org/projects/xfce4-panel/"
KEYWORDS="mips"

IUSE="debug doc startup-notification"

RDEPEND="x11-libs/libX11
	x11-libs/libSM
	gnome-base/librsvg
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	startup-notification? ( x11-libs/startup-notification )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )
	!<xfce-base/xfce-utils-4.4"

DOCS="AUTHORS ChangeLog HACKING NEWS README README.Plugins"

xfce44_core_package
