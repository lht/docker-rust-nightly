docker run --rm -it -v $HOME/.cargo:/root/.cargo  -v `pwd`:/app -w /app rust-nightly cargo build --target=x86_64-unknown-linux-gnu --release
