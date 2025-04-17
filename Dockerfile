FROM python:3.10

# Cài các thư viện hệ thống cần thiết
RUN apt-get update && apt-get install -y \
    git ffmpeg libsndfile1 curl build-essential \
    espeak-ng libespeak-ng-dev python3-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Tạo thư mục làm việc
WORKDIR /app

# Copy toàn bộ mã nguồn
COPY . .

# Cài pip packages
RUN pip install --upgrade pip
RUN pip install torch==2.0.1
RUN pip install git+https://github.com/openai/whisper.git
RUN pip install git+https://github.com/sonph/tts.git@v0.4
RUN pip install flask

# Mở cổng API
EXPOSE 5005

CMD ["python", "server.py"]
