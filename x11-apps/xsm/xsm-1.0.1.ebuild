# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xsm/xsm-1.0.1.ebuild,v 1.6 2007/08/01 23:28:37 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X Session Manager"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="xprint"
RDEPEND="x11-libs/libXaw
	net-misc/netkit-rsh"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="$(use_enable xprint)"

pkg_setup() {
	if use xprint && ! built_with_use x11-libs/libXaw xprint; then
		die "Build x11-libs/libXaw with USE=xprint."
	fi

	# (#158056) /usr/$(get_libdir)/X11/xsm could be a symlink
	local XSMPATH="${ROOT}usr/$(get_libdir)/X11/xsm"
	if [[ -L ${XSMPATH} ]]; then
		einfo "Removing symlink ${XSMPATH}"
		rm -f ${XSMPATH} || die "failed to remove symlink ${XSMPATH}"
	fi
}
