# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pauker/pauker-1.8_rc6.ebuild,v 1.2 2008/12/31 03:26:12 mr_bones_ Exp $

JAVA_PKG_IUSE="doc source"
EAPI="1"

inherit eutils java-pkg-2 java-ant-2 games

MY_PV="1.8RC6"

DESCRIPTION="A java based flashcard program"
HOMEPAGE="http://pauker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.src.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

COMMON_DEP="dev-java/browserlauncher2:1.0
			dev-java/javahelp
			dev-java/lucene:2.4
			dev-java/swing-layout:1"

RDEPEND=">=virtual/jre-1.5
		${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
		app-arch/unzip
		${COMMON_DEP}"

S="${WORKDIR}"

pkg_setup() {
	games_pkg_setup
	java-pkg-2_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	find . -iname '*.jar' -delete

	epatch "${FILESDIR}/${PN}_bundledjars.patch"

	java-pkg_jar-from --into libs browserlauncher2-1.0 browserlauncher2.jar BrowserLauncher2-1_3.jar
	java-pkg_jar-from --into libs javahelp jhall.jar
	java-pkg_jar-from --into libs lucene-2.4 lucene-core.jar lucene-core-2.4.0.jar
	java-pkg_jar-from --into libs swing-layout-1 swing-layout.jar
}

src_compile() {
	eant -Dfile.reference.BrowserLauncher2-1_3.jar="libs/BrowserLauncher2-1_3.jar" \
		-Dlibs.swing-layout.classpath="libs/swing-layout.jar" jar $(use_doc javadoc)
}

#test depend on jemmy, a netbeans module.  so unless it is packaged separately
#tests cannot be build.

src_install() {
	java-pkg_jarinto "${GAMES_DATADIR}/${PN}"
	java-pkg_newjar "dist/${PN}-${MY_PV}.jar"

	java-pkg_dolauncher ${PN} \
		-into "${GAMES_PREFIX}" \
		--pwd "${GAMES_DATADIR}"/${PN} \
		--main pauker.program.gui.swing.PaukerFrame

	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src

	prepgamesdirs
}
