#!/bin/bash

# 系统监控工具 - 依赖检查脚本

# 检查Python依赖
echo "=== Python依赖检查 ==="
python3 -c "
import pandas, matplotlib, seaborn, pytz
print('依赖检查通过:')
print(f'pandas版本: {pandas.__version__}')
print(f'matplotlib版本: {matplotlib.__version__}')
print(f'seaborn版本: {seaborn.__version__}')
print(f'pytz版本: {pytz.__version__}')
" 2>/dev/null

if [ $? -ne 0 ]; then
    echo -e "\n错误: Python依赖未安装或版本不兼容"
    echo "请执行以下命令安装依赖:"
    echo "pip3 install pandas seaborn matplotlib==3.7.0"
    exit 1
fi

# 检查编译器
echo -e "\n=== 编译器检查 ==="
if command -v g++ &> /dev/null; then
    echo "g++ 已安装: $(g++ --version | head -n1)"
else
    echo "错误: g++ 未安装"
    echo "请执行:"
    echo "  Debian/Ubuntu: sudo apt install g++"
    echo "  CentOS/RHEL: sudo yum install gcc-c++"
    exit 1
fi

echo -e "\n所有依赖检查通过！"
