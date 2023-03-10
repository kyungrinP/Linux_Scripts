#!/bin/bash

. function.sh

BAR
CODE [ U-55 ] hosts.lpd 파일 소유자 및 권한 설정
cat << EOF >> $RESULT
[ 양호 ] : hosts.lpd 파일이 삭제되어 있거나 불가피하게 hosts.lpd 파일을 사용할 시 파일의 소유자가 root이고 권한이 600인 경우
[ 취약 ] : hosts.lpd 파일이 삭제되어 있지 않거나 파일의 소유자가 root가 아니고 권한이 600이 아닌 경우
EOF
BAR

FILE=/etc/hosts.lpd

# 파일 존재 여부 확인
if [ -e $FILE ] ; then
    WARN $FILE 파일이 존재합니다.
    # 파일 소유자 확인
    CHECK1=$(ls -l $PASSWDFILE | awk '{print $3}')
    if [ $CHECK1 == 'root' ] ; then
        OK $FILE 의 소유자는 root입니다.
    else
        WARN $FILE 의 소유자가 root로 설정되어 있지 않습니다.
    fi

    # 파일 권한 확인
    CHECK2=$(su - root -c 'find $FILE -perm 600')
    if [ -n "$CHECK2" ] ; then # 출력 문자열이 0이 아닌 경우
        OK $FILE 의 권한 설정이 안전하게 되어있습니다.
    else
        WARN $FILE 의 권한 설정이 잘못 되어있습니다.
    fi
else
    OK $FILE 파일이 존재하지 않습니다.
fi

cat $RESULT
echo;
