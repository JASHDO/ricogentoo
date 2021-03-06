# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/pykde4/pykde4-4.6.3-r1.ebuild,v 1.7 2011/07/21 10:33:31 maekke Exp $

EAPI=3

KMNAME="kdebindings"
if [[ ${PV} != *9999 ]]; then
	KMMODULE="python/pykde4"
else
	# HACK HACK HACK
	KMMODULE="."
fi
OPENGL_REQUIRED="always"
PYTHON_USE_WITH="threads"
RESTRICT_PYTHON_ABIS="2.4"
KDE_SCM="git"
EGIT_REPONAME="pykde4"
inherit python kde4-meta

DESCRIPTION="Python bindings for KDE4"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug doc examples semantic-desktop"

# blocker added due to compatibility issues and error during compile time
DEPEND="
	!dev-python/pykde
	>=dev-python/sip-4.12
	$(add_kdebase_dep kdelibs 'opengl,semantic-desktop=')
	semantic-desktop? ( $(add_kdebase_dep kdepimlibs 'semantic-desktop') )
	aqua? ( >=dev-python/PyQt4-4.8.2[dbus,declarative,sql,svg,webkit,aqua] )
	!aqua? ( >=dev-python/PyQt4-4.8.2[dbus,declarative,sql,svg,webkit,X] )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.6.3-pyqt475.patch"
	"${FILESDIR}/${P}-python-3.2.patch" )

pkg_setup() {
	python_pkg_setup
	kde4-meta_pkg_setup
}

src_prepare() {
	kde4-meta_src_prepare

	if ! use examples; then
		sed -e '/^ADD_SUBDIRECTORY(examples)/s/^/# DISABLED /' -i ${KMMODULE}/CMakeLists.txt \
			|| die "Failed to disable examples"
	fi

	# See bug 322351
	use arm && epatch "${FILESDIR}/${PN}-4.4.4-arm-sip.patch"
}

src_configure() {
	# Required for KTabWidget::label
	append-cxxflags -DKDE3_SUPPORT

	mycmakeargs=(
		-DWITH_PolkitQt=OFF
		-DWITH_QScintilla=OFF
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop KdepimLibs)
	)

	kde4-meta_src_configure
}

src_install() {
	use doc && HTML_DOCS=("${S}/${KMMODULE}/docs/html/")

	kde4-meta_src_install

	python_convert_shebangs -q -r $(python_get_version) "${ED}"
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	python_mod_optimize PyKDE4 PyQt4/uic/pykdeuic4.py PyQt4/uic/widget-plugins/kde4.py

	if use examples; then
		echo
		elog "PyKDE4 examples have been installed to"
		elog "${EKDEDIR}/share/apps/${PN}/examples"
		echo
	fi
}

pkg_postrm() {
	kde4-meta_pkg_postrm

	python_mod_cleanup PyKDE4 PyQt4/uic/pykdeuic4.py PyQt4/uic/widget-plugins/kde4.py
}
