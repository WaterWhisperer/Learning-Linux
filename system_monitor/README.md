# 系统监控工具

## 介绍

这是一个完善的系统监控工具，包含C++性能采集、Python可视化报告和Shell定时调度。主要功能包括：

- 实时监控CPU、内存和磁盘使用率
- 自动生成HTML可视化报告
- 历史数据统计和分析
- 阈值告警功能
- 定时任务自动调度

## 系统架构

```mermaid
graph LR
    A[定时任务调度] --> B[C++数据采集]
    B --> C[CSV数据文件]
    C --> D[Python可视化]
    D --> E[HTML报告]
    E --> F[告警通知]
```

## 功能增强

1. **CPU使用率计算优化**：使用文件保存状态，解决独立进程计算问题
2. **健壮性提升**：添加错误处理和日志管理
3. **告警功能**：支持设置阈值并发送告警通知
4. **配置文件**：支持自定义数据文件路径、日志目录和告警阈值
5. **增强报告**：
   - 24小时数据对比
   - 统计信息（最大值、最小值、平均值）
   - 最新指标表格
6. **定时任务设置脚本**：简化cron任务配置

## 使用说明

### 安装依赖

```bash
# Debian/Ubuntu
sudo apt update
sudo apt install g++ python3-pip

# CentOS/RHEL
sudo yum groupinstall "Development Tools"
sudo yum install python3-pip

# 安装Python依赖（指定兼容版本）
pip3 install pandas seaborn matplotlib==3.7.0
```

### 编译监控程序

```bash
g++ -o system_monitor system_monitor.cpp
```

### 配置监控参数

编辑 `monitor.conf` 文件自定义设置：

```bash
# 系统监控配置
DATA_FILE="system_metrics.csv"
LOG_FILE="monitor.log"
REPORT_DIR="reports"
MAX_DATA_POINTS=1440
ALERT_THRESHOLD=90
# ALERT_RECIPIENT="admin@example.com"
```

### 手动运行监控

```bash
chmod +x check_dependencies.sh monitor.sh
./monitor.sh
```

### 设置定时任务

```bash
chmod +x setup_cron.sh
./setup_cron.sh

# 验证定时任务
crontab -l
```

### 部署步骤

1. **进入项目目录**：

   ```bash
   cd system_monitor
   ```

2. **添加执行权限**：

   ```bash
   chmod +x check_dependencies.sh monitor.sh setup_cron.sh
   ```

3. **安装依赖**：

   ```bash
   # Debian/Ubuntu
   sudo apt update
   sudo apt install g++ python3-pip

   # CentOS/RHEL
   sudo yum groupinstall "Development Tools"
   sudo yum install python3-pip

   pip3 install pandas seaborn matplotlib==3.7.0
   ```

4. **测试运行**：

   ```bash
   ./monitor.sh
   ```

5. **设置定时任务**：

   ```bash
   ./setup_cron.sh
   ```

6. **验证定时任务**：

   ```bash
   crontab -l
   ```

### 查看报告

报告将保存在 `reports/` 目录下，按时间戳命名。可直接在浏览器中打开HTML文件。

## 部署注意事项

1. **权限问题**：

   - 确保 cron 服务有权限执行脚本
   - 建议使用 `visudo` 添加免密 sudo 权限：

     ```bash
     youruser ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart crond
     youruser ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart cron
     ```

2. **存储空间**：

   - 默认保留 24 小时数据（1440 个点）
   - 调整 `MAX_DATA_POINTS` 可延长/缩短历史数据

3. **邮件告警**：

   - 取消 `monitor.conf` 中 `ALERT_RECIPIENT` 注释
   - 安装配置 `mailutils`/`sendmail`

## 目录结构

```plaintext
system_monitor/
├── check_dependencies.sh # 依赖检查脚本
├── generate_report.py    # 报告生成脚本
├── monitor.conf          # 配置文件
├── monitor.sh            # 主监控脚本
├── README.md             # 项目文档
├── reports/              # 报告输出目录
├── setup_cron.sh         # 定时任务设置脚本
└── system_monitor.cpp    # 数据采集程序
```
