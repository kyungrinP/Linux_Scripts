#!/bin/bash



export PATH=$PATH:~/Linux_Scripts/scripts/Daily/01.unauthorized_user_management
export PATH=$PATH:~/Linux_Scripts/scripts/Daily/02.unauthorized_user_security
export PATH=$PATH:~/Linux_Scripts/scripts/Daily/03.DOS_attack
export PATH=$PATH:~/Linux_Scripts/scripts/Daily/04.package_update


U-01.sh
echo
U-02.sh
echo
U-04.sh
echo
U-05.sh
echo
U-08.sh
echo
U-09.sh
echo
U-11.sh
echo
U-12.sh
echo
U-14.sh
echo
U-15.sh
echo
U-25.sh
echo
U-32.sh
echo
U-37.sh
echo
U-38.sh
echo
U-03.sh
echo
U-22.sh
echo
U-36.sh
echo
U-23.sh
echo
U-27.sh
echo
U-33.sh
echo
U-42.sh

echo "========================================================================"
cat /root/Linux_Scripts/result2.log
echo "========================================================================"

today=$(date +%Y%m%d)
tar zcfp /root/Linux_Scripts/D_LOG-$today.tar.gz *.log
rm -rf *.log
