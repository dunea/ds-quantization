# 使用 Python 3.12 官方镜像作为基础镜像
FROM python:3.12-slim

# 环境配置
ENV PIP_DEFAULT_TIMEOUT=100
ENV PIP_INDEX_URL=https://mirrors.aliyun.com/pypi/simple/

# 安装 PostgreSQL 开发包和其他必要工具
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /work

# 复制项目文件到工作目录
COPY . /work

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 暴露端口（如果你的应用需要监听端口）
#EXPOSE 8089

# 设置容器启动时要执行的命令
CMD ["python", "deepseek_ok.py"]