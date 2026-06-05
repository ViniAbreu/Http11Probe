FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        fpc \
        git \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --depth 1 --branch 3.2.0 https://github.com/HashLoad/horse.git /horse \
    && useradd --system appuser
WORKDIR /app
COPY src/Servers/HorseServer/HorseServer.lpr .
COPY src/Servers/HorseServer/HorseServer.lpi .
RUN mkdir -p /app/out \
    && fpc \
      -Mdelphi \
      -O2 \
      -Fu/horse/src \
      -Fu/app \
      -FU/app/out \
      -o/app/HorseServer \
      HorseServer.lpr \
    && chmod +x /app/HorseServer
USER appuser
ENTRYPOINT ["/app/HorseServer"]
