from flask import Flask, request, jsonify
from whisper import load_model
from viet_tts import TTS
import os

app = Flask(__name__)
stt_model = load_model("base")
tts = TTS()

@app.route("/stt", methods=["POST"])
def transcribe():
    audio_file = request.files["file"]
    path = os.path.join("uploads", audio_file.filename)
    audio_file.save(path)
    result = stt_model.transcribe(path, language="vi")
    return jsonify({"text": result["text"]})

@app.route("/tts", methods=["POST"])
def synthesize():
    data = request.get_json()
    text = data["text"]
    output_path = "output.wav"
    tts.synthesize(text, output_path)
    return jsonify({"audio": output_path})

if __name__ == "__main__":
    os.makedirs("uploads", exist_ok=True)
    app.run(host="0.0.0.0", port=5005)
