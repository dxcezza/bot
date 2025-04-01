# Базовый образ
FROM ubuntu:20.04

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    aria2 \
    python3 \
    python3-pip \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Установка yt-dlp
RUN pip3 install yt-dlp

# Установка yt-dlp-server (через pip)
RUN pip3 install yt-dlp-server

# Создание директории для конфигурации aria2
RUN mkdir -p /app/aria2-config

# Копирование конфигурационного файла для aria2 (опционально)
COPY aria2.conf /app/aria2-config/aria2.conf

# Открытие портов
EXPOSE 8080 6800

# Команда для запуска aria2 и yt-dlp-server
CMD aria2c --conf-path=/app/aria2-config/aria2.conf --enable-rpc --rpc-listen-all & \
    yt-dlp-server --port=8080
