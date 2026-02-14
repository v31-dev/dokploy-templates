FROM alpine:latest

ARG PB_VERSION=0.36.3

RUN apk update \
    && apk add ca-certificates tzdata wget unzip \
    && rm -rf /var/cache/apk/*

# Download PocketBase
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip \
    -O /tmp/pb.zip \
    && unzip /tmp/pb.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/pocketbase \
    && rm /tmp/pb.zip

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8080

# Start PocketBase
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]