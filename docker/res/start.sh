#!/bin/bash

DIRECTORY="wechatbot-provider-windows"

# 动态查找 python*** 目录并获取绝对路径
PYTHON_DIR=$(find /root/Desktop/install/ -type d -name "python*" | head -n 1)
if [ -z "$PYTHON_DIR" ]; then
    echo "Python directory not found in any directory matching python*"
    exit 1
fi

PYTHON_EXECUTABLE=$(realpath "$PYTHON_DIR/python.exe")
if [ ! -f "$PYTHON_EXECUTABLE" ]; then
    echo "Python executable not found at $PYTHON_EXECUTABLE"
    exit 1
fi

WECHAT_DIR=$(find /root/Desktop/install/ -type d -name "WeChat" | head -n 1)
if [ -z "$WECHAT_DIR" ]; then
    echo "WeChat directory not found in any directory matching WeChat"
    exit 1
fi

WECHAT_EXECUTABLE=$(realpath "$WECHAT_DIR/WeChat.exe")
if [ ! -f "$WECHAT_EXECUTABLE" ]; then
    echo "WeChat executable not found at $WECHAT_EXECUTABLE"
    exit 1
fi

# 检查目标目录是否存在
if [ ! -d "$DIRECTORY" ]; then
    echo "Cloning the repository..."
    git clone https://github.com/Ruk1ng001/wechatbot-provider-windows.git "$DIRECTORY"

    # 进入目标目录
    cd "$DIRECTORY" || exit 1

    # 替换 windows.bat 中的 Python 路径
    if [ -f "windows.bat" ]; then
        sed -i.bak "s|python|$PYTHON_EXECUTABLE|g" windows.bat
        echo "Python path in windows.bat has been updated to $PYTHON_EXECUTABLE"
    else
        echo "windows.bat not found."
        exit 1
    fi
else
    echo "Repository already exists, skipping clone..."
    # 拉取最新代码
    echo "Pulling latest code from repository..."
    git pull

    cd "$DIRECTORY" || exit 1
fi

# 运行 windows.bat
echo "Running windows.bat..."
wine windows.bat
