#!/usr/bin/env bash
clear
set -e
clear
function header_info {
echo -e "Change CPU Scaling Governor"
}
show_menu(){
    CL=`echo "\033[m"`
    GN=`echo "\033[32m"`
    BL=`echo "\033[36m"`
    YW=`echo "\033[33m"`
    fgred=`echo "\033[31m"`
header_info
    CK=$(uname -r)
    IP=$(hostname -I)
#    MAC=$(cat /sys/class/net/eno1/address)
    ACSG=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors)
    CCSG=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
    echo -e "${YW}Proxmox IP: ${BL}${IP}${CL}"
#    echo -e "${YW}MAC Address ${BL}${MAC}${CL}"
    echo -e "${YW}Current Kernel: ${BL}${CK}${CL}"

    echo -e "\n${YW}Available CPU Scaling Governors:
    ${BL}${ACSG}${CL}"

    echo -e "\n${YW}Current CPU Scaling Governor:
    ${BL}${CCSG}${CL}"
    printf "\n ${fgred}Only select available CPU Scaling Governors from above${CL}\n \n"
    printf "${YW} 1)${GN} Switch to ${BL}conservative${CL}${GN} CPU Scaling Governor (Scales the frequency dynamically according to current load (more gradually than ${BL}ondemand${CL}${GN}))${CL}\n"
    printf "${YW} 2)${GN} Switch to ${BL}ondemand${CL}${GN} CPU Scaling Governor     (Scales the frequency dynamically according to current load)${CL}\n"
    printf "${YW} 3)${GN} Switch to ${BL}userspace${CL}${GN} CPU Scaling Governor    (Run the CPU at user specified frequencies,)${CL}\n"
    printf "${YW} 4)${GN} Switch to ${BL}powersave${CL}${GN} CPU Scaling Governor    (Run the CPU at the minimum frequency) ${CL}\n"
    printf "${YW} 5)${GN} Switch to ${BL}performance${CL}${GN} CPU Scaling Governor  (Run the CPU at the maximum frequency) ${CL}\n"
    printf "${YW} 6)${GN} Switch to ${BL}schedutil${CL}${GN} CPU Scaling Governor ${CL}\n"
    printf "${YW} 7)${GN} Exit ${CL}\n"
    printf "\n ${fgred}NOTE: The CPU Scaling Governor will be reset to default (${BL}performance${CL}${fgred}) after reboot${CL}\n"
    printf "\n Please choose a number from the menu and press [ENTER]"
    printf "\n What do you choose? "
    read opt
}
clear
show_menu
while [ $opt != '' ]
    do
    if [ $opt = '' ]; then
      exit;
    else
      case $opt in
        1) echo "conservative" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
            clear
            show_menu
        ;;
        2) echo "ondemand" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
            clear
            show_menu
        ;;
        3) echo "userspace" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
            clear
            show_menu
        ;;
        4) echo "powersave" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
            clear
            show_menu
        ;;
        5) echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
            clear
            show_menu
        ;;
        6) echo "schedutil" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
            clear
            show_menu
        ;;
        7)  clear
            exit
        ;;
        x)
            clear
            exit
        ;;
        \n)exit;
        ;;
        *)clear;
            show_menu;
        ;;
      esac
    fi
  done
