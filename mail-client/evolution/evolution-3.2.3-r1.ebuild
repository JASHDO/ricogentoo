# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/evolution/evolution-3.2.3-r1.ebuild,v 1.4 2012/10/17 09:55:53 tetromino Exp $

EAPI=4
GCONF_DEBUG=no
GNOME2_LA_PUNT=yes
PYTHON_DEPEND="python? 2:2.5"

inherit autotools eutils flag-o-matic gnome2 python

DESCRIPTION="Integrated mail, addressbook and calendaring functionality"
HOMEPAGE="http://projects.gnome.org/evolution/"

# Note: explicitly "|| ( LGPL-2 LGPL-3 )", not "LGPL-2+".
LICENSE="|| ( LGPL-2 LGPL-3 ) CCPL-Attribution-ShareAlike-3.0 FDL-1.3+ OPENLDAP"
SLOT="2.0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="clutter connman crypt +gnome-online-accounts gstreamer kerberos ldap map networkmanager python ssl"

# We need a graphical pinentry frontend to be able to ask for the GPG
# password from inside evolution, bug 160302
PINENTRY_DEPEND="|| ( app-crypt/pinentry[gtk] app-crypt/pinentry-qt app-crypt/pinentry[qt4] )"

# contacts-map plugin requires libchaimplain and geoclue
# glade-3 support is for maintainers only per configure.ac
# mono plugin disabled as it's incompatible with 2.8 and lacks maintainance (see bgo#634571)
# pst is not mature enough and changes API/ABI frequently
COMMON_DEPEND=">=dev-libs/glib-2.28:2
	>=x11-libs/cairo-1.9.15[glib]
	>=x11-libs/gtk+-3.0.2:3
	>=gnome-base/gnome-desktop-2.91.3:3
	>=gnome-base/gsettings-desktop-schemas-2.91.92
	>=dev-libs/libgweather-2.90.0:2
	>=media-libs/libcanberra-0.25[gtk3]
	>=x11-libs/libnotify-0.7
	>=gnome-extra/evolution-data-server-${PV}[gnome-online-accounts?,weather]
	>=gnome-extra/gtkhtml-4.1.2:4.0
	>=gnome-base/gconf-2:2
	dev-libs/atk
	>=dev-libs/libxml2-2.7.3:2
	>=net-libs/libsoup-gnome-2.31.2:2.4
	>=x11-misc/shared-mime-info-0.22
	>=x11-themes/gnome-icon-theme-2.30.2.1
	>=dev-libs/libgdata-0.9.1

	x11-libs/libSM
	x11-libs/libICE

	clutter? (
		>=media-libs/clutter-1.0.0:1.0
		>=media-libs/clutter-gtk-0.90:1.0
		x11-libs/mx:1.0 )
	connman? ( net-misc/connman )
	crypt? ( || (
		( >=app-crypt/gnupg-2.0.1-r2 ${PINENTRY_DEPEND} )
		=app-crypt/gnupg-1.4* ) )
	gnome-online-accounts? ( >=net-libs/gnome-online-accounts-3.1.1 )
	gstreamer? (
		>=media-libs/gstreamer-0.10:0.10
		>=media-libs/gst-plugins-base-0.10:0.10 )
	kerberos? ( virtual/krb5 )
	ldap? ( >=net-nds/openldap-2 )
	map? (
		>=app-misc/geoclue-0.11.1
		media-libs/libchamplain:0.10 )
	networkmanager? ( >=net-misc/networkmanager-0.7 )
	ssl? (
		>=dev-libs/nspr-4.6.1
		>=dev-libs/nss-3.11 )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40.0
	>=sys-devel/gettext-0.17
	sys-devel/bison
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.9.1
	app-text/docbook-xml-dtd:4.1.2
	>=gnome-base/gnome-common-2.12
	>=dev-util/gtk-doc-am-1.9"
# eautoreconf needs:
#	>=gnome-base/gnome-common-2.12
RDEPEND="${COMMON_DEPEND}
	!<gnome-extra/evolution-exchange-2.32"

# contact maps require clutter
# NM and connman support cannot coexist
REQUIRED_USE="map? ( clutter )
	connman? ( !networkmanager )
	networkmanager? ( !connman )"

pkg_setup() {
	ELTCONF="--reverse-deps"
	DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS* README"
	# image-inline plugin needs a gtk+:3 gtkimageview, which does not exist yet
	G2CONF="${G2CONF}
		--without-glade-catalog
		--without-kde-applnk-path
		--enable-plugins=experimental
		--disable-image-inline
		--disable-mono
		--disable-pst-import
		--enable-canberra
		--enable-weather
		$(use_enable ssl nss)
		$(use_enable ssl smime)
		$(use_enable networkmanager nm)
		$(use_enable connman)
		$(use_enable gnome-online-accounts goa)
		$(use_enable gstreamer audio-inline)
		$(use_enable map contact-maps)
		$(use_enable python)
		$(use_with clutter)
		$(use_with ldap openldap)
		$(use_with kerberos krb5 ${EPREFIX}/usr)"

	# dang - I've changed this to do --enable-plugins=experimental.  This will
	# autodetect new-mail-notify and exchange, but that cannot be helped for the
	# moment.  They should be changed to depend on a --enable-<foo> like mono
	# is.  This cleans up a ton of crap from this ebuild.

	# Use NSS/NSPR only if 'ssl' is enabled.
	if use ssl ; then
		G2CONF="${G2CONF} --enable-nss=yes"
	else
		G2CONF="${G2CONF}
			--without-nspr-libs
			--without-nspr-includes
			--without-nss-libs
			--without-nss-includes"
	fi

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# https://bugzilla.gnome.org/show_bug.cgi?id=663077, requires eautoreconf
	epatch "${FILESDIR}"/${PN}-3.2.1-reorder-mx-clutter-gtk.patch
	# Fix build failure with glib-2.32
	epatch "${FILESDIR}"/${P}-gmodule-explicit.patch
	epatch "${FILESDIR}"/${P}-g_thread_init.patch
	# Fix crashes and linking failure with gtkhtml-4.4
	epatch "${FILESDIR}"/${P}-gtkhtml-4.4.patch

	# Fix >=sys-devel/automake-1.12 compability wrt #421307
	sed -i \
		-e '/PROG_MKDIR_P/s:AM:AC:' \
		-e 's:mkdir_p:MKDIR_P:' \
		-e '/AM_INIT_AUTOMAKE/s:-Werror ::' \
		m4/po.m4 po/Makefile.in.in configure.ac || die

	eautoreconf

	gnome2_src_prepare
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "To change the default browser if you are not using GNOME, edit"
	elog "~/.local/share/applications/mimeapps.list so it includes the"
	elog "following content:"
	elog ""
	elog "[Default Applications]"
	elog "x-scheme-handler/http=firefox.desktop"
	elog "x-scheme-handler/https=firefox.desktop"
	elog ""
	elog "(replace firefox.desktop with the name of the appropriate .desktop"
	elog "file from /usr/share/applications if you use a different browser)."
	elog ""
	elog "Junk filters are now a run-time choice. You will get a choice of"
	elog "bogofilter or spamassassin based on which you have installed"
	elog ""
	elog "You have to install one of these for the spam filtering to actually work"
}
