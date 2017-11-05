#!/bin/bash
image_path=.
partations=(splloader sml trustos uboot boot recovery system cache userdata prodnv vendor)
images=(u-boot-spl-16k-sign.bin sml-sign.bin tos-sign.bin u-boot-sign.bin boot.img recovery.img system.img cache.img userdata.img prodnv.img vendor.img)
function rebootIntoFastboot(){
	rs_adb=`adb devices | grep "device$"`
	if [ ! "x$rs_adb" == "x" ];then
		adb reboot bootloader
	fi
}

function IsInFastboot(){
	echo -e "Waiting for devices reboot.\c"

	rs_fst=`fastboot devices`
	while [ "x$rs_fst" == "x" ];
	do 
		sleep 1
		rs_fst=`fastboot devices | grep "fastboot$"`
		echo -e ".\c"
	done
	echo -e ""
	echo -e "\033[32m\tStart flashing ... \033[0m"
}

function flashPartation(){
	fastboot flashing unlock
	part_num=${#partations[@]}
	for ((i=0;i<$part_num ;i++))
	do
		echo -e "\n\033[32m\tWaiting for fastboot flash ${partations[i]} ${images[i]} ! \033[0m\n"
		if [ -f $image_path/${images[i]} ];then
			if [ ! "${partations[i]}" == "system" ];then
				fastboot flash ${partations[i]} $image_path/${images[i]}
				result=$?
				if [[ $result -eq 0 ]];then
					echo -e "\n\033[32m\tfastboot flash ${partations[i]} ${images[i]} succeed! \033[0m\n"
				else
					echo -e "\n\033[31m\tfastboot flash ${partations[i]} ${images[i]} failed! \033[0m\n"
				fi
			else
				fastboot flash -S 10M ${partations[i]} $image_path/${images[i]}
				result=$?
				if [[ $result -eq 0 ]];then
					echo -e "\n\033[32m\tfastboot flash ${partations[i]} ${images[i]} succeed! \033[0m\n"
				else
					echo -e "\n\033[31m\tfastboot flash ${partations[i]} ${images[i]} failed! \033[0m\n"
				fi
			fi
		else
			echo -e "\n\033[31m\tThe file $image_path/${images[i]} isn't exit! \033[0m\n"
		fi
	done
	result=`fastboot flashing lock`
	result=`fastboot -w`
	result=`fastboot reboot`
	echo -e "\n\033[32m\tFlashing Succeed. Reboot Now. \033[0m\n"
}

function main(){
	rebootIntoFastboot
	IsInFastboot
	flashPartation
}

main $?
