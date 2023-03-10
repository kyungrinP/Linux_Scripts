#!/bin/bash

# log파일로 해당 진단 내용 파일 생성 
. function.sh
TMP1=SCRIPTNAME.log
> $TMP1

BAR
CODE [U-36] 웹서비스 웹 프로세스 권한 제한
cat << EOF >> $RESULT
[ 양호 ] : Apache 데몬이 root 권한으로 구동되지 않는 경우
[ 취약 ] : Apache 데몬이 root 권한으로 구동되는 경우
EOF
BAR

FILE=/etc/httpd/conf/httpd.conf

# 파일 내 User/Group 설정 확인
cat $FILE | egrep '(User|Group)' | grep -v '#' | egrep -v '(UserDir|LogFormat)' > $TMP1
# root 권한의 구동 여부 확인
cat $TMP1 | while read VAR1 VAR2
do
    if [ $VAR2 == 'root' ] ; then
        WARN $VAR1 $VAR2으로 설정되어 있습니다.  # root 권한 구동
    else
        OK $VAR1 $VAR2으로 설정되어 있습니다.  # root가 아닌 계정으로 구동
    fi
done
rm $TMP1

cat $RESULT
echo;
