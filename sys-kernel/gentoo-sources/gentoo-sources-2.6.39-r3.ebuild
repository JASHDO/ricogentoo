# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.6.39-r3.ebuild,v 1.7 2011/10/03 18:34:33 josejx Exp $

EAPI="2"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="5"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2
detect_version
detect_arch

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches"
IUSE="deblob"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
