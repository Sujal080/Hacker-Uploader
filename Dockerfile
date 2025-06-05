FROM python:3.10-alpine

# Set the working directory
WORKDIR /app

# Copy all files to container
COPY . .

# Install dependencies
RUN apk add --no-cache \
    gcc \
    libffi-dev \
    musl-dev \
    ffmpeg \
    aria2 \
    make \
    g++ \
    cmake \
    unzip \
    wget \
    python3-dev \
    py3-pip \
    openssl-dev

# Install mp4decrypt (Bento4 tools)
RUN wget -q https://github.com/axiomatic-systems/Bento4/archive/v1.6.0-639.zip && \
    unzip v1.6.0-639.zip && \
    cd Bento4-1.6.0-639 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    cp mp4decrypt /usr/local/bin/ && \
    cd ../.. && \
    rm -rf Bento4-1.6.0-639 v1.6.0-639.zip

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Run the bot
CMD ["sh", "-c", "python3 main.py"]
