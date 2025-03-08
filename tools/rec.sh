#!/bin/bash
echo -e "\033[0;33m[+] 请选择刷入的Recovery"
echo -e "\033[0;33m1.麒麟通用奇兔 2.麒麟通用官方TWRP3"
read -r REC_TYPE
case $REC_TYPE in
    1)
        fastboot flash recovery_ramdisk ../raw/kirin7to.img
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m[+] Recovery 分区刷入成功！"
        else
            echo -e "\033[0;31m[+] Recovery 分区刷入失败！"
        fi
        ;;
    2)
        fastboot flash recovery_ramdisk ../twrp3.img
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m[+] Recovery 分区擦除成功！"
        else
            echo -e "\033[0;31m[+] Recovery 分区擦除失败！"
        fi
        ;;
    *)
        echo -e "\033[0;32m[+] 错误：无效的输入！请输入 1 或 2。"
        exit 1
        ;;
esac
