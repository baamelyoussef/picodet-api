from fastapi import FastAPI, UploadFile, File
from paddledet.apis import Detector
from PIL import Image
import numpy as np
from io import BytesIO

app = FastAPI()

detector = Detector(
    config='picodet_config/picodet_s_320_coco_lcnet.yml',
    model_dir='models/picodet_s_320_coco_lcnet'
)
detector.predictor.eval()

@app.post("/detect")
async def detect(file: UploadFile = File(...)):
    image = Image.open(BytesIO(await file.read())).convert("RGB").resize((320, 320))
    image_np = np.array(image)
    results = detector.predict(image_list=[image_np], threshold=0.5)
    return results
