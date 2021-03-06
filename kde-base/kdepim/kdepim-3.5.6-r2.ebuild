# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.5.6-r2.ebuild,v 1.3 2007/07/28 15:18:26 philantrop Exp $

inherit kde-dist

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5-patchset-03.tar.bz2"

DESCRIPTION="KDE PIM (Personal Information Management) applications: KOrganizer, KMail, KNode,..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="crypt gnokii"

# We use GnuPG 1.4.x for OpenPGP and 1.9 (via gpgme) for s/mime as upstream advises.
DEPEND="~kde-base/kdebase-${PV}
	>=dev-libs/cyrus-sasl-2
	gnokii? ( app-mobilephone/gnokii )
	crypt? ( >=app-crypt/gpgme-1.1.2-r1
		|| ( >=app-crypt/gnupg-2.0.1-r1 <app-crypt/gnupg-1.9 ) )
		x11-libs/libXScrnSaver"
#	Requires pilot-link-0.12.0
#	pda? ( >=app-pda/pilot-link-0.12.0 dev-libs/libmal )

RDEPEND="${DEPEND}
	crypt? ( app-crypt/pinentry )"

DEPEND="${DEPEND}
	x11-proto/scrnsaverproto"

src_unpack() {
	kde_src_unpack
	# Call Qt 3 designer
	sed -i -e "s:\"designer\":\"${QTDIR}/bin/designer\":g" "${S}"/libkdepim/kcmdesignerfields.cpp || die "sed failed"

	# disabling tests, see bug #164038 and bug #164097
	sed -e "s:SUBDIRS = libical versit tests:SUBDIRS = libical versit:" \
		 -i libkcal/Makefile.am || die "sed failed" || die "sed failed"
	sed -e "s:SUBDIRS = . plugins test:SUBDIRS = . plugins:" \
		-i kitchensync/libkonnector2/Makefile.am || die "sed failed"
	sed -e "s:SUBDIRS = . tests test:SUBDIRS = .:" \
		-i kitchensync/libksync/Makefile.am || die "sed failed"
}

src_compile() {
	local myconf="--with-sasl $(use_with gnokii)"
	use crypt && myconf="${myconf} --with-gpg=/usr/bin/gpg"

	# use pda || DO_NOT_COMPILE="${DO_NOT_COMPILE} kpilot"
	DO_NOT_COMPILE="${DO_NOT_COMPILE} kpilot"

	kde_src_compile
}

pkg_postinst() {
	kde_pkg_postinst

	elog "If you're using x11-misc/basket, please re-emerge it now to avoid crashes with Kontact."
	elog "cf. https://bugs.gentoo.org/show_bug.cgi?id=174872 for details."
}
