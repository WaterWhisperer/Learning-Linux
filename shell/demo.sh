#!/bin/bash
# 这是一个用于演示和学习的 shell 脚本示例

# -------------------------
# 变量定义和基本输出
# -------------------------
greeting="Hello"
name="World"
echo "$greeting, $name!"

# -------------------------
# 条件判断示例
# -------------------------
if [ "$name" == "World" ]; then
    echo "欢迎来到Shell编程示例!"
else
    echo "你好，$name!"
fi

# -------------------------
# 循环示例：打印1到5的数字
# -------------------------
echo "打印1到5的数字:"
for i in {1..5}; do
    echo "数字: $i"
done

# -------------------------
# 函数示例
# -------------------------
say_hello() {
    echo "函数被调用，输出: Hello from the function!"
}
# 调用函数
say_hello

# -------------------------
# 命令行参数示例
# -------------------------
if [ $# -gt 0 ]; then
    echo "传入的第一个参数是: $1"
else
    echo "没有传入命令行参数"
fi

# -------------------------
# 读取用户输入示例
# -------------------------
read -p "请输入你的名字: " user_name
echo "你好，$user_name!"

# -------------------------
# 使用管道和grep示例
# -------------------------
echo "当前目录中的 .sh 文件列表:"
ls | grep "\.sh$"

echo "脚本执行完毕."
