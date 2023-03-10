#!/bin/bash

# log파일로 해당 진단 내용 파일 생성 
. function.sh
TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [ U-27 ] RPC 서비스 확인
cat << EOF >> $RESULT
[ 양호 ] : 불필요한 RPC 서비스가 비활성화 되어 있는 경우
[ 취약 ] : 불필요한 RPC 서비스가 활성화 되어 있는 경우
EOF
BAR

# 불필요한 RPC 서비스 리스트
cat << EOF >> check_service_list.txt
rpc.cmsd
cmsd
rpc.ttdbserverd
ttdbserverd
sadmind
rusersd
walld
sprayd
rstatd
rpc.nisd
rexd
rpc.pcnfsd
pcnfsd
rpc.statd
rpc.ypupdated
rquotad
kcms_server
cachfsd
EOF

SERVICELIST=check_service_list.txt
XINETD=/etc/xinetd.d

INFO $TMP1 파일을 참고해야 합니다.
for i in $(cat $SERVICELIST)
# 파일 존재 여부 확인
do
ls $XINETD/$i* >/dev/null 2>&1
if [ $? != 0 ]; then
# OK $XINETD/$i 파일이 존재하지 않습니다.
    cat << EOF >> $TMP1
$XINETD/$i 파일이 존재하지 않습니다.
EOF
else
for j in $(ls $XINETD/$i*)
do
# INFO $j 파일이 존재합니다.
    cat << EOF >> $TMP1
$XINETD/$i 파일이 존재합니다.
EOF
            # 서비스 활성화 여부 확인
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
