FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget curl tar ca-certificates supervisor && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/local
RUN ARCH=$(uname -m) && case ${ARCH} in x86_64) XUI_ARCH="amd64" ;; aarch64) XUI_ARCH="arm64" ;; *) XUI_ARCH="amd64" ;; esac && wget -O x-ui.tar.gz "https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-${XUI_ARCH}.tar.gz" && tar -zxvf x-ui.tar.gz && rm x-ui.tar.gz && chmod +x /usr/local/x-ui/x-ui
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENV XUI_PORT=54321
ENV XUI_USERNAME=admin
ENV XUI_PASSWORD=admin
EXPOSE 54321 8080
ENTRYPOINT ["/start.sh"]
