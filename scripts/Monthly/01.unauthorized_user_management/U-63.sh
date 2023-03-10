#!/bin/bash

# log파일로 해당 진단 내용 파일 생성 
. function.sh
TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [ U-63 ] ftpusers 파일 소유자 및 권한 설정 
cat << EOF >> $RESULT 
[ 양호 ] : ftpusers 파일의 소유자가 root이고, 권한이 640 이하인 경우 
[ 취약 ] : ftpusers 파일의 소유자가 root가 아니거나, 권한이 640 이하가 아닌 경우 
EOF
BAR

FILE=/etc/vsftpd/ftpusers

# 소유자 root 확인
CHECK1=`ls -l $FILE | awk '{print $3}'`
if [ $CHECK1 == 'root' ] ; then
    OK $FILE의 소유자가 root로 설정되어 있습니다. 
else
    WARN $FILE의 소유자가 root로 설정되어 있지 않습니다. 
fi

# 파일 권한 확인 
# CHECK2=`ls -l $FILE | awk '{print $1}' | cut -c 2-`  # 권한만 출력하는 명령 
find $FILE -perm -640 -ls | grep -v 'rw-r-----' >> $TMP1
if [ -s $TMP1 ] ; then  # 파일 내용이 비어있는 경우 
    INFO $TMP1 파일을 확인해야 합니다. 
    WARN $FILE의 권한 설정을 다시해야 합니다. 
else
    OK $FILE의 권한 설정이 올바르게 되어있습니다. 
    rm $TMP1
fi

cat $RESULT 
echo;
