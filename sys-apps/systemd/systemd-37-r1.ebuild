# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/systemd/systemd-37-r1.ebuild,v 1.3 2012/01/14 21:17:23 williamh Exp $

EAPI=4

inherit autotools-utils bash-completion-r1 linux-info pam systemd

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/systemd"
SRC_URI="http://www.freedesktop.org/software/systemd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="acl audit cryptsetup gtk pam plymouth selinux tcpd"

COMMON_DEPEND=">=sys-apps/dbus-1.4.10
	>=sys-apps/util-linux-2.19
	>=sys-fs/udev-172
	sys-libs/libcap
	acl? ( sys-apps/acl )
	audit? ( >=sys-process/audit-2 )
	cryptsetup? ( sys-fs/cryptsetup )
	gtk? (
		dev-libs/dbus-glib
		>=dev-libs/glib-2.26
		x11-libs/gtk+:2
		>=x11-libs/libnotify-0.7 )
	pam? ( virtual/pam )
	plymouth? ( sys-boot/plymouth )
	selinux? ( sys-libs/libselinux )
	tcpd? ( sys-apps/tcp-wrappers )"

# Vala-0.10 doesn't work with libnotify 0.7.1
VALASLOT="0.12"
# A little higher than upstream requires
# but I had real trouble with 2.6.37 and systemd.
MINKV="2.6.38"

# dbus, udev versions because of systemd units
# blocker on old packages to avoid collisions with above
# openrc blocker to avoid udev rules starting openrc scripts
# systemd blocker due to /usr migration
RDEPEND="${COMMON_DEPEND}
	!<sys-apps/openrc-0.8.3
	!=sys-apps/systemd-29-r4"
DEPEND="${COMMON_DEPEND}
	dev-util/gperf
	dev-util/intltool
	gtk? ( dev-lang/vala:${VALASLOT} )
	>=sys-kernel/linux-headers-${MINKV}"

pkg_setup() {
	enewgroup lock # used by var-lock.mount
	enewgroup tty 5 # used by mount-setup for /dev/pts
}

src_prepare() {
	# Force the rebuild of .vala sources
	touch src/*.vala || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--with-distro=gentoo
		--with-rootdir=
		--with-rootlibdir=/$(get_libdir)
		--localstatedir=/var
		--docdir=/tmp/docs
		$(use_enable acl)
		$(use_enable audit)
		$(use_enable cryptsetup libcryptsetup)
		$(use_enable gtk)
		$(use_enable pam)
		$(use_enable plymouth)
		$(use_enable selinux)
		$(use_enable tcpd tcpwrap)
	)

	if use gtk; then
		export VALAC="$(type -p valac-${VALASLOT})"
	fi

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install \
		bashcompletiondir=/tmp

	# move files as necessary
	newbashcomp "${D}"/tmp/systemctl-bash-completion.sh ${PN}
	dodoc "${D}"/tmp/docs/*
	rm -rf "${D}"/tmp || die

	cd "${D}"/usr/share/man/man8/
	for i in halt poweroff reboot runlevel shutdown telinit; do
		mv ${i}.8 systemd.${i}.8 || die
	done

	# Create /run/lock as required by new baselay/OpenRC compat.
	insinto /usr/lib/tmpfiles.d
	doins "${FILESDIR}"/gentoo-run.conf
}

pkg_preinst() {
	local CONFIG_CHECK="~AUTOFS4_FS ~CGROUPS ~DEVTMPFS ~FANOTIFY ~IPV6"
	kernel_is -ge ${MINKV//./ } || ewarn "Kernel version at least ${MINKV} required"
	check_extra_config
}

optfeature() {
	elog "	[$(has_version ${1} && echo I || echo ' ')] ${1} (${2})"
}

pkg_postinst() {
	mkdir -p "${ROOT}"/run
	if [[ ! -L "${ROOT}"/etc/mtab ]]; then
		ewarn "Upstream suggests that the /etc/mtab file should be a symlink to /proc/mounts."
		ewarn "It is known to cause users being unable to unmount user mounts. If you don't"
		ewarn "require that specific feature, please call:"
		ewarn "	$ ln -sf '${ROOT}proc/self/mounts' '${ROOT}etc/mtab'"
		ewarn
	fi

	elog "You may need to perform some additional configuration for some programs"
	elog "to work, see the systemd manpages for loading modules and handling tmpfiles:"
	elog "	$ man modules-load.d"
	elog "	$ man tmpfiles.d"
	elog

	elog "To get additional features, a number of optional runtime dependencies may"
	elog "be installed:"
	optfeature 'dev-python/dbus-python' 'for systemd-analyze'
	optfeature 'dev-python/pycairo[svg]' 'for systemd-analyze plotting ability'
	elog

	ewarn "Please note this is a work-in-progress and many packages in Gentoo"
	ewarn "do not supply systemd unit files yet. You are testing it on your own"
	ewarn "responsibility. Please remember than you can pass:"
	ewarn "	init=/sbin/init"
	ewarn "to your kernel to boot using sysvinit / OpenRC."
}
