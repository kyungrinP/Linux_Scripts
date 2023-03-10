#!/bin/bash

# log파일로 해당 진단 내용 파일 생성
. function.sh
TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [ U-38 ] 웹서비스 불필요한 파일 제거
cat << EOF >> $RESULT
[ 양호 ] : 기본으로 생성되는 불필요한 파일 및 디렉터리가 제거되어 있는 경우
[ 취약 ] : 기본으로 생성되는 불필요한 파일 및 디렉터리가 제거되지 않은 경우
EOF
BAR

INFO $TMP1 파일을 확인하여 불필요한 파일 여부를 확인해야 합니다.

find / -name manual > $TMP1
ls -l /etc/httpd/manual >> $TMP1
ls –l /var/www/manual >> $TMP1

cat $RESULT
echo;
