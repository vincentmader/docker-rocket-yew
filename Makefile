
# Makefile
#
# ─────────────────────────────────────────────────────────────────────────────
#
custom_1_docker:  # Start the container for production via `docker-compose`.
	make up       
	make logs
custom_2_rocket:  # Run the server via Cargo, & build the client to WASM.
	make wasm
	make rocket

# ─────────────────────────────────────────────────────────────────────────────
#
rocket:           # Run the backend crate via Cargo.
	cargo run 
trunk:            # Run the frontend crate via Trunk.
	cd client && trunk serve --release
wasm:             # Build the frontend crate.
	cd client && trunk build --release
	cd client/bin && ./link_dist.sh
tests:            # Run Cargo tests.
	cargo test

# ─────────────────────────────────────────────────────────────────────────────
#
up:               # Start the container.
	docker-compose up -d --build
down:             # Stop the container.
	docker-compose down
logs:             # Display live logs.
	docker-compose logs -ft
docker:           # Build Container without `docker-compose`.
	docker build -t mxyz-image .
	docker run --rm mxyz-image

# ─────────────────────────────────────────────────────────────────────────────
