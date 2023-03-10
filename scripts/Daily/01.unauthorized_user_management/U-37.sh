#!/bin/bash

. function.sh

BAR
CODE [U-37] 웹서비스 상위 디렉토리 접근 금지 
cat << EOF >> $RESULT 
[ 양호 ] : 상위 디렉터리에 이동제한을 설정한 경우 
[ 취약 ] : 상위 디렉터리에 이동제한을 설정하지 않은 경우 
EOF
BAR

FILE=/etc/httpd/conf/httpd.conf

# 파일에서 AllowOverride 부분 중 주석이 없는 문자열 출력 
CHECK=`cat $FILE | grep AllowOverride | grep -v '#' | awk '{print $2}'`
# cat /etc/httpd/conf/httpd.conf | grep AllowOverride | grep -v '#' | awk '{print $2}'
# none/AuthConfig 확인
if [[ ${CHECK} == *AuthConfig* ]] ; then
    OK 상위 디렉터리에 이동제한을 설정했습니다. 
elif [[ ${CHECK} == *None* ]] ; then
    WARN 상위 디렉터리에 이동제한을 설정하지 않았습니다. 
else  # All인 경우
    OK 상위 디렉터리에 이동제한을 설정했습니다. 
fi

cat $RESULT 
echo;
