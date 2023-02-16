#!/bin/bash
CODE(){
echo -e '\033[36m'$*'\033[0m'
} >> $RESULT
echo "                                                                           "
echo "   .d8888b.  8888888b.   .d88888b.  888     888 8888888b.        .d8888b.   "
echo "  d88P  Y88b 888   Y88b d88P   Y88b 888     888 888   Y88b      d88P  Y88b  "
echo "  888    888 888    888 888     888 888     888 888    888             888  "
echo "  888        888   d88P 888     888 888     888 888   d88P           .d88P  "
echo "  888  88888 8888888P   888     888 888     888 8888888PP        .od888PP   "
echo "  888    888 888 T88b   888     888 888     888 888             d88P        "
echo "  Y88b  d88P 888  T88b  Y88b. .d88P Y88b. .d88P 888             888         "
echo "   YY8888P   888   T88b   Y88888P     Y88888P   888             8888888888  "
echo "                                                                          " 
echo "  +======================================================================+ "
echo "  |                         리눅스 점검 스크립트                         | "
echo "  |                       +---------menu---------+                       | "
echo "  |                       | 1.일일 점검 스크립트 |                       | "
echo "  |                       | 2.주간 점검 스크립트 |                       | "
echo "  |                       | 3.월간 점검 스크립트 |                       | "
echo "  |                       +----------------------+                       | "
echo "  +======================================================================+ "

# Print the menu
echo "  |                                                                      | "
echo "  |                         옵션을 선택해주세용                          | "
echo "  |                   1. 중요도 (상)일일 점검 스크립트                   | "
echo "  |                   2. 중요도 (중)주간 점검 스크립트                   | "
echo "  |                   3. 중요도 (하)월간 점검 스크립트                   | "
echo "  |                                                                      | "
echo "  +======================================================================+ "

# Read the user's choice
read -p "Enter your choice (1번, 2번, 3번): " choice

# Handle the user's choice
case $choice in
  1)
    source /root/Check_Scripts/1.Daily_Check.sh
    ;;
  2)
    source /root/Check_Scripts/2.Weekly_Check.sh
    ;;
  3)
    source /root/Check_Scripts/3.Monthly_Check.sh
    ;;
  *)
    echo "Invalid choice. Please select 1, 2, 3."
    ;;
esac
