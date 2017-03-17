# Rust nightly Docker images

[![Build Status](https://travis-ci.org/lht/docker-rust-nightly.svg?branch=master)](https://travis-ci.org/lht/docker-rust-nightly)

```sh
docker run --rm -it \
    -v $HOME/.cargo:/root/.cargo  \
    -v `pwd`:/app -w /app \
    rust-nightly \
    cargo build --target=x86_64-unknown-linux-gnu --release
```
