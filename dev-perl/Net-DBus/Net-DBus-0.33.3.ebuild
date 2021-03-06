# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DBus/Net-DBus-0.33.3.ebuild,v 1.3 2006/10/27 21:39:35 chriswhite Exp $

inherit perl-module

DESCRIPTION="Perl extension for the DBus message system"
HOMEPAGE="http://search.cpan.org/~danberr/"
SRC_URI="mirror://cpan/authors/id/D/DA/DANBERR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl
	sys-apps/dbus
	dev-perl/XML-Twig
	dev-util/pkgconfig"
