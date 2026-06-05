FROM ubuntu:24.04 AS builder
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        fpc \
        git \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 --branch 3.2.0 \
      https://github.com/HashLoad/horse.git /horse
WORKDIR /app
COPY src/Servers/HorseServer/HorseServer.lpr .
COPY src/Servers/HorseServer/HorseServer.lpi .
RUN mkdir -p /app/out && \
    fpc \
      -Mdelphi \
      -O2 \
      -Fu/horse/src \
      -Fu/app \
      -FU/app/out \
      -o/app/HorseServer \
      HorseServer.lpr
RUN chmod +x /app/HorseServer
ENTRYPOINT ["/app/HorseServer"]
