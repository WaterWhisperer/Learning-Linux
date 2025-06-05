#!/bin/bash

# 系统监控工具 - 停止定时任务脚本

echo "正在停止定时监控任务..."
crontab -l | grep -v "$(pwd)/monitor.sh" | crontab -

if [ $? -eq 0 ]; then
    echo "定时任务已成功停止"
    echo "剩余定时任务："
    crontab -l
else
    echo "停止定时任务失败"
    exit 1
fi
