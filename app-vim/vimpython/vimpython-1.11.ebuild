# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimpython/vimpython-1.11.ebuild,v 1.8 2008/03/09 14:40:52 armin76 Exp $

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: A set of menus/shortcuts to work with Python files"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=30"

LICENSE="vim"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND="${DEPEND}"

VIM_PLUGIN_HELPURI="${HOMEPAGE}"
