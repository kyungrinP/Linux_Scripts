#!/bin/bash
. function.sh

BAR
CODE [ U-66 ] SNMP 서비스 구동 점검
cat << EOF >> $RESULT
[ 양호 ] : SNMP 서비스를 사용하지 않는 경우
[ 취약 ] : SNMP 서비스를 사용하는 경우
EOF
BAR

# SNMP 확인
ps -ef | grep snmp | grep -v grep > tmp.log
if [ -s tmp1.log ] ; then
    WARN SNMP 서비스를 사용 중입니다.
else
    OK SNMP 서비스를 사용하고 있지 않습니다.
fi
rm tmp.log

cat $RESULT
echo;
