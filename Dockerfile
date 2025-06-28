FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    python3-pip python3-dev python3-setuptools \
    build-essential cmake git wget unzip \
    libgl1-mesa-glx libglib2.0-0 libsm6 libxext6 libxrender-dev libgomp1 \
    pkg-config libhdf5-dev libprotobuf-dev protobuf-compiler \
    libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavformat-dev \
    libswscale-dev libv4l-dev libxvidcore-dev libx264-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip setuptools wheel

# Install base dependencies first
RUN pip install numpy==1.24.3 Pillow==10.0.1

# Install web framework dependencies
RUN pip install fastapi==0.104.1 uvicorn[standard]==0.24.0 python-multipart==0.0.6

# Install OpenCV (headless version for Docker)
RUN pip install opencv-python-headless==4.8.1.78

# Install PaddlePaddle GPU (most complex package)
RUN pip install paddlepaddle-gpu==2.5.2 --index-url https://pypi.org/simple

# Install PaddleDet last
RUN pip install paddledet==2.5.0

COPY . .

RUN chmod +x scripts/download_model.sh && ./scripts/download_model.sh

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
