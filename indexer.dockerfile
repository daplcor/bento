ARG BUILDER_IMAGE=builder:latest
FROM ${BUILDER_IMAGE} AS builder

FROM debian:bullseye-slim
WORKDIR /app

RUN apt-get update && apt-get install libpq-dev -y && apt-get install ca-certificates -y

# Use absolute path from builder and specify destination or prepare for failure
COPY --from=builder /app/target/release/indexer /app/indexer

# Keep our existing env file copy
COPY .env /app/.env

# Add some debug fun
RUN ls -la /app/indexer
RUN ls -la /app/.env

# Make sure we're in the right directory
WORKDIR /app
ENTRYPOINT ["./indexer"]