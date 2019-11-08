FROM alpine

COPY LICENSE README.md /

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Add required software
RUN apk update && \
    apk add --no-cache curl

# Install Cloud Foundry CLI
# ...or Linux 64-bit binary
RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=6.47.2&source=github" | tar -zx
# ...move it to /usr/local/bin or a location you know is in your $PATH
RUN mv cf /usr/local/bin
RUN cf --version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
