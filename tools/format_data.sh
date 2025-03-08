#!/bin/bash
echo -e "\033[0;33m[+] 即将重启到Recovery进行低级格式化"
fastboot flash misc ../raw/lowlevel
fastboot reboot
