#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <sys/sysinfo.h>
#include <sys/statvfs.h> // 添加 statvfs 头文件
#include <chrono>
#include <iomanip>
#include <unistd.h>
#include <map>

using namespace std;

// 获取当前时间戳 (ISO 8601格式)
string get_timestamp() {
    auto now = chrono::system_clock::now();
    auto in_time_t = chrono::system_clock::to_time_t(now);
    stringstream ss;
    ss << put_time(gmtime(&in_time_t), "%Y-%m-%dT%H:%M:%SZ");
    return ss.str();
}

// 获取CPU利用率
double get_cpu_usage() {
    const char* state_file = "cpu_state.txt";
    long prev_idle = 0, prev_total = 0;

    // 读取状态文件
    ifstream state_in(state_file);
    if (state_in) {
        state_in >> prev_idle >> prev_total;
        state_in.close();
    }

    // 读取当前/proc/stat
    ifstream file("/proc/stat");
    string line;
    getline(file, line);
    istringstream iss(line);
    string cpu;
    long user, nice, system, idle, iowait, irq, softirq;
    iss >> cpu >> user >> nice >> system >> idle >> iowait >> irq >> softirq;
    
    long total = user + nice + system + idle + iowait + irq + softirq;
    long idle_time = idle + iowait;
    
    double usage = 0.0;
    if (prev_total > 0) {
        long diff_total = total - prev_total;
        long diff_idle = idle_time - prev_idle;
        usage = 100.0 * (diff_total - diff_idle) / diff_total;
    }
    
    // 保存当前状态
    ofstream state_out(state_file);
    if (state_out) {
        state_out << idle_time << " " << total;
        state_out.close();
    }
    
    return usage;
}

// 获取内存利用率
double get_mem_usage() {
    struct sysinfo mem_info;
    sysinfo(&mem_info);
    double total = mem_info.totalram;
    double free = mem_info.freeram;
    return 100.0 * (total - free) / total;
}

// 获取磁盘利用率
double get_disk_usage() {
    struct statvfs disk_data;
    statvfs("/", &disk_data);
    double total = disk_data.f_blocks * disk_data.f_frsize;
    double free = disk_data.f_bfree * disk_data.f_frsize;
    return 100.0 * (total - free) / total;
}

int main() {
    // 获取系统指标
    string timestamp = get_timestamp();
    double cpu_usage = get_cpu_usage();
    double mem_usage = get_mem_usage();
    double disk_usage = get_disk_usage();

    // 写入CSV文件
    ofstream data_file("system_metrics.csv", ios::app);
    if (data_file.is_open()) {
        data_file << timestamp << "," 
                  << fixed << setprecision(2) << cpu_usage << ","
                  << mem_usage << ","
                  << disk_usage << "\n";
        data_file.close();
    } else {
        cerr << "Error opening data file!" << endl;
        return 1;
    }
    
    return 0;
}
