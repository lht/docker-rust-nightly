FROM buildpack-deps:jessie

ARG BUILD_DATE

ENV DEBIAN_FRONTEND=noninteractive

ENV RUST_ARCHIVE=rust-nightly-x86_64-unknown-linux-gnu.tar.gz
ENV RUST_DOWNLOAD_URL=https://static.rust-lang.org/dist/$BUILD_DATE/$RUST_ARCHIVE

RUN mkdir -p /rust
WORKDIR /rust

RUN echo "$RUST_DOWNLOAD_URL" \
    && curl -fsOSL $RUST_DOWNLOAD_URL \
    && curl -s $RUST_DOWNLOAD_URL.sha256 | sha256sum -c - \
    && tar -C /rust -xzf $RUST_ARCHIVE --strip-components=1 \
    && rm $RUST_ARCHIVE \
    && ./install.sh --components=rustc,cargo,rust-std-x86_64-unknown-linux-gnu \
    && rm -rf /rust/*
