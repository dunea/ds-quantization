# 使用官方 Python 3.12.10 基础镜像
FROM python:3.12.10-slim

# 环境变量，避免 Python 写入 .pyc 等，设置 UTF-8
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    VIRTUAL_ENV=/opt/venv

# 创建工作目录
WORKDIR /app

# 复制项目文件到镜像
# 仅复制必要文件以便利用 Docker 缓存（先复制 requirements.txt）
COPY requirements.txt /app/requirements.txt
COPY .env /app/.env
COPY deepseek_ok.py /app/deepseek_ok.py
# 若需要其它脚本也可以复制（可选）
# COPY deepseek.py /app/deepseek.py

# 安装 virtualenv 并创建虚拟环境，然后通过 pip 安装依赖
RUN python -m venv $VIRTUAL_ENV \
    && . $VIRTUAL_ENV/bin/activate \
    && pip install --upgrade pip setuptools wheel \
    && pip install -r /app/requirements.txt \
    && pip cache purge

# 将虚拟环境的 bin 路径加入 PATH（运行时会使用该环境）
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# 默认为非交互模式（可根据需要修改）
# 如果需要外部访问，可根据实际脚本暴露端口（此项目为脚本，通常无需暴露）
# EXPOSE 8000

# 容器启动时执行 deepseek_ok.py
# 使用 exec 形式避免 shell 处理信号问题
CMD ["python", "deepseek_ok.py"]