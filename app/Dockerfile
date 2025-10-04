# Multi-stage Dockerfile for Flask Application
# Stage 1: Build stage
FROM python:3.11-slim as builder

# Set working directory
WORKDIR /app

# Install system dependencies needed for building
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Create virtual environment and install dependencies
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Stage 2: Production stage using distroless
FROM gcr.io/distroless/python3-debian12

# Copy the virtual environment from builder stage
COPY --from=builder /opt/venv /opt/venv

# Set environment variables
ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONPATH="/app"
ENV FLASK_APP=app.py
ENV FLASK_ENV=production

# Set working directory
WORKDIR /app

# Copy application code
COPY app.py .
COPY templates/ templates/

# Create non-root user (distroless uses nonroot user by default)
USER nonroot

# Expose port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:5000/login', timeout=3)" || exit 1

# Run the application
CMD ["app.py"]