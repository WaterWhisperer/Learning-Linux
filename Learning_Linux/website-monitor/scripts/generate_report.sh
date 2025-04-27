#!/bin/zsh

REPORT_DIR="reports"
LOG_DIR="logs"
TODAY=$(date +"%Y-%m-%d")

# 创建报告文件
REPORT_FILE="$REPORT_DIR/daily_report_$TODAY.txt"
echo "网站监控日报告：$TODAY" > "$REPORT_FILE"
echo "---" >> "$REPORT_FILE"

# 统计可用性摘要
echo "网站可用性摘要：" >> "$REPORT_FILE"
# 仅遍历 logs 下的子目录（网站目录）
for site_dir in "$LOG_DIR"/*/; do
  site_name=$(basename "$site_dir")
  # 确保 status.log 存在
  if [ -f "$site_dir/status.log" ]; then
    grep "$TODAY" "$site_dir/status.log" | awk '{print $3}' | sort | uniq -c | awk '{print "'$site_name'", $2, "出现次数:", $1}' >> "$REPORT_FILE"
  fi
done

# 提取昨日告警
echo "异常情况：" >> "$REPORT_FILE"
find "$LOG_DIR" -name "alerts.log" -exec grep "$(date -d "yesterday" +"%Y-%m-%d")" {} \; >> "$REPORT_FILE"
