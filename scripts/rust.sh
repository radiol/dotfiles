#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Rust
# ---------------------------------------------------------
if ! (type "cargo" >/dev/null 2>&1); then
	echo "Installing Rust"
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs >rustup.sh
	sh rustup.sh -y -q --no-modify-path && rm rustup.sh
	source "$HOME/.cargo/env"
fi

# Install Rust Apps
echo "Installing cargo-binstall"
cargo install -q cargo-binstall
echo "Installing Rust Apps"
cargo binstall -q -y --only-signed bp \
	cargo-edit \
	cargo-update \
	eza \
	git-delta \
	sheldon \
	starship \
	topgrade \
	xcp \
	zoxide
