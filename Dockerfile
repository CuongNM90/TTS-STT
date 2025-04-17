FROM python:3.10-slim

# Cài thư viện hệ thống cần thiết
RUN apt-get update && apt-get install -y \
    git ffmpeg libsndfile1 curl && \
    rm -rf /var/lib/apt/lists/*

# Tạo thư mục làm việc
WORKDIR /app

# Copy project
COPY . .

# Cài Python packages
RUN pip install --upgrade pip
RUN pip install --no-cache-dir torch==2.0.1
RUN pip install --no-cache-dir git+https://github.com/openai/whisper.git
RUN pip install --no-cache-dir git+https://github.com/sonph/tts.git@v0.4
RUN pip install --no-cache-dir flask

# Mở cổng API
EXPOSE 5005

CMD ["python", "server.py"]
