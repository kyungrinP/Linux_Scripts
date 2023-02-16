#!/bin/bash

. function.sh
TMP1=U-47.log
> $TMP1

BAR
CODE [U-47] 패스워드 최대 사용기간 설정
cat << EOF >> $RESULT
[양호]: 패스워드 최대 사용기간이 90일(12주) 이하로 설정되어 있는 경우
[취약]: 패스워드 최대 사용기간이 90일(12주) 이하로 설정되어 있지 않는 경우
EOF
BAR

LOGINDEFFILE=/etc/login.defs
SEARCHTARGET=PASS_MAX_DAYS

RET=$(SearchValue VALUE $LOGINDEFFILE $SEARCHTARGET)
echo '현재 패스워드 최대 사용기간 : '$RET'일'
if [ $RET -le 90 ] ; then
        OK '패스워드 최대 사용기간이 90일(12주) 이하로 설정되어 있습니다.'
else
        WARN '패스워드 최대 사용기간이 90일(12주) 이하로 설정되어 있지 않습니다.'
        INFO $TMP1 파일을 참고하시오.
        echo "==========================================================" >> $TMP1
        echo "1. $LOGINDEFFILE 파일의 내용입니다" >> $TMP1
        echo "" >> $TMP1
        SearchValue KEYVALUE $LOGINDEFFILE $SEARCHTARGET >> $TMP1
        echo "==========================================================" >> $TMP1
fi

cat $RESULT
echo; echo
