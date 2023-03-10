#!/bin/bash

. function.sh

BAR
CODE [U-01] root 계정 원격 접속 제한
cat << EOF >> $RESULT
[양호]: 원격 서비스를 사용하지 않거나 사용시 직접 접속을 차단한 경우
[취약]: root 직접 접속을 허용하고 원격 서비스를 사용하는 경우
EOF
BAR

# STATUS1: active|inactive
STATUS1=`systemctl is-active telnet.socket`

# STATUS2: enabled|disabled
STATUS2=`systemctl is-enabled telnet.socket`

if [ $STATUS1 = 'inactive' ] ; then
	OK 원격 서비스가 활성화 되어 있지 않습니다.
else
	WARN 원격 서비스가 활성화 되어 있습니다.
	if [ -f /etc/securetty ] ; then
		INFO '/etc/securetty 파일이 존재합니다.'
		if grep -q 'pts/' /etc/securetty; then
			WARN '/etc/securetty 파일안에 pts/# 존재합니다.'
		else
			OK '/etc/securetty 파일안에 pts/# 존재하지 않습니다.'
		fi
		
	else
		WARN '/etc/securetty 파일이 존재하지 않습니다.'
	fi
fi

cat $RESULT
