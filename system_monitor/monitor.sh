#!/bin/bash

# 启用错误检查和详细日志
set -euo pipefail

# 加载配置文件
CONFIG_FILE="monitor.conf"
[ -f "$CONFIG_FILE" ] && source "$CONFIG_FILE"

# 检查依赖
echo "检查系统依赖..." >> "$LOG_FILE"
./check_dependencies.sh >> "$LOG_FILE" 2>&1 || {
    echo "依赖检查失败，请检查日志！" >> "$LOG_FILE"
    exit 1
}

# 配置参数
DATA_FILE=${DATA_FILE:-"system_metrics.csv"}
LOG_FILE=${LOG_FILE:-"monitor.log"}
REPORT_DIR=${REPORT_DIR:-"reports"}
MAX_DATA_POINTS=${MAX_DATA_POINTS:-1440}  # 默认保留1天的数据
ALERT_THRESHOLD=${ALERT_THRESHOLD:-90}    # 默认告警阈值
ALERT_RECIPIENT=${ALERT_RECIPIENT:-""}    # 告警接收人

# 创建目录
mkdir -p "$REPORT_DIR"

# 记录开始时间
echo "[$(date +'%Y-%m-%d %H:%M:%S')] 开始系统监控任务" >> "$LOG_FILE"

# 编译C++监控程序（如果未编译）
if [ ! -f system_monitor ]; then
    echo "编译监控程序..." >> "$LOG_FILE"
    g++ -o system_monitor system_monitor.cpp || {
        echo "监控程序编译失败!" >> "$LOG_FILE"
        exit 1
    }
fi

# 运行监控程序
echo "运行监控程序..." >> "$LOG_FILE"
./system_monitor >> "$LOG_FILE" 2>&1 || {
    echo "监控程序执行失败!" >> "$LOG_FILE"
    exit 1
}

# 数据维护（限制文件大小）
if [ -f "$DATA_FILE" ]; then
    echo "维护数据文件..." >> "$LOG_FILE"
    tail -n "$MAX_DATA_POINTS" "$DATA_FILE" > "$DATA_FILE.tmp"
    mv "$DATA_FILE.tmp" "$DATA_FILE"
else
    echo "警告: 数据文件 $DATA_FILE 不存在" >> "$LOG_FILE"
fi

# 生成报告
echo "生成报告..." >> "$LOG_FILE"
python3 generate_report.py >> "$LOG_FILE" 2>&1 || {
    echo "报告生成失败!" >> "$LOG_FILE"
    exit 1
}

# 归档报告
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
mv system_report.html "$REPORT_DIR/report_$TIMESTAMP.html"
mv system_metrics.png "$REPORT_DIR/metrics_$TIMESTAMP.png"

echo "[$(date +'%Y-%m-%d %H:%M:%S')] 监控任务完成" >> "$LOG_FILE"

# 简单告警检查
if [ -f "$DATA_FILE" ]; then
    LAST_METRICS=$(tail -1 "$DATA_FILE")
    CPU_USAGE=$(echo "$LAST_METRICS" | cut -d',' -f2)
    MEM_USAGE=$(echo "$LAST_METRICS" | cut -d',' -f3)
    DISK_USAGE=$(echo "$LAST_METRICS" | cut -d',' -f4)

    alert_message=""
    if (( $(echo "$CPU_USAGE > $ALERT_THRESHOLD" | bc -l) )); then
        alert_message+="CPU使用率过高: ${CPU_USAGE}% "
    fi
    if (( $(echo "$MEM_USAGE > $ALERT_THRESHOLD" | bc -l) )); then
        alert_message+="内存使用率过高: ${MEM_USAGE}% "
    fi
    if (( $(echo "$DISK_USAGE > $ALERT_THRESHOLD" | bc -l) )); then
        alert_message+="磁盘使用率过高: ${DISK_USAGE}% "
    fi
    
    if [ -n "$alert_message" ]; then
        echo "[告警] $alert_message" >> "$LOG_FILE"
        # 这里可以添加邮件或通知发送逻辑
        if [ -n "$ALERT_RECIPIENT" ]; then
            echo "发送告警通知给: $ALERT_RECIPIENT" >> "$LOG_FILE"
            # 实际发送通知的命令需要根据系统配置
            # echo "系统告警: $alert_message" | mail -s "系统监控告警" "$ALERT_RECIPIENT"
        fi
    fi
else
    echo "警告: 无法检查告警，数据文件不存在" >> "$LOG_FILE"
fi
