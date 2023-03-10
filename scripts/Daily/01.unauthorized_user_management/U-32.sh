#!/bin/bash

#log파일로 해당 진단 내용 파일 생성 
. function.sh
TMP1=SCRIPTNAME.log
> $TMP1

BAR
CODE [U-32] 일반사용자의 Sendmail 실행 방지
cat << EOF >> $RESULT
[ 양호 ] : SMTP 서비스 미사용 또는, 일반 사용자의 Sendmail 실행 방지가 설정된 경우 
[ 취약 ] : SMTP 서비스 사용 및 일반 사용자의 Sendmail 실행 방지가 설정되어 있지 않은 경우
EOF
BAR

FILE1=/etc/mail/sendmail.cf

# SMTP 서비스 사용여부 확인
ps -ef | grep sendmail | grep -v grep >> tmp.log
if [ -s tmp.log ] ; then
    WARN SMTP 서비스 사용 중입니다.
else
    OK SMTP 서비스를 미사용 중입니다.
fi
rm tmp.log

# PrivacyOptions 설정 부분의 restrictqrun 옵션 확인
PRIVACY1=`grep -v '^ *#' $FILE1 | grep PrivacyOptions | awk -F= '{print $2}' | sed 's/,/ /g'` # ,을 공백으로 바꿈
echo $PRIVACY1 | grep restrictqrun > $TMP1
if [ -n $TMP1 ] ; then  # 옵션 확인 명령어 결과가 존재하지 않는 경우
    OK SMTP 서비스를 사용하지 않거나, 파일이 존재하지 않습니다.
    rm $TMP1
else
    WARN $TMP1 파일을 참고하여 수동점검을 진행하세요.
fi

cat $RESULT
echo;
