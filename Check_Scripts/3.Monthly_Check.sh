#!/bin/bash



export PATH=$PATH:/root/scripts/Linux_Scripts/Daily/01.unauthorized_user_management
export PATH=$PATH:/root/scripts/Linux_Scripts/Daily/02.unauthorized_user_security
export PATH=$PATH:/root/scripts/Linux_Scripts/Daily/03.DOS_attack
export PATH=$PATH:/root/scripts/Linux_Scripts/Daily/04.package_update
export PATH=$PATH:/root/scripts/Linux_Scripts//Weekly/01.unauthorized_user_management/
export PATH=$PATH:/root/scripts/Linux_Scripts//Weekly/02.unauthorized_user_security/
export PATH=$PATH:/root/scripts/Linux_Scripts//Weekly/03.DOS_attack
export PATH=$PATH:/root/scripts/Linux_Scripts/Monthly/01.unauthorized_user_management

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
echo
U-44.sh
echo
U-46.sh
echo
U-47.sh
echo
U-57.sh
echo
U-58.sh
echo
U-69.sh
echo
U-56.sh
echo
U-66.sh
echo
U-67.sh
echo
U-53.sh
echo
U-55.sh
echo
U-59.sh
echo
U-63.sh
echo
u-68.sh


echo "========================================================================"
cat ./root/Linux_Scripts/result2.log
echo "========================================================================"
rm -rf /root/Linux_Scripts/result2.log

today=$(date +%Y%m%d)
tar zcfp /root/D_LOG-$today.tar.gz *.log
rm -rf *.log
