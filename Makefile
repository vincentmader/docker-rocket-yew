all:
	make trunk_build
	make release
run:
	cargo run
release:
	cargo run # --release
tests:
	cargo test
trunk_build:
	cd client/bin && ./build.sh
trunk_serve:
	cd client && trunk serve # --release
