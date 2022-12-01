#!/bin/bash
wall "#Architecture : $(uname -a)
#CPU physical : $(lscpu | awk '{if(NR==5) print $2}')
#vCPU : $(lscpu | awk '{if(NR==8) CNB=$NF; if(NR==7) TNB=$NF;} END{print CNB * TNB}')
#Memory Usage : $(vmstat -s -S m | awk '{if(NR==1) TOT=$1;if(NR==2) USD=$1; if(NR==5) AVB=$1; PERC=USD*100/TOT} END{printf "%d/%dMB (%.2f%%)",USD,AVB,PERC}')
#Disk Usage : $(df -Bg | grep LVM | awk '{USD+=$3*1024; AVB+=$4; PERC+=$5;} END{printf "%d/%dGB (%d%%)\n",USD,AVB,PERC}')
#CPU load : $(mpstat | awk '{if(NR==4) SYS=$6;} END{printf"%.1f%%",$SYS}')
#Last boot : $(who -b | awk '{if(NR==1) DATE=$3; TIME=$4;} END{print DATE,TIME}')
#LVM use : $(lsblk | grep lvm | awk '{if($1) print "yes";exit;}')
#Connections TCP : $(netstat | grep ESTABLISHED | wc -l | awk '{if($1 != 0) print $1,"ESTABLISHED";exit;}')
#User log : $(who | wc -l)
#Network : $(/sbin/ifconfig | awk '{if(NR==2) IP=$2;if(NR==4) MAC=$2;} END{ print "IP",IP,"("MAC")"}')
#Sudo : $(journalctl _COMM=sudo | grep COMMAND | wc -l | awk '{if($1) printf "%d cmd",$1}')"
