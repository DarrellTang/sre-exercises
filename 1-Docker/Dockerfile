# https://bitcoin.org/en/full-node#other-linux-daemon
FROM ubuntu:22.04

# Set version number
ARG BITCOIND_VERSION=22.0
WORKDIR /build/

RUN apt-get update && \
  apt-get -y install curl

# Download SHA256SUMS and binary tarball
RUN curl -sL https://bitcoincore.org/bin/bitcoin-core-${BITCOIND_VERSION}/SHA256SUMS -o SHA256SUMS
RUN curl -sL https://bitcoincore.org/bin/bitcoin-core-${BITCOIND_VERSION}/bitcoin-${BITCOIND_VERSION}-x86_64-linux-gnu.tar.gz \
  -o bitcoin-${BITCOIND_VERSION}-x86_64-linux-gnu.tar.gz

# Verify checksum for downloaded tarball
RUN grep "bitcoin-${BITCOIND_VERSION}-x86_64-linux-gnu.tar.gz" SHA256SUMS | sha256sum -c

# Extract binaries
RUN tar -xvf bitcoin-${BITCOIND_VERSION}-x86_64-linux-gnu.tar.gz

# Create service user, home dir, and change dir owner
RUN groupadd -r bitcoind && useradd --no-log-init -r -g bitcoind bitcoind
RUN mkdir /home/bitcoind
RUN chown bitcoind:bitcoind /home/bitcoind

# Install binaries to /usr/bin
RUN install -m 0755 -o bitcoind -g bitcoind -t /usr/bin bitcoin-22.0/bin/*

# Clean up build folder
RUN rm -rf /build

# Use service user to run binary
USER bitcoind

# https://bitcoin.stackexchange.com/questions/93550/how-can-i-view-in-my-shell-live-all-activity-my-bitcoind-is-generating
# print to console
ENTRYPOINT ["bitcoind", "-printtoconsole"]
