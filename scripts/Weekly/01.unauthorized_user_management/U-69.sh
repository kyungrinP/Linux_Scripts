#!/bin/bash

. function.sh

BAR
CODE [ U-69 ] NFS 설정파일 접근권한
cat << EOF >> $RESULT
[ 양호 ] : NFS 접근제어 설정파일의 소유자가 root 이고, 권한이 644 이하인 경우
[ 취약 ] : NFS 접근제어 설정파일의 소유자가 root 가 아니거나, 권한이 644 이하가 아닌 경우
EOF
BAR

FILE=/etc/exports

# 소유자 확인
CHECK1=$(ls -l $FILE | awk '{print $3}') # 소유자 뽑아내는 명령어
if [ $CHECK1 == 'root' ] ; then
    OK $FILE 의 소유자는 root입니다.
else
    WARN $FILE 의 소유자가 root로 설정되어 있지 않습니다.
fi

# rwx 권한 확인
CHECK2=`su - root -c 'find $FILE -perm 644'`
if [ -n "$CHECK2" ] ; then # 출력 문자열이 0이 아닌 경우
    OK $FILE 의 권한 설정이 안전하게 되어있습니다.
else
    WARN $FILE 의 권한 설정이 잘못 되어있습니다.
fi

cat $RESULT
echo;
