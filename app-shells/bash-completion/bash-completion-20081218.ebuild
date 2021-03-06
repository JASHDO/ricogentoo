# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/bash-completion-20081218.ebuild,v 1.1 2008/12/18 22:54:51 coldwind Exp $

DESCRIPTION="Programmable Completion for bash"
HOMEPAGE="http://bash-completion.alioth.debian.org/"
#SRC_URI="mirror://debian/pool/main/b/${PN}/${PN}_${PV}.tar.gz"
SRC_URI="mirror://gentoo/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-admin/eselect
	|| (
		>=app-shells/bash-2.05a
		app-shells/zsh
	)"
PDEPEND="app-shells/gentoo-bashcomp"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	#EPATCH_SUFFIX="patch" epatch "${FILESDIR}"/${PV}

	# bug #111681
	sed -i -e "/^complete.* xine /d" bash_completion
}

src_install() {
	# split /etc/bash_completion into three parts:
	# 1. /usr/share/bash-completion/.pre    -- hidden from eselect
	# 2. /usr/share/bash-completion/base -- eselectable
	# 3. /usr/share/bash-completion/.post   -- hidden from eselect
	dodir /usr/share/bash-completion
	awk -v D="$D" '
		BEGIN { out=".pre" }
		/^# A lot of the following one-liners/ { out="base" }
		/^# source completion directory/ { out="" }
		/^unset -f have/ { out=".post" }
		out != "" { print > D"/usr/share/bash-completion/"out }' \
		bash_completion || die "failed to split bash_completion"

	exeinto /etc/profile.d
	doexe "${FILESDIR}"/bash-completion.sh \
		|| die "failed to install profile.d"

	insinto /usr/share/bash-completion
	doins contrib/* || die "failed to install contrib completions"

	dodoc debian/changelog README TODO
}

pkg_preinst() {
	# This file is now being installed as bash-completion.sh, so rename it
	# first.  That allows CONFIG_PROTECT to kick in properly
	if [[ -f ${ROOT}/etc/profile.d/bash-completion && \
		! -f ${ROOT}/etc/profile.d/bash-completion.sh ]]
	then
		mv "${ROOT}"/etc/profile.d/bash-completion{,.sh}
	fi
}

pkg_postinst() {
	elog
	elog "Versions of bash-completion prior to 20060301-r1 required each user to"
	elog "explicitly source /etc/profile.d/bash-completion in ~/.bashrc.  This"
	elog "was kludgy and inconsistent with the completion modules which are"
	elog "enabled with eselect bashcomp.  Now any user can enable the base"
	elog "completions without editing their .bashrc by running"
	elog
	elog "    eselect bashcomp enable base"
	elog
	elog "The system administrator can also be enable this globally with"
	elog
	elog "    eselect bashcomp enable --global base"
	elog
	elog "Additional completion functions can also be enabled or"
	elog "disabled using eselect's bashcomp module."
	elog
	elog "If you use non-login shells you still need to source"
	elog "/etc/profile.d/bash-completion.sh in your ~/.bashrc."
	elog

	if has_version 'app-shells/zsh' ; then
		elog "If you are interested in using the provided bash completion functions with"
		elog "zsh, valuable tips on the effective use of bashcompinit are available:"
		elog "  http://www.zsh.org/mla/workers/2003/msg00046.html"
		elog "  http://zshwiki.org/ZshSwitchingTo"
		elog
	fi
}
