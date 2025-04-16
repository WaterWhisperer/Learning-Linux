#!/bin/zsh

CONFIG_FILE="/home/water/桌面/Learn/Linux/website-monitor/config.txt"
LOG_DIR="logs"
DATA_DIR="data"

# 读取配置文件
while read -r line; do
  # 跳过注释行和空行
  [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue

  # 提取网站名称和URL
  site_name=$(echo "$line" | awk '{print $1}')
  site_url=$(echo "$line" | awk '{print $2}')

  # 创建网站目录（如果不存在）
  mkdir -p "$LOG_DIR/$site_name"

  # 发送HTTP请求并记录结果
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  response=$(curl -o /dev/null -s -w "%{http_code} %{time_total}" "$site_url")
  status_code=$(echo "$response" | awk '{print $1}')
  response_time=$(echo "$response" | awk '{print $2}')

  # 记录到网站目录的status.log
  echo "$timestamp $status_code" >> "$LOG_DIR/$site_name/status.log"

  # 记录到all_checks.log
  echo "$timestamp $site_name $status_code $response_time" >> "all_checks.log"

  # 非2xx/3xx状态码触发告警
  if [[ ! "$status_code" =~ ^[23][0-9]{2}$ ]]; then
    echo "警告：$site_name $status_code" >> "$LOG_DIR/$site_name/alerts.log"
  fi
done < "$CONFIG_FILE"
