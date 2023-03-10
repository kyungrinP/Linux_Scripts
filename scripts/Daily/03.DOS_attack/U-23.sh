#!/bin/bash
. function.sh

BAR
CODE [ U-23 ] DoS 공격에 취약한 서비스 비활성화
cat << EOF >> $RESULT
[ 양호 ] : 사용하지 않는 DoS 공격에 취약한 서비스가 비활성화 된 경우
[ 취약 ] : 사용하지 않는 DoS 공격에 취약한 서비스가 활성화 된 경우
EOF
BAR

# 체크할 파일 리스트
cat << EOF > check_service_list.txt
chargen-dgram
chargen-stream
daytime-dgram
daytime-stream
discard-dgram
discard-stream
echo-dgram
echo-stream
EOF

SERVICELIST=check_service_list.txt
XINETD=/etc/xinetd.d

# 파일 유무/활성화 여부 확인
for i in $(cat $SERVICELIST)
do
ls $XINETD/$i* >/dev/null 2>&1
if [ $? != 0 ]; then
OK $XINETD/$i 파일이 존재하지 않습니다.
else
for j in $(ls $XINETD/$i*)
do
INFO $j 파일이 존재합니다.
if [ $(cat $j | grep disable | awk '{print $3}') = "yes" ]; then
OK $j 파일에 대한 서비스가 비활성화되어 있습니다.
else
WARN $j 파일에 대한 서비스가 활성화되어있습니다.
fi
done
fi
done
rm check_service_list.txt

cat $RESULT
echo;
