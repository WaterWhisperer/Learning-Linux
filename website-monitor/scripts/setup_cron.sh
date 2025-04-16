#!/bin/zsh

# 每15分钟运行监控脚本
(crontab -l 2>/dev/null; echo "*/15 * * * * $(pwd)/scripts/monitor.sh >> $(pwd)/logs/cron_monitor.log 2>&1") | crontab -

# 每天凌晨1点生成报告
(crontab -l 2>/dev/null; echo "0 1 * * * $(pwd)/scripts/generate_report.sh >> $(pwd)/logs/cron_report.log 2>&1") | crontab -
