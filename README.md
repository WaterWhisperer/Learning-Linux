# OpenCamp Learning Linux Camp 2025 - 项目代码仓库

## 项目背景
本仓库是我在 **OpenCamp Learning Linux Camp 2025** Linux训练营学习过程中完成的所有代码和项目实践。通过此项目系统学习了Linux系统管理、Shell脚本编写、定时任务配置及Nginx部署等核心技能。

---

## 训练营内容
- **学习目标**：
  - 掌握Linux基础命令与脚本编写
  - 实现自动化网站监控与报告系统
  - 熟悉Nginx服务器配置与管理
- **项目阶段**：
  - 阶段1：Shell脚本编写（`monitor.sh`）
  - 阶段2：报告生成与Web界面部署（`generate_report.sh`）
  - 阶段3：Cron定时任务配置（`setup_cron.sh`）

---

## 项目结构
 项目位于`website-monitor/`目录下
```plaintext
├── scripts/
│   ├── monitor.sh       # 核心监控脚本（检查网站状态）
│   ├── generate_report.sh  # 日报生成脚本
│   └── setup_cron.sh    # 定时任务配置脚本
├── config.txt           # 监控目标配置文件
├── logs/                # 日志目录
├── reports/             # 日报目录
└── www/                 # Nginx静态网页文件
```

---

## 训练营链接
- [OpenCamp Learning Linux Camp 2025](https://opencamp.ai/Linux/camp/2025)
