# Use a Python image with uv pre-installed
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

# Setup a non-root user
RUN groupadd --system --gid 999 nonroot \
 && useradd --system --gid 999 --uid 999 --create-home nonroot


WORKDIR /app

# Copy dependency files first (for caching)
COPY pyproject.toml uv.lock ./


# Enable bytecode compilation
ENV UV_COMPILE_BYTECODE=1
# Disable development dependencies
ENV UV_NO_DEV=1

# Install dependencies
ENV UV_SYSTEM_PYTHON=1
RUN uv sync --locked

# Copy project files
COPY . .

# Run Django with Gunicorn
CMD ["uv", "run", "gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]


