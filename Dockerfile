# Use an official Ubuntu as the base image
FROM ubuntu:latest

# Install required dependencies
RUN apt-get update && \
    apt-get install -y build-essential libssl-dev libgcrypt20-dev libjson-c-dev zlib1g-dev autotools-dev \
    automake autoconf pkg-config libtool git wget libestr-dev libfastjson-dev uuid-dev libcurl4-openssl-dev \
    flex bison python3-docutils

# Clone rsyslog source code
RUN git clone https://github.com/rsyslog/rsyslog.git /tmp/rsyslog

# Build and install rsyslog
WORKDIR /tmp/rsyslog
RUN autoreconf -fvi && \
    ./configure --prefix=/usr --sysconfdir=/etc --enable-omstdout && \
    make && \
    make install

# Copy rsyslog.conf to the container
COPY rsyslog.conf /etc/rsyslog.conf

# Clean up
RUN rm -rf /tmp/rsyslog

# Run rsyslogd by default
CMD ["rsyslogd", "-n"]

