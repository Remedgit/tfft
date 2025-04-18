#!/bin/bash
echo -e "\033[0;31mt\033[0;32mf\033[0;33mf\033[0;34mt\033[0;36m v0.1 testversion"
echo -e
sleep 1
# 读取UPDATE路径这一块
echo -e "\033[0;33m输入UPDATE文件路径:"
read -r UPDATE_FILE
if [ -z "$UPDATE_FILE" ]; then
    echo "\033[0;31m[+] 未输入文件路径！"
    exit 1
fi
export UPDATE_FILE
echo -e "\033[0;32m[+] UPDATE文件路径已设置为: $UPDATE_FILE"
# 读取PTABLE路径这一块
echo -e "\033[0;33m输入PTABLE文件路径:"
read -r PTABLE_FILE
if [ -z "$PTABLE_FILE" ]; then
    echo "\033[0;31m[+] 未输入文件路径！"
    exit 1
fi
export PTABLE_FILE
echo -e "\033[0;32m[+] PTABLE文件路径已设置为: $PTABLE_FILE"
# 刷入PTABLE这一块
if [ -f "$PTABLE_FILE" ]; then
    echo -e "[+] 找到文件: $PTABLE_FILE"
    python3 bin/splituapp.py -f $PTABLE_FILE
    cd tfft_tmp
    #删除无法刷入的分区&修复erec刷入失败
    echo -e "\033[0;36m[+] 修复刷机包"
    rm -rf sha256rsa.img
    rm -rf crc.img
    rm -rf base_verlist.img
    rm -rf base_ver.img
    rm -rf package_type.img
    mv erecovery_ramdis.img erecovery_ramdisk.img 
    echo -e "\033[0;36m正在刷入分区: ptable, 文件: hisiufs_gpt"
    fastboot flash ptable hisiufs_gpt.img
    echo
    echo -e "\033[0;32m[+] 分区 ptable 刷入成功！\033[0m"
    rm -rf hisiufs_gpt.img
    for img_file in *.img; do
        # 获取分区名（去掉 .img 后缀）
        partition_name="${img_file%.img}"
        # 调用 fastboot 刷入分区
        echo -e "\033[0;36m正在刷入分区: $partition_name, 文件: $img_file"
        fastboot flash "$partition_name" "$img_file"
        # 检查命令是否成功
        if [ $? -eq 0 ]; then
            echo -e
            echo -e "\033[0;32m[+] 分区 $partition_name 刷入成功！\033[0m"
        else
            echo -e
            echo -e "\033[0;31m[+] 分区 $partition_name 刷入失败！\033[0m"
        fi
    done
    cd ..
    echo -e "\033[0;32m[+] PTABLE刷入完毕"
    rm -rf tfft_tmp
else
    echo -e "\033[0;31m[+] 未找到文件: $PTABLE_FILE \033[0m"
fi
# 刷入UPDATE这一块
if [ -f "$UPDATE_FILE" ]; then
    echo -e "[+] 找到文件: $UPDATE_FILE"
    echo -e "[+] 开始分解UPDATE"
    python3 bin/splituapp.py -f $UPDATE_FILE
    cd tfft_tmp
    #删除无法刷入的分区&修复erec刷入失败
    echo -e "\033[0;36m[+] 修复刷机包"
    rm -rf sha256rsa.img
    rm -rf crc.img
    rm -rf base_verlist.img
    rm -rf base_ver.img
    rm -rf package_type.img
    mv erecovery_ramdis.img erecovery_ramdisk.img 
    echo -e "\033[0;36m正在刷入分区: ptable, 文件: hisiufs_gpt"
    fastboot flash ptable hisiufs_gpt.img
    echo
    echo -e "\033[0;32m[+] 分区 ptable 刷入成功！\033[0m"
    rm -rf hisiufs_gpt.img
    for img_file in *.img; do
        # 获取分区名（去掉 .img 后缀）
        partition_name="${img_file%.img}"
        # 调用 fastboot 刷入分区
        echo -e "\033[0;36m正在刷入分区: $partition_name, 文件: $img_file"
        fastboot flash "$partition_name" "$img_file"
        # 检查命令是否成功
        if [ $? -eq 0 ]; then
            echo -e
            echo -e "\033[0;32m[+] 分区 $partition_name 刷入成功！\033[0m"
        else
            echo -e
            echo -e "\033[0;31m[+] 分区 $partition_name 刷入失败！\033[0m"
        fi
    done
    cd ..
    echo -e "\033[0;32m[+] UPDATE刷入完毕"
    rm -rf tfft_tmp
else
    echo -e "\033[0;31m[+] 未找到文件: $PTABLE_FILE \033[0m"
fi
