#!/bin/bash

. function.sh

TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [U-04] 패스워드 파일 보호
cat << EOF >> $RESULT
[양호]: 쉐도우 패스워드를 사용하거나, 패스워드를 암호화하여 저장하는 경우
[취약]: 쉐도우 패스워드를 사용하지 않고, 패스워드를 암호화하여 저장하지 않는 경우
EOF
BAR

STATUS1=FALSE
STATUS2=FALSE

CheckIsEncrypted() {
        grep '^root' $1 | awk -F: '{print $2}' | \
    egrep -q '^\$1\$|^\$2\$|^\$3\$|^\$4\$|^\$5\$|^\$6\$|'
        if [ $? -eq 0 ] ; then
                OK $1 파일의 암호가 암호화 되어 있습니다.
                STATUS1=TRUE
        else
                WARN $1 파일의 암호가 암호화 되어 있지 않습니다.
        fi
}


PASSFILE=/etc/passwd
SHADOWFILE=/etc/shadow

if [ -f $SHADOWFILE ] ; then
        OK $SHADOWFILE 파일을 사용하고 있습니다.
        STATUS2=TRUE
        CheckIsEncrypted $SHADOWFILE
else
        WARN $SHADOWFILE 파일을 사용하지 않습니다.
        CheckIsEncrypted $PASSFILE
fi

if [ $STATUS1 = TRUE -a $STATUS2 = TRUE ] ; then
        OK [최종] : 쉐도우 패스워드를 사용하거나, 패스워드를 암호화하여 저장하고 있습니다.
else
        WARN [최종] : 쉐도우 패스워드를 사용하거나, 패스워드를 암호화하여 저장하고 있지 않습니다.
fi

cat $RESULT
echo; echo
