# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/flexget/flexget-1.0_beta2484.ebuild,v 1.2 2011/12/21 16:32:52 floppym Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

MY_P="FlexGet-${PV/_beta/r}"
DESCRIPTION="Multipurpose automation tool for content like torrents, nzbs, podcasts, comics, etc"
HOMEPAGE="http://flexget.com/"
SRC_URI="http://download.flexget.com/unstable/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="deluge test transmission"

RDEPEND="
	dev-python/feedparser
	>=dev-python/sqlalchemy-0.7
	dev-python/pyyaml
	dev-python/beautifulsoup:python-2
	dev-python/html5lib
	dev-python/jinja
	dev-python/PyRSS2Gen
	dev-python/pynzb
	dev-python/progressbar
	dev-python/flask
	dev-python/cherrypy
"
DEPEND="
	dev-python/setuptools
	test? ( ${RDEPEND} dev-python/nose )
"
RDEPEND+="
	dev-python/setuptools
	deluge? ( net-p2p/deluge )
	transmission? ( dev-python/transmissionrpc )
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Prevent setup from grabbing nose from pypi
	sed -e /setup_requires/d -i pavement.py || die

	epatch_user
	distutils_src_prepare
}
