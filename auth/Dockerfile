FROM ubuntu:18.04

COPY LICENSE README.md /

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# add common software
# add common software
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install \
        wget \
        sudo \
        bash \
        gnupg

# add clound foundry repo
RUN wget -q -O - "https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key" | sudo apt-key add - && \
    echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list

# Install requirements
RUN apt-get update && \
    apt-get -y install \
        cf-cli && \
    apt-mark hold cf-cli

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
