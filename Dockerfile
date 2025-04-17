FROM python:3.10-slim

# Cài các dependency hệ thống
RUN apt-get update && apt-get install -y \
    ffmpeg git && \
    rm -rf /var/lib/apt/lists/*

# Tạo thư mục làm việc
WORKDIR /app

# Copy file source
COPY . .

# Cài pip package
RUN pip install --no-cache-dir -r requirements.txt

# Port flask
EXPOSE 5005

CMD ["python", "server.py"]
