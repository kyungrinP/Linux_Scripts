#!/bin/bash

# log파일로 해당 진단 내용 파일 생성 
. function.sh
TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [ U-44 ] root 이외의 UID가 ‘0’ 금지
cat << EOF >> $RESULT 
[ 양호 ] : root 계정과 동일한 UID를 갖는 계정이 존재하지 않는 경우 
[ 취약 ] : root 계정과 동일한 UID를 갖는 계정이 존재하는 경우 
EOF
BAR

FILE=/etc/passwd
# 계정명 : 패스워드 : UID값 : 설명(Comment) : 홈디렉터리 : 지정된 쉘 
# root : 0  -> root 계정과 동일한 UID 갖는 계정 확인 
awk -F: '$3 == "0" {print $1 " : " $3}' $FILE >> $TMP1 
UIDCHECK=$(wc -l < $TMP1)  
if [ $UIDCHECK -ge 2 ] ; then  # >=
    WARN root 계정과 동일한 UID를 갖는 계정이 존재합니다. 
    INFO $TMP1 파일을 확인해야 합니다. 
else 
    OK root 계정과 동일한 UID를 갖는 계정이 존재하지 않습니다. 
    rm $TMP1
fi

cat $RESULT 
echo;
