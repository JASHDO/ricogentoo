# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/pykde4/pykde4-4.4.5-r1.ebuild,v 1.4 2011/01/18 21:06:00 ranger Exp $

EAPI="3"

KMNAME="kdebindings"
KMMODULE="python/pykde4"
OPENGL_REQUIRED="always"
PYTHON_USE_WITH="threads"
RESTRICT_PYTHON_ABIS="2.4"
inherit python kde4-meta

DESCRIPTION="Python bindings for KDE4"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug doc examples semantic-desktop"

# blocker added due to compatibility issues and error during compile time
DEPEND="
	!dev-python/pykde
	$(add_kdebase_dep kdelibs 'opengl,semantic-desktop?')
	semantic-desktop? ( $(add_kdebase_dep kdepimlibs 'semantic-desktop') )
	aqua? ( >=dev-python/PyQt4-4.8[dbus,sql,svg,webkit,aqua] )
	!aqua? ( >=dev-python/PyQt4-4.8[dbus,sql,svg,webkit,X] )
"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_pkg_setup
	kde4-meta_pkg_setup
}

src_prepare() {
	kde4-meta_src_prepare

	if ! use examples; then
		sed -e '/^ADD_SUBDIRECTORY(examples)/s/^/# DISABLED /' -i python/${PN}/CMakeLists.txt \
			|| die "Failed to disable examples"
	fi

	# See bug 328135
	epatch "${FILESDIR}"/${PN}-4.4.92-build-fix-sip.patch

	# See bug 322351
	use arm && epatch "${FILESDIR}/${PN}-4.4.4-arm-sip.patch"

	epatch "${FILESDIR}/${PN}-mapped-type-fix.patch"
	has_version ">=dev-python/sip-4.12" && epatch "${FILESDIR}/${P}-sip-4.12.patch"
	epatch "${FILESDIR}/${P}-PyQt4-4.7.5.patch"
}

src_configure() {
	mycmakeargs=(
		-DWITH_QScintilla=OFF
		-DWITH_PolkitQt=OFF
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop KdepimLibs)
	)

	kde4-meta_src_configure
}

src_install() {
	use doc && HTML_DOCS=("${S}/python/pykde4/docs/html/")

	kde4-meta_src_install

	python_convert_shebangs -r $(python_get_version) "${ED}"
	python_clean_installation_image -q
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	python_mod_optimize PyKDE4 PyQt4

	if use examples; then
		echo
		elog "PyKDE4 examples have been installed to"
		elog "${EKDEDIR}/share/apps/${PN}/examples"
		echo
	fi
}

pkg_postrm() {
	kde4-meta_pkg_postrm

	python_mod_cleanup PyKDE4 PyQt4
}
