# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-logkit/avalon-logkit-2.1-r2.ebuild,v 1.8 2008/05/11 16:14:39 corsair Exp $

JAVA_PKG_IUSE="doc source test"
inherit java-pkg-2 java-ant-2

DESCRIPTION="Easy-to-use Java logging toolkit"
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/excalibur/excalibur-logkit/source/${P}-src.tar.gz"

KEYWORDS="amd64 ~ia64 ppc ppc64 x86"
LICENSE="Apache-2.0"
SLOT="2.0"
IUSE=""

COMMON_DEP="
	dev-java/log4j
	dev-java/sun-jms
	java-virtuals/javamail
	=dev-java/servletapi-2.4*"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
# Doesn't like 1.6 changes to JDBC
DEPEND="|| (
		=virtual/jdk-1.5*
		=virtual/jdk-1.4*
	)
	test? (
		=dev-java/junit-3*
		dev-java/ant-junit
	)
	${COMMON_DEP}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	java-ant_ignore-system-classes

	java-ant_xml-rewrite -f build.xml \
		-c -e available -a classpathref -v 'build.classpath' || die

	mkdir -p target/lib || die
	cd target/lib || die
	java-pkg_jar-from servletapi-2.4
	java-pkg_jar-from sun-jms
	java-pkg_jar-from --virtual javamail
	java-pkg_jar-from log4j
	java-pkg_filter-compiler jikes
}

src_test() {
	java-pkg_jar-from --into target/lib junit
	ANT_TASKS="ant-junit" eant test
}

src_install() {
	java-pkg_newjar target/${P}.jar
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
