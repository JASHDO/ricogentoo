# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-base-policy/selinux-base-policy-20051022-r1.ebuild,v 1.3 2006/02/22 17:09:29 spb Exp $

IUSE="build"

inherit eutils

DESCRIPTION="Gentoo base policy for SELinux"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~mips"
KEYWORDS="alpha amd64 mips ppc sparc x86"
DEPEND="build? ( sys-devel/make
		 sys-devel/m4 )"
RDEPEND="sys-devel/m4
	 sys-devel/make"

S=${WORKDIR}/base-policy

[ -z ${POLICYDIR} ] && POLICYDIR="/etc/security/selinux/src/policy"

# deprecated policies:
DEPRECATED="domains/program/devfsd.te domains/program/opt.te
	file_contexts/program/devfsd.fc file_contexts/program/opt.fc
	file_contexts/users.fc domains/program/inetd.te
	domains/program/tcpd.te file_contexts/program/inetd.fc
	file_contexts/program/tcpd.fc macros/program/ypbind_macros.te"

src_compile() {
	return
}

src_install() {
	sed -i -e 's/genhomedircon/genhomedircon.old/' ${S}/Makefile
	if use build; then
		# generate a file_contexts
		dodir ${POLICYDIR}/file_contexts
		einfo "Ignore the checkpolicy error on the next line."
		make -C ${S} \
			FC=${D}/${POLICYDIR}/file_contexts/file_contexts \
			${D}/${POLICYDIR}/file_contexts/file_contexts

		[ ! -f ${D}/${POLICYDIR}/file_contexts/file_contexts ] && \
			die "file_contexts was not generated."
	else
		# install full policy
		dodir /etc/security/selinux/src

		insinto /etc/security
		doins ${S}/appconfig/*

		cp -a ${S} ${D}/${POLICYDIR}
		rm -fR ${D}/${POLICYDIR}/appconfig
	fi
}

pkg_postinst() {
	local isdeprecated

	if ! ( use build || use bootstrap )
	then
		ewarn "Removing invalid backup copies of critical config files..."
		rm -f ${ROOT}/${POLICYDIR}/._cfg????_users
	fi

	echo
	einfo "This is the base policy for SELinux on Gentoo.  This policy"
	einfo "package only covers the applications in the system profile."
	einfo "More policy may need to be added according to your requirements."
	echo
	eerror "It is STRONGLY suggested that you evaluate and merge the"
	eerror "policy changes.  If any of the file contexts (*.fc) have"
	eerror "changed, you should also relabel."
	echo
	ewarn "Please check the Changelog, there may be important information."
	echo
	echo

	einfo "Checking for deprecated policy..."
	for i in $DEPRECATED; do
		if [ -f "${POLICYDIR}/${i}" ]; then
			eerror "${POLICYDIR}/${i}"
			isdeprecated="y"
		fi
	done
	[ "${isdeprecated}" ] && \
		eerror "The above policy file(s) should be removed if possible." || \
		einfo "None found."

	ebeep 4
	epause 4
}
