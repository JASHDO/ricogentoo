# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opencryptoki/opencryptoki-2.3.2.ebuild,v 1.3 2011/01/07 22:53:33 flameeyes Exp $

EAPI="2"

# backports are maintained as tags on Diego's repository on gitorious:
# http://gitorious.org/~flameeyes/opencryptoki/flameeyess-opencryptoki
BACKPORTS=1

inherit autotools eutils multilib

DESCRIPTION="PKCS#11 provider for IBM cryptographic hardware"
HOMEPAGE="http://sourceforge.net/projects/opencryptoki"
SRC_URI="mirror://sourceforge/opencryptoki/${P}.tar.bz2
	${BACKPORTS:+
		http://dev.gentoo.org/~flameeyes/${PN}/${P}-backports-${BACKPORTS}.tar.bz2}"

LICENSE="CPL-0.5"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="tpm? ( app-crypt/trousers )
		 dev-libs/openssl"
DEPEND="${RDEPEND}"

IUSE="+tpm debug"

pkg_setup() {
	enewgroup pkcs11
}

src_prepare() {
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_MULTI_MSG="Applying backports patches #${BACKPORTS} ..." \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	eautoreconf
}

src_configure() {
	econf \
		--enable-fast-install \
		--disable-dependency-tracking \
		$(use_enable debug) \
		--enable-daemon \
		--enable-library \
		--disable-icatok \
		--enable-swtok \
		$(use_enable tpm tpmtok) \
		--disable-icctok \
		--disable-aeptok \
		--disable-bcomtok \
		--disable-crtok \
		--disable-pkcscca_migrate
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	# We replace their ld.so and init files (mostly designed for RedHat
	# as far as I can tell) with our own replacements.
	rm -rf "${D}"/etc/ld.so.conf.d "${D}"/etc/rc.d

	# make sure that we don't modify the init script if the USE flags
	# are enabled for the needed services.
	sed -n \
		$(use tpm || echo '-e /use tcsd/d') \
		-e 'p' \
		"${FILESDIR}/pkcsslotd.init.2" \
		> "${T}"/pkcsslotd.init || die

	newinitd "${T}/pkcsslotd.init" pkcsslotd

	dodir /etc/env.d
	cat - > "${D}"/etc/env.d/50${PN} <<EOF
LDPATH=/usr/$(get_libdir)/opencryptoki:/usr/$(get_libdir)/opencryptoki/stdll
EOF

	dodoc README AUTHORS FAQ TODO doc/openCryptoki-HOWTO.pdf || die
}
