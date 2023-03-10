#!/bin/bash

# log파일로 해당 진단 내용 파일 생성 
. function.sh
TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [ U-42 ] 최신 보안패치 및 벤더 권고사항 적용
cat << EOF >> $RESULT
[ 양호 ] : 패치 적용 정책을 수립하여 주기적으로 패치관리를 하고 있으며, 패치 관련 내용을 확인하고 적용했을 경우
[ 취약 ] : 패치 적용 정책을 수립하지 않고 주기적으로 패치관리를 하지 않거나 패치 관련 내용을 확인하지 않고 적용하지 않았을 경우
EOF
BAR

INFO $TMP1 파일을 확인하여 참고할 패키지 리스트의 패치를 참고해야 합니다.
rpm -qa >> $TMP1
# rpm -qa | grep -i "ssh|telnet|xinetd|ftp|nfs|sendmail|bind|apache|httpd|samba|ypserv|ntpd|syslog" >> $TMP1

cat $RESULT
echo;
