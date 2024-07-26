# 使用 Fedora 39 作为基础镜像
FROM fedora:39
LABEL describe="Fedora for WeChat hook, base on LXDE, Wine, xRDP, WeChatFerry."

# 设置工作目录
WORKDIR /root

# 更新系统并安装必要的软件包
RUN dnf update -y \
        && dnf groupinstall -y "LXDE" \
        && dnf install -y wine \
        && dnf install -y xrdp \
        && dnf install -y git \
        && dnf install -y cjkuni-ukai-fonts cjkuni-uming-fonts google-noto-sans-cjk-ttc-fonts wqy-microhei-fonts wqy-zenhei-fonts \
        && dnf clean all

# 设置时区为 Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

# 设置 root 用户密码，并移动资源文件到指定目录
RUN echo "root:123" | chpasswd \
        && mkdir -p ~/Desktop \
        && mv res/*.desktop ~/Desktop \
        && mv res/*.sh .

# 暴露端口
EXPOSE 3389   # Port for xRDP
# EXPOSE 8888   # Port for http service (uncomment if needed)
EXPOSE 10086  # Port for rpc send msg
EXPOSE 10087  # Port for rpc recv msg

# 设置入口点和默认命令
ENTRYPOINT ["./entrypoint.sh"]
CMD ["bash"]
