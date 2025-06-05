import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime, timedelta, timezone
import os
import pytz

def generate_report():
    # 检查数据文件是否存在
    if not os.path.exists('system_metrics.csv'):
        print("错误: 数据文件不存在")
        return
    
    try:
        # 读取数据
        df = pd.read_csv('system_metrics.csv', 
                         names=['timestamp', 'cpu', 'memory', 'disk'])
    except pd.errors.EmptyDataError:
        print("错误: 数据文件为空")
        return
    
    # 转换时间戳并确保使用UTC时区
    df['timestamp'] = pd.to_datetime(df['timestamp'], utc=True)
    df['time'] = df['timestamp'].dt.strftime('%H:%M')
    
    # 创建图表 - 使用3列布局
    plt.figure(figsize=(16, 10))
    sns.set_style("darkgrid")
    
    # 获取最近24小时数据（使用UTC时区）
    utc = pytz.UTC
    now = datetime.now(utc)
    one_day_ago = now - timedelta(days=1)
    recent_df = df[df['timestamp'] >= one_day_ago]
    
    # 主图表：全部数据
    plt.subplot(2, 3, 1)
    sns.lineplot(x='timestamp', y='cpu', data=df, color='royalblue')
    plt.title('CPU Usage History')
    plt.ylim(0, 100)
    plt.xticks(rotation=45)
    
    plt.subplot(2, 3, 2)
    sns.lineplot(x='timestamp', y='memory', data=df, color='green')
    plt.title('Memory Usage History')
    plt.ylim(0, 100)
    plt.xticks(rotation=45)
    
    plt.subplot(2, 3, 3)
    sns.lineplot(x='timestamp', y='disk', data=df, color='purple')
    plt.title('Disk Usage History')
    plt.ylim(0, 100)
    plt.xticks(rotation=45)
    
    # 副图表：最近24小时数据
    plt.subplot(2, 3, 4)
    if not recent_df.empty:
        sns.lineplot(x='timestamp', y='cpu', data=recent_df, color='royalblue')
    plt.title('Last 24h CPU Usage')
    plt.ylim(0, 100)
    plt.xticks(rotation=45)
    
    plt.subplot(2, 3, 5)
    if not recent_df.empty:
        sns.lineplot(x='timestamp', y='memory', data=recent_df, color='green')
    plt.title('Last 24h Memory Usage')
    plt.ylim(0, 100)
    plt.xticks(rotation=45)
    
    plt.subplot(2, 3, 6)
    if not recent_df.empty:
        sns.lineplot(x='timestamp', y='disk', data=recent_df, color='purple')
    plt.title('Last 24h Disk Usage')
    plt.ylim(0, 100)
    plt.xticks(rotation=45)
    
    plt.tight_layout()
    plt.savefig('system_metrics.png')
    
    # 计算统计信息
    stats = {
        'max_cpu': df['cpu'].max(),
        'min_cpu': df['cpu'].min(),
        'avg_cpu': df['cpu'].mean(),
        'max_mem': df['memory'].max(),
        'min_mem': df['memory'].min(),
        'avg_mem': df['memory'].mean(),
        'max_disk': df['disk'].max(),
        'min_disk': df['disk'].min(),
        'avg_disk': df['disk'].mean()
    }
    
    # 生成HTML报告
    html_report = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>System Monitoring Report</title>
        <style>
            body {{ font-family: Arial, sans-serif; margin: 20px; }}
            h1 {{ color: #2c3e50; }}
            .report-info {{ margin-bottom: 20px; }}
            img {{ max-width: 100%; border: 1px solid #ddd; margin-bottom: 20px; }}
            table {{ border-collapse: collapse; width: 100%; margin-top: 20px; }}
            th, td {{ border: 1px solid #ddd; padding: 8px; text-align: left; }}
            th {{ background-color: #f2f2f2; }}
            .stats-container {{ display: flex; flex-wrap: wrap; gap: 20px; margin: 20px 0; }}
            .stat-card {{ background: #f8f9fa; border: 1px solid #dee2e6; border-radius: 5px; padding: 15px; min-width: 200px; }}
            .stat-card h3 {{ margin-top: 0; color: #495057; }}
            .stat-value {{ font-size: 1.5em; font-weight: bold; color: #343a40; }}
        </style>
    </head>
    <body>
        <h1>System Performance Report</h1>
        <div class="report-info">
            <p>Generated at: {datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M:%S')} UTC</p>
            <p>Data points: {len(df)}</p>
            <p>Time range: {df['timestamp'].min().strftime('%Y-%m-%d %H:%M')} - {df['timestamp'].max().strftime('%Y-%m-%d %H:%M')} UTC</p>
        </div>
        
        <img src="system_metrics.png" alt="System Metrics">
        
        <div class="stats-container">
            <div class="stat-card">
                <h3>CPU Usage</h3>
                <div class="stat-value">Max: {stats['max_cpu']:.2f}%</div>
                <div>Min: {stats['min_cpu']:.2f}%</div>
                <div>Avg: {stats['avg_cpu']:.2f}%</div>
            </div>
            <div class="stat-card">
                <h3>Memory Usage</h3>
                <div class="stat-value">Max: {stats['max_mem']:.2f}%</div>
                <div>Min: {stats['min_mem']:.2f}%</div>
                <div>Avg: {stats['avg_mem']:.2f}%</div>
            </div>
            <div class="stat-card">
                <h3>Disk Usage</h3>
                <div class="stat-value">Max: {stats['max_disk']:.2f}%</div>
                <div>Min: {stats['min_disk']:.2f}%</div>
                <div>Avg: {stats['avg_disk']:.2f}%</div>
            </div>
        </div>
        
        <h2>Latest Metrics (Last 10 entries)</h2>
        <table>
            <tr>
                <th>Timestamp (UTC)</th>
                <th>CPU (%)</th>
                <th>Memory (%)</th>
                <th>Disk (%)</th>
            </tr>
            {''.join(f'''
            <tr>
                <td>{row['timestamp'].strftime('%Y-%m-%d %H:%M:%S')}</td>
                <td>{row['cpu']:.2f}</td>
                <td>{row['memory']:.2f}</td>
                <td>{row['disk']:.2f}</td>
            </tr>
            ''' for _, row in df.tail(10).iterrows())}
        </table>
    </body>
    </html>
    """
    
    with open('system_report.html', 'w') as f:
        f.write(html_report)
    
    print("Report generated successfully!")

if __name__ == "__main__":
    generate_report()
