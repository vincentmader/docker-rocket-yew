FROM rustlang/rust:nightly as builder

WORKDIR /var/www/mader.xyz

# Install dependencies needed for yew.rs compilation.
# ─────────────────────────────────────────────────────────────────────────────

RUN rustup target add wasm32-unknown-unknown
RUN cargo install --locked wasm-bindgen-cli
RUN cargo install --locked trunk

# Copy Cargo configuration files into container for dependency pre-compilation.
# ─────────────────────────────────────────────────────────────────────────────

COPY Cargo.toml Cargo.lock ./
COPY server/Cargo.toml server/Cargo.toml
COPY client/Cargo.toml client/Cargo.toml
COPY common/Cargo.toml common/Cargo.toml

# Create dummy source files.
# ─────────────────────────────────────────────────────────────────────────────

RUN mkdir -p server/src\
             client/src\
             common/src;\
    touch server/src/lib.rs\
          client/src/lib.rs\
          common/src/lib.rs

# Pre-compile Cargo dependencies.
# ─────────────────────────────────────────────────────────────────────────────

RUN cargo build --release

# Get rid of dummy source files again.
# ─────────────────────────────────────────────────────────────────────────────

RUN rm server/src/lib.rs client/src/lib.rs common/src/lib.rs;\
    rmdir server/src client/src common/src 

# Copy actual source files into container.
# ─────────────────────────────────────────────────────────────────────────────

COPY Rocket.toml Rocket.toml 
COPY server/src server/src
COPY server/static/css server/static/css
COPY server/templates server/templates
COPY client/src client/src
COPY client/index.html client/index.html
COPY common/src common/src

# Build yew.rs client crate.
# ─────────────────────────────────────────────────────────────────────────────

RUN cd client && trunk build --release
RUN cd server/static && ln -s ../../client/dist ./dist

# Start the server.
# ─────────────────────────────────────────────────────────────────────────────

EXPOSE 8314

CMD [ "cargo", "run", "--release" ]
