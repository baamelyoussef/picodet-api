#!/bin/bash
mkdir -p models picodet_config

echo "⬇️ Downloading PicoDet-S weights..."
wget -O picodet_model.zip https://paddledet.bj.bcebos.com/models/picodet_s_320_coco_lcnet.zip
unzip -o picodet_model.zip -d models/
rm picodet_model.zip

echo "⬇️ Downloading config..."
wget -O picodet_config/picodet_s_320_coco_lcnet.yml \
https://raw.githubusercontent.com/PaddlePaddle/PaddleDetection/release/2.6/configs/picodet/picodet_s_320_coco_lcnet.yml

echo "✅ Model & config ready."
