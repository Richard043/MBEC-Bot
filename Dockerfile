# Use an official Python runtime as the base image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the project files to the container
COPY . .

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    curl build-essential libssl-dev libffi-dev python3-dev cargo

# Install Rust (if needed for building some Python dependencies)
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    export PATH="$HOME/.cargo/bin:$PATH"

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Expose the required port (if your bot uses a specific one)
EXPOSE 8000

# Run the bot
CMD ["python", "main.py"]
