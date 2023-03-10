#!/bin/bash

# log파일로 해당 진단 내용 파일 생성 
. function.sh
TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [ U-58 ] 홈 디렉터리로 지정한 디렉토리의 존재 관리
cat << EOF >> $RESULT
[ 양호 ] : 홈 디렉터리가 존재하지 않는 계정이 발견되지 않는 경우
[ 취약 ] : 홈 디렉터리가 존재하지 않는 계정이 발견된 경우
EOF
BAR

INFO $TMP1 파일을 확인하여 검토해야 합니다.
FILE=/etc/passwd
# 사용자와 홈 디렉터리 출력
cat $FILE | awk -F: '{print $1,$6}' >> $TMP1

cat $RESULT
echo;
