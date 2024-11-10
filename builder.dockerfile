FROM rust:1.70 AS builder
WORKDIR /app

# Copy dependency files first
COPY Cargo.toml Cargo.lock ./

# Copy migrations directory
COPY migrations ./migrations/

# Copy source code
COPY src ./src

# Build with explicit output location
RUN cargo build --release && \
    ls -la target/release/  # Add this to debug

# Create directory to ensure binary location
RUN mkdir -p /app/target/release/