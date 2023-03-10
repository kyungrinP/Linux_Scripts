#!/bin/bash

# log파일로 해당 진단 내용 파일 생성
. function.sh
TMP1=`SCRIPTNAME`.log
> $TMP1
TMP2=$(mktemp)
TMP3=$(mktemp)

BAR
CODE [ U-13 ] SUID, SGID, 설정 파일점검
cat << EOF >> $RESULT 
[ 양호 ] : 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있지 않은 경우 
[ 취약 ] : 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있는 경우 
INFO 해당 설정이 부여되어 있을 경우 악의적인 권한상승의 가능성이 존재합니다. 
EOF
BAR

NOSETUIDFILE=nosetuid.txt  # 점검할 파일 목록이 있는 파일 
# 파일 내의 진단 목록 하나씩 점검 
cat $NOSETUIDFILE | while read i
do
        if [ -e $i ] ; then
                FILEPERM=$(ls -l $i | awk '{print $1}' | grep 's')
                if [ ! -z $FILEPERM ] ; then # 파일에 권한이 설정되어 있음 
                        echo "[+] $i $FILEPERM" >> $TMP2
                else # 파일에 권한이 설정되어 있지 않음 
                        echo "[*] $i" >> $TMP2
                fi      
        else # 파일이 존재하지 않음 
                echo "[-] $i" >> $TMP2
        fi      
done

# 파일 진단에 대해 SUID, SGID 진단 결과를 뽑아냄  
# -xdev : 다른 파일 시스템 검색 X  
# -user : 해당 소유자의 파일이나 디렉터리를 찾음 (root)  
# -type f : 일반 파일 
# -perm : 권한 4000 혹은 2000 
find / -xdev -user root -type f \( -perm -4000 -o -perm -2000 \) -ls \
        | awk '{print $3, $11}' 2>/dev/null > $TMP3 

if grep -q '[+]' $TMP2 ; then
        WARN 주요 파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있습니다. 
        INFO $TMP1  파일을 확인해야 합니다. 
        cat << EOF >> $TMP1
        ===============================================================
        1. 다음은 주요 파일의 권한에 SUID와 SGID에 대한 설정 여부입니다. 
        * [+] 파일에 suid/sgid가 설정 되어 있는 파일 
        * [*] 파일에 suid/sgid가 설정 되어 있지 않은 파일 
        * [-] 존재하지 않는 파일 
        
        $(cat $TMP2)
        

        2. 다음은 시스템 내 SUID와 SGID를 가진 파일 목록입니다. 
        $(cat $TMP3)
        ===============================================================
        EOF     
else
        OK 주요 파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있지 않습니다. 
fi
rm $NOSETUIDFILE

cat $RESULT 
echo;
