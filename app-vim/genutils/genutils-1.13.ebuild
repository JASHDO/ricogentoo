# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/genutils/genutils-1.13.ebuild,v 1.6 2005/01/01 16:50:37 eradicator Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: library with various useful functions"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=197"
LICENSE="GPL-2"
KEYWORDS="x86 sparc mips ~ppc"
IUSE=""

RDEPEND="|| ( >=app-editors/vim-6.3 >=app-editors/gvim-6.3 )
	>=app-vim/multvals-3.6.1"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides library functions and is not intended to be used
directly by the user."
