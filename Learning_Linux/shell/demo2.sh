#!/bin/bash
# demo2.sh - 一个综合示例脚本
# 演示函数、条件判断、循环、用户输入、数组、变量等

# 打印欢迎信息
echo "欢迎使用综合 Bash 脚本示例！"

# 定义一个函数，显示一个问候信息
greet() {
  echo "你好，$1！"
}

# 调用函数，使用命令行参数 $1（如果传入了参数）
if [ -n "$1" ]; then
  greet "$1"
else
  # 如果未传入参数，提示用户输入名字
  read -p "请输入你的名字: " username
  greet "$username"
fi

# 演示条件判断
num=10
if [ $num -gt 5 ]; then
  echo "$num 大于 5"
else
  echo "$num 小于或等于 5"
fi

# 演示 for 循环与数组
colors=("红色" "绿色" "蓝色" "黄色")
echo "数组 colors 包含以下颜色："
for color in "${colors[@]}"; do
  echo " - $color"
done

# 演示 while 循环
echo "从 1 数到 5："
count=1
while [ $count -le 5 ]; do
  echo "计数: $count"
  ((count++))
done

# 演示函数返回值的使用（注意：bash 中函数只能返回退出码）
calculate_sum() {
  local a=$1
  local b=$2
  local sum=$((a + b))
  echo "$sum"  # 通过标准输出返回计算结果
}
# 读取两个数字并求和
read -p "请输入第一个数字: " num1
read -p "请输入第二个数字: " num2
result=$(calculate_sum "$num1" "$num2")
echo "数字 $num1 和 $num2 的和是: $result"

echo "脚本执行完毕。"
