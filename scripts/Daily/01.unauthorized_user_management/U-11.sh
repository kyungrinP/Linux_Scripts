#!/bin/bash

. function.sh

BAR
CODE [U-11] /etc/\(r\)syslog.conf 파일 소유자 및 권한 설정
cat << EOF >> $RESULT
[ 양호 ] : /etc/(r)syslog.conf 파일의 소유자가 root(또는 bin, sys)이고, 권한이 640 이하인 경우
[ 취약 ] : /etc/(r)syslog.conf 파일의 소유자가 root(또는 bin, sys)가 아니거나, 권한이 640이 아닌 경우
EOF
BAR

SYSLOGCONFFILE=/etc/rsyslog.conf

# 소유자 확인
CHECK1=$(ls -l $SYSLOGCONFFILE | awk '{print $3}') # 소유자 뽑아내는 명령어
if [[ $CHECK1 == 'root' || $CHECK1 == 'bin' || $CHECK1 == 'sys' ]] ; then
    OK $SYSLOGCONFFILE 의 소유자는 root입니다.
else
    WARN $SYSLOGCONFFILE 의 소유자가 root로 설정되어 있지 않습니다.
fi

# rwx 권한 확인
# -c : root 권한을 잠깐 얻어서 명령어만 실행함
# $? : 최근 실행된 명령어
CHECK2='find /etc/rsyslog.conf -perm 640'
if [ -n "$CHECK2" ] ; then # 출력 문자열이 0이 아닌 경우
    OK $SYSLOGCONFFILE 의 권한 설정이 되어있습니다.
else
    WARN $SYSLOGCONFFILE 의 권한 설정이 잘못 되어있습니다.
fi

cat $RESULT
echo;
