# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/uam/uam-0.1.ebuild,v 1.1 2011/01/20 21:19:26 mgorny Exp $

EAPI=3
inherit autotools-utils eutils multilib

DESCRIPTION="Simple udev-based automounter for removable USB media"
HOMEPAGE="https://github.com/mgorny/uam/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-fs/udev"
DEPEND="${RDEPEND}"

DOCS=( NEWS README )

src_configure() {
	myeconfargs=(
		--libdir=/$(get_libdir)
	)
	autotools-utils_src_configure
}

pkg_postinst() {
	# The plugdev group is created by pam, pmount and many other ebuilds
	# in gx86. As we don't want to depend on any of them (even pmount is
	# optional), we create it ourself too.
	enewgroup plugdev

	elog "To be able to access uam-mounted filesystems, you have to be"
	elog "a member of the 'plugdev' group."
	elog
	elog "Note that uam doesn't provide any way to allow unprivileged user"
	elog "to manually umount devices. The upstream suggested solution"
	elog "is to use [sys-apps/pmount]. If you don't feel like installing"
	elog "additional tools, remember to sync before removing your USB stick."
	elog
	elog "Another feature uam is not capable of is mounting removable media"
	elog "in fixed drives, like CDs and floppies. You might, however, be able"
	elog "to mount them as an unprivileged user using appropriate fstab entries"
	elog "or [sys-apps/pmount]."
	elog
	elog "If you'd like to receive libnotify-based notifications, you need"
	elog "to install the [x11-misc/sw-notify-send] tool."

	if [[ -e "${EROOT}"/dev/.udev ]]; then
		ebegin "Calling udev to reload its rules"
		udevadm control --reload-rules
		eend $?
	fi
}
