FROM debian:stretch-20180213

ENV HOME /bitcoin

ENV BITCOIN_VERSION 0.16.0

RUN apt-get update -y \
  && apt-get install -y curl unzip procps \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV BITCOIN_SHASUM="e6322c69bcc974a29e6a715e0ecb8799d2d21691d683eeb8fef65fc5f6a66477  bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz"

RUN curl -SLO https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz \
  && echo "${BITCOIN_SHASUM}" | sha256sum -c \
  && tar -xzf *.tar.gz -C /opt \
  && rm *.tar.gz

ENV PATH=/opt/bitcoin-${BITCOIN_VERSION}/bin:$PATH

EXPOSE 8332 8334

WORKDIR /bitcoin

COPY . /usr/local/bin

CMD ["btc_init"]