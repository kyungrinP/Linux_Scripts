#!/bin/bash
. function.sh

BAR
CODE [ U-56 ] UMASK 설정 관리 
cat << EOF >> $RESULT 
[ 양호 ] : UMASK 값이 022 이상으로 설정된 경우 
[ 취약 ] : UMASK 값이 022 이상으로 설정되지 않은 경우 
EOF
BAR

# UMASK 값 확인 
cat /etc/profile | grep -i umask | awk '{print $2}' | grep 022 >/dev/null
if [ $? -eq 0 ] ; then
    OK umask 값이 올바르게 설정 되었습니다. 
else
    WARN umask 값이 올바르게 설정 되지 않았습니다. 
fi

cat $RESULT 
echo;
