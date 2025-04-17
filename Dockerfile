FROM python:3.10

# Cài gói hệ thống cần thiết
RUN apt-get update && apt-get install -y \
    git ffmpeg libsndfile1 curl build-essential \
    espeak-ng libespeak-ng-dev python3-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Tạo thư mục làm việc
WORKDIR /app

COPY . .

# Cài Python packages
RUN pip install --upgrade pip
RUN pip install torch==2.0.1
RUN pip install git+https://github.com/openai/whisper.git
RUN pip install viet-tts
RUN pip install flask

EXPOSE 5005

CMD ["python", "server.py"]
