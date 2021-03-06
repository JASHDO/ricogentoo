# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/arpack/arpack-96-r1.ebuild,v 1.1 2007/09/26 19:26:47 bicatali Exp $

inherit eutils autotools fortran

DESCRIPTION="Arnoldi package library to solve large scale eigenvalue problems."
HOMEPAGE="http://www.caam.rice.edu/software/ARPACK"
SRC_URI="http://www.caam.rice.edu/software/ARPACK/SRC/${PN}${PV}.tar.gz
	http://www.caam.rice.edu/software/ARPACK/SRC/patch.tar.gz
	http://www.caam.rice.edu/software/ARPACK/SRC/p${PN}${PV}.tar.gz
	http://www.caam.rice.edu/software/ARPACK/SRC/ppatch.tar.gz
	doc? ( http://www.caam.rice.edu/software/ARPACK/SRC/ug.ps.gz
		http://www.caam.rice.edu/software/ARPACK/DOCS/tutorial.ps.gz )"

LICENSE="RiceBSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mpi doc examples"

DEPEND="mpi? ( virtual/mpi )"
RDEPEND="${DEPEND} virtual/blas"

S="${WORKDIR}/ARPACK"

FORTRAN="gfortran ifc g77"

RESTRICT="mirror"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-autotools.patch
	epatch "${FILESDIR}"/${P}-gcc-4.2.patch

	# BLAS_LIBS="$(pkg-config --libs blas)" when new blas virtuals ok (bug #189722)
	BLAS_LIBS="-lblas"
	# fix examples library paths
	sed -i \
		-e '/^include/d' \
		-e "s/\$(ALIBS)/-larpack ${BLAS_LIBS}/g" \
		-e 's/$(FC)/$(F77)/g' \
		-e 's/$(FFLAGS)/$(FFLAGS) $(LDFLAGS)/g' \
		EXAMPLES/*/makefile || die "sed failed"

	sed -i \
		-e '/^include/d' \
		-e "s/\$(PLIBS)/-larpack -lparpack ${BLAS_LIBS} -lmpi/g" \
		-e 's/_$(PLAT)//g' \
		-e 's/$(PFC)/mpif77/g' \
		-e 's/$(PFFLAGS)/$(FFLAGS) $(LDFLAGS)/g' \
		PARPACK/EXAMPLES/MPI/makefile || die "sed failed"

	eautoreconf
}

src_compile() {
	econf \
		--with-blas="${BLAS_LIBS}" \
		$(use_enable mpi) \
		|| "econf failed"
	emake || "emake failed"
}

src_test() {
	cd "${S}"/EXAMPLES/SIMPLE
	emake simple FC=${FORTRANC} LDFLAGS="-L${S}/.libs"
	local prog=
	for p in ss ds sn dn cn zn; do
		prog=${p}simp
		LD_LIBRARY_PATH="${S}/.libs" ./${prog} || die "${prog} test failed"
		rm -f ${prog}
	done
	if use mpi; then
		cd "${S}"/PARPACK/EXAMPLES/MPI
		${FORTRANC} ${FFLAGS} -c ../../../LAPACK/dpttrf.f dpttrf.o || die "compiling dpttrf failed"
		${FORTRANC} ${FFLAGS} -c ../../../LAPACK/dpttrs.f dpttrs.o || die "compiling dpttrs failed"
		emake pdndrv FC=mpif77 LDFLAGS="-L${S}/.libs -L${S}/PARPACK/.libs dpttrf.o dpttrs.o"
		for p in 1 3; do
			prog=pdndrv${p}
			LD_LIBRARY_PATH="${S}/.libs:${S}/PARPACK/.libs" ./${prog} || die "${prog} test failed"
			rm -f ${prog}
		done
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README DOCUMENTS/*.doc || die "dodoc failed"
	newdoc DOCUMENTS/README README.doc || die "newdoc failed"
	if use doc; then
		dodoc "${WORKDIR}"/*.ps || die "dodoc postscript failed"
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r EXAMPLES || die "doins examples failed"
		if use mpi; then
			insinto /usr/share/doc/${PF}/EXAMPLES/PARPACK
			doins -r PARPACK/EXAMPLES/MPI || die "doins mpi examples failed"
		fi
	fi
}
