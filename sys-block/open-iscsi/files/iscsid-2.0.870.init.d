#!/sbin/runscript
# Copyright 1999-2008 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-block/open-iscsi/files/iscsid-2.0.870.init.d,v 1.1 2008/11/17 20:58:44 dertobi123 Exp $

opts="${opts} starttargets stoptargets restarttargets"

depend() {
	after modules
	use net
}

checkconfig() {
	if [ ! -f ${CONFIG_FILE} ]; then
		eerror "Config file ${CONFIG_FILE} does not exist!"
		return 1
	fi
	if ! grep -q "^InitiatorName=iqn\." ${INITIATORNAME_FILE}; then
		ewarn "${INITIATORNAME_FILE} should contain a string with your initiatior name."
		IQN=iqn.$(date +%Y-%m).$(hostname -f | awk 'BEGIN { FS=".";}{x=NF; while (x>0) {printf $x ;x--; if (x>0) printf ".";} print ""}'):openiscsi
		IQN=${IQN}-$(echo ${RANDOM}${RANDOM}${RANDOM}${RANDOM}${RANDOM} | md5sum | sed -e "s/\(.*\) -/\1/g" -e 's/ //g')
		ebegin "Creating InitiatorName ${IQN} in ${INITIATORNAME_FILE}"
		echo "InitiatorName=${IQN}" >> ${INITIATORNAME_FILE}
		eend $?
	fi
}

do_modules() {
	msg="$1"
	shift
	modules="${1}"
	shift
	modopts="$@"
	for m in ${modules}
	do
		if [ -n "$(modprobe -l | grep ${m})" ]
		then
			ebegin "${msg} ${m}"
			modprobe ${modopts} ${m}
			ret=$?
			eend ${ret}
			if [ ${ret} -ne 0 ]; then
				return ${ret}
			fi
		else
			ebegin "${msg} ${m}: not found"
			return 1
		fi
	done
	return 0
}

start() {
	checkconfig
	ebegin "Loading iSCSI modules"
	do_modules 'Loading' 'libiscsi scsi_transport_iscsi iscsi_tcp'
	ret=$?
	if [ $ret -ne 0 ]; then
		eend 1
		return 1
	fi

	ebegin "Starting ${SVCNAME}"
	start-stop-daemon --start --quiet --exec /usr/sbin/iscsid -- ${OPTS}
	eend $?

	# Start automatic targets when iscsid is started
	[ "${AUTOSTARTTARGETS}" = "yes" ] && starttargets
	return 0
}
	
stop() {
	stoptargets
	ebegin "Stopping ${SVCNAME}"
	start-stop-daemon --signal HUP --stop --quiet --exec /usr/sbin/iscsid #--pidfile $PID_FILE
	eend $?

	# ugly, but pid file is not removed by iscsid
	rm -f $PID_FILE
	
	do_modules 'Removing iSCSI modules' 'iscsi_tcp scsi_transport_iscsi libiscsi' '-r'
	eend $?
}

starttargets() {
        ebegin "Setting up iSCSI targets"
        /usr/sbin/iscsiadm -m node --loginall=automatic
        eend $?
}

stoptargets() {
        ebegin "Disconnecting iSCSI targets"
        sync
        /usr/sbin/iscsiadm -m node --logoutall=all
        eend $?
}

restarttargets() {
        stoptargets
        starttargets
}

status() {
	ebegin "Showing current active iSCSI sessions"
	/usr/sbin/iscsiadm -m session
}
