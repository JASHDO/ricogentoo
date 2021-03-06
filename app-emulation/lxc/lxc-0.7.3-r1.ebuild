# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/lxc/lxc-0.7.3-r1.ebuild,v 1.2 2010/11/22 10:48:32 flameeyes Exp $

EAPI="2"

inherit eutils linux-info versionator base

DESCRIPTION="LinuX Containers userspace utilities"
HOMEPAGE="http://lxc.sourceforge.net/"
SRC_URI="http://lxc.sourceforge.net/download/lxc/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc examples vanilla"

RDEPEND="sys-libs/libcap"

DEPEND="${RDEPEND}
	doc? ( app-text/docbook-sgml-utils )
	>=sys-kernel/linux-headers-2.6.29"

# For init script, so protect with vanilla, they are not strictly
# needed.
RDEPEND="${RDEPEND}
	vanilla? (
		sys-apps/util-linux
		app-misc/pax-utils
	)"

CONFIG_CHECK="~CGROUPS
	~CGROUP_NS ~CPUSETS ~CGROUP_CPUACCT
	~RESOURCE_COUNTERS ~CGROUP_MEM_RES_CTLR
	~CGROUP_SCHED

	~NAMESPACES
	~IPC_NS ~USER_NS ~PID_NS

	~DEVPTS_MULTIPLE_INSTANCES
	~CGROUP_FREEZER
	~UTS_NS ~NET_NS
	~VETH ~MACVLAN"

ERROR_DEVPTS_MULTIPLE_INSTANCES="CONFIG_DEVPTS_MULTIPLE_INSTANCES:	needed for pts inside container"

ERROR_CGROUP_FREEZER="CONFIG_CGROUP_FREEZER:	needed to freeze containers"

ERROR_UTS_NS="CONFIG_UTS_NS:	needed to unshare hostnames and uname info"
ERROR_NET_NS="CONFIG_NET_NS:	needed for unshared network"

ERROR_VETH="CONFIG_VETH:	needed for internal (inter-container) networking"
ERROR_MACVLAN="CONFIG_MACVLAN:	needed for internal (inter-container) networking"

src_configure() {
	econf \
		--localstatedir=/var \
		--bindir=/usr/sbin \
		--docdir=/usr/share/doc/${PF} \
		--with-config-path=/etc/lxc	\
		--with-rootfs-path=/usr/lib/lxc/rootfs \
		$(use_enable doc) \
		$(use_enable examples) \
		|| die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS CONTRIBUTING MAINTAINERS \
		NEWS TODO README doc/FAQ.txt || die "dodoc failed"

	# If the documentation is going to be rebuilt, the Makefiles will
	# install the man pages themselves; if we're not going to, we
	# still need to install them, as they are provided with the
	# tarball in recent versions.
	if ! use doc; then
		doman doc/*.{1,5,7} || die
	fi

	rm -r "${D}"/usr/sbin/lxc-{setcap,ls} \
		"${D}"/usr/share/man/man1/lxc-ls.1 \
		|| die "unable to remove extraenous content"

	keepdir /etc/lxc /usr/lib/lxc/rootfs

	find "${D}" -name '*.la' -delete

	use vanilla && return 0

	# Gentoo-specific additions!
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	keepdir /var/log/lxc
}

pkg_postinst() {
	if ! use vanilla; then
		elog "There is an init script provided with the package now; no documentation"
		elog "is currently available though, so please check out /etc/init.d/lxc ."
		elog "You _should_ only need to symlink it to /etc/init.d/lxc.configname"
		elog "to start the container defined into /etc/lxc/configname.conf ."
		elog "For further information about LXC development see"
		elog "http://blog.flameeyes.eu/tag/lxc" # remove once proper doc is available
		elog ""
	fi
	ewarn "Starting from version 0.7.3, you have to specify mount points of bind mounts"
	ewarn "using the rootfs mount point as a base. This means you'd then have something"
	ewarn "along the lines of the following in your lxc configuration files:"
	ewarn ""
	ewarn "    lxc.mount.entry = /usr/portage /usr/lib/lxc/rootfs/usr/portage none bind 0 0"
	ewarn ""
	ewarn "To use the lxc-fedora, lxc-debian and lxc-ubuntu commands, you need respectively"
	ewarn "sys-apps/yum and dev-util/debootstrap."
}
