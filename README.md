# OpenCamp 2025 - Learning Linux & Git Camp 综合项目仓库

## 项目背景

本仓库整合了我在 **OpenCamp Learning Linux Camp 2025** 和 **Learning Git Camp 2025** 学习过程中完成的所有代码和项目实践，包含：

- Linux系统管理、Shell脚本编写、定时任务配置及Nginx部署等核心技能
- Git版本控制工作流实践与协作开发项目
- 双训练营完整的学习演进历史记录

---

## 训练营内容

### Linux 训练营

- **学习目标**：
  - 掌握Linux基础命令与Shell脚本编写
  - 实现自动化网站监控与报告系统
  - 熟悉Nginx服务器配置与管理
- **项目阶段**：
  - 阶段1：Shell脚本编写（`monitor.sh`）
  - 阶段2：报告生成与Web界面部署（`generate_report.sh`）
  - 阶段3：Cron定时任务配置（`setup_cron.sh`）

### Git 训练营

- **核心技能**：
  - Git工作流（分支/合并/冲突解决）
  - 开源项目协作开发实践
  - GitHub Actions自动化

---

## 项目结构

自动化网站监控与报告系统项目位于`Learning_Linux/website-monitor`目录下

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

- [OpenCamp Learning Linux Camp 2025](https://opencamp.ai/Linux/camp/2025?lang=zh_CN)
- [OpenCamp Learning Git Camp 2025](https://opencamp.ai/Git/camp/2025?lang=zh_CN)
