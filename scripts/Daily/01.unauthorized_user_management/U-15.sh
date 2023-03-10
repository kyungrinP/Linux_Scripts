#!/bin/bash

# log파일로 해당 진단 내용 파일 생성 
. function.sh
TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [ U-15 ] world writable 파일 점검
cat << EOF >> $RESULT
[ 양호 ] : 홈 디렉터리 환경변수 파일의 소유자가 root 또는, 해당 계정으로 지정되어 있고, 홈 디렉터리 환경변수 파일에 root와 소유자만 쓰기 권한이 부여 된 경우
[ 취약 ] : 홈 디렉터리 환경변수 파일의 소유자가 root 또는, 해당 계정으로 지정되지 않고, 홈 디렉터리 환경변수 파일에 root와 소유자 외에 쓰기 권한이 부여된 경우
EOF
BAR

INFO $TMP1 파일을 확인해야 합니다.
# ex) rwxrwxrwx root root [파일명]
find / -perm -2 -ls >> $TMP1 2>&1

if [ -s $TMP1 ] ; then
    WARN $TMP1 파일을 참고하여 설정을 변경해야 합니다.
else
    OK world writable 파일이 없습니다.
    rm $TMP1
fi

cat $RESULT
echo;
