#!/bin/bash
. function.sh

BAR
CODE [ U-68 ] 로그온 시 경고 메시지 제공
cat << EOF >> $RESULT
[ 양호 ] : 서버 및 Telnet, FTP, SMTP, DNS 서비스에 로그온 메시지가 설정되어 있는 경우
[ 취약 ] : 서버 및 Telnet, FTP, SMTP, DNS 서비스에 로그온 메시지가 설정되어있지 않은 경우
EOF
BAR

cat << EOF > check_list.txt
/etc/motd
/etc/issue.net
/etc/vsftpd/vsftpd.conf
/etc/mail/sendmail.cf
/etc/named.conf
EOF

LIST=check_list.txt
for i in $(cat $LIST)
do
    INFO $i 파일을 참조하여 로그온 메시지를 설정해야 합니다.
done
rm check_list.txt

cat $RESULT
echo;
