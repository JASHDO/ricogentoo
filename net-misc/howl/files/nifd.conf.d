# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2         
# $Header: /var/cvsroot/gentoo-x86/net-misc/howl/files/nifd.conf.d,v 1.3 2004/10/06 23:39:38 latexer Exp $

# NOTES:
# nifd mornitors the network interfaces for an IP or link change.

# Options to pass to the nifd process that will *always* be run
# Most people should not change this line ...
# however, if you know what you're doing, feel free to tweak
# 
# -n            don't run ifdown/ifup on relink
# -i interval   poll interval in seconds
NIFD_OPTS="-n"
