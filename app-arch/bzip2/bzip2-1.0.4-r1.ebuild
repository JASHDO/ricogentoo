# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bzip2/bzip2-1.0.4-r1.ebuild,v 1.6 2008/01/14 19:53:13 dertobi123 Exp $

inherit eutils multilib toolchain-funcs flag-o-matic

DESCRIPTION="A high-quality data compressor used extensively by Gentoo Linux"
HOMEPAGE="http://www.bzip.org/"
SRC_URI="http://www.bzip.org/${PV}/${P}.tar.gz"

LICENSE="BZIP2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="static"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.0.4-makefile-CFLAGS.patch
	epatch "${FILESDIR}"/${PN}-1.0.4-saneso.patch
	epatch "${FILESDIR}"/${PN}-1.0.4-man-links.patch #172986
	epatch "${FILESDIR}"/${PN}-1.0.3-shared-largefile-support.patch
	epatch "${FILESDIR}"/${PN}-1.0.2-progress.patch
	epatch "${FILESDIR}"/${PN}-1.0.3-no-test.patch
	epatch "${FILESDIR}"/${PN}-1.0.4-POSIX-shell.patch #193365
	sed -i -e 's:\$(PREFIX)/man:\$(PREFIX)/share/man:g' Makefile || die "sed manpath"

	# - Generate symlinks instead of hardlinks
	# - pass custom variables to control libdir
	sed -i \
		-e 's:ln -s -f $(PREFIX)/bin/:ln -s :' \
		-e 's:$(PREFIX)/lib:$(PREFIX)/$(LIBDIR):g' \
		Makefile || die "sed links"
}

src_compile() {
	local makeopts="
		CC=$(tc-getCC)
		AR=$(tc-getAR)
		RANLIB=$(tc-getRANLIB)
	"
	emake ${makeopts} -f Makefile-libbz2_so all || die "Make failed libbz2"
	use static && append-flags -static
	emake LDFLAGS="${LDFLAGS}" ${makeopts} all || die "Make failed"

	if ! tc-is-cross-compiler ; then
		make check || die "test failed"
	fi
}

src_install() {
	emake PREFIX="${D}"/usr LIBDIR=$(get_libdir) install || die

	# move bzip2 binaries to /bin and use the shared libbz2.so
	mkdir -p "${D}"/bin
	mv "${D}"/usr/bin/* "${D}"/bin/
	into /
	if ! use static ; then
		newbin bzip2-shared bzip2 || die "dobin shared"
	fi
	dolib.so "${S}"/libbz2.so.${PV} || die "dolib shared"
	for v in libbz2.so{,.{${PV%%.*},${PV%.*}}} ; do
		dosym libbz2.so.${PV} /$(get_libdir)/${v}
	done
	gen_usr_ldscript libbz2.so

	dodoc README* CHANGES bzip2.txt manual.*

	dosym bzip2 /bin/bzcat
	dosym bzip2 /bin/bunzip2
}
