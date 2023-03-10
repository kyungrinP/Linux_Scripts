#!/bin/bash

# log파일로 해당 진단 내용 파일 생성 
. function.sh
TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [ U-67 ] SNMP 서비스 Community String의 복잡성 설정
cat << EOF >> $RESULT
[ 양호 ] : SNMP Community 이름이 public, private 이 아닌 경우
[ 취약 ] : SNMP Community 이름이 public, private 인 경우
EOF
BAR

FILE=/etc/snmp/snmpd.conf

# 파일 존재 여부 확인
if [ -f $FILE ]; then
    # SNMP Community 이름 확인
    cat $FILE | egrep '(public|private)' | grep -v '#' > $TMP1  # 주석처리 없는것 출력
    if [ -s $TMP1 ] ; then
        INFO $TMP1 파일을 확인해야 합니다.
        WARN SNMP Community 이름을 변경해야 합니다.
    else
        OK SNMP Community 이름이 public, private 이 아닙니다.
    fi
else
    WARN $FILE 을 사용중이지 않거나, 파일이 존재하지 않습니다.
    rm $TMP1
fi

cat $RESULT
echo;
