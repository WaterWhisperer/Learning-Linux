#!/bin/bash

# 设置定时任务每分钟执行监控脚本

# 获取当前目录绝对路径
PROJECT_DIR=$(cd "$(dirname "$0")" && pwd)

# 创建日志目录
mkdir -p "$PROJECT_DIR/logs"

# 配置定时任务
CRON_JOB="* * * * * cd $PROJECT_DIR && ./monitor.sh >> $PROJECT_DIR/logs/cron.log 2>&1"

# 检查是否已存在定时任务
if crontab -l | grep -q "$PROJECT_DIR/monitor.sh"; then
    echo "定时任务已存在，无需重复添加"
else
    # 添加定时任务
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    if [ $? -eq 0 ]; then
        echo "定时任务添加成功：每分钟执行监控脚本"
    else
        echo "添加定时任务失败" >&2
        exit 1
    fi
fi

# 重启cron服务
sudo systemctl restart cron

echo "定时任务设置完成"
echo "监控日志将保存到: $PROJECT_DIR/logs/cron.log"
echo -e "\n定时任务管理命令："
echo "启动监控: ./setup_cron.sh"
echo "停止监控: ./stop_cron.sh"
