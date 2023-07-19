run:
	cargo run
release:
	cargo run --release
tests:
	cargo test
trunk_build:
	cd client && trunk build --release
trunk_serve:
	cd client && trunk serve --release
