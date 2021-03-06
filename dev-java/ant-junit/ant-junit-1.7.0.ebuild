# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-junit/ant-junit-1.7.0.ebuild,v 1.10 2007/05/12 18:16:10 wltjr Exp $

inherit ant-tasks

KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"

DEPEND="=dev-java/junit-3*"
RDEPEND="${DEPEND}"

src_compile() {
	eant jar-junit
}
