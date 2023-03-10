#!/bin/bash

# log파일로 해당 진단 내용 파일 생성 
. function.sh
TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [ U-33 ] DNS 보안 버전 패치
cat << EOF >> $RESULT
[ 양호 ] : DNS 서비스를 사용하지 않거나 주기적으로 패치를 관리하고 있는 경우
[ 취약 ] : DNS 서비스를 사용하며 주기적으로 패치를 관리하고 있지 않는 경우
EOF
BAR

# 활성화 여부 확인
ps -ef | grep named | grep -v grep > $TMP1

if [ -s $TMP1 ] ; then
    WARN $SERVICE 서비스가 활성화되어 있습니다.
    INFO $TMP1 파일을 확인해야 합니다.
else
    OK $SERVICE 서비스가 비활성화되어 있습니다.
fi

if [ -n ${TMP1} ] ; then
    rm $TMP1
fi

cat $RESULT
echo;
