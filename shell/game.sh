#!/bin/zsh

echo "请输入您的姓名："
read name
#name=$1
#channel=$2
echo "您好，$name，欢迎来到猜数字！"
number=$(shuf -i 1-10 -n 1)
#echo $number
while true
do
echo "请输入一个1-10之间的数字"
read guess
if [[ $guess -eq $number ]]; then
    echo "恭喜你猜对了！是否继续？ (y/n) :"
    read choice
    if [[ $choice = "y" ]] || [[ $choice = "Y" ]]; then
        number=$((RANDOM % 10 + 1))
#        echo $number
        continue
    else
        break
    fi
elif [[ $guess -lt $number ]]; then
    echo "小了"
else
    echo "大了"
fi
done
