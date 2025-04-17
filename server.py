from flask import Flask, request, jsonify, send_file
import os
import uuid
from run_tts import synthesize_text
import whisper

UPLOAD_FOLDER = "uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

app = Flask(__name__)
model = whisper.load_model("base")  # hoặc tiny, small...

@app.route("/tts", methods=["POST"])
def tts():
    data = request.get_json()
    if not data or "text" not in data:
        return jsonify({"error": "Missing 'text' field"}), 400

    text = data["text"]
    output_path = os.path.join(UPLOAD_FOLDER, f"{uuid.uuid4()}.wav")
    synthesize_text(text, output_path)
    return send_file(output_path, mimetype="audio/wav")


@app.route("/stt", methods=["POST"])
def stt():
    if "file" not in request.files:
        return jsonify({"error": "Missing audio file"}), 400

    audio_file = request.files["file"]
    input_path = os.path.join(UPLOAD_FOLDER, f"{uuid.uuid4()}_{audio_file.filename}")
    audio_file.save(input_path)

    result = model.transcribe(input_path, language="vi")
    return jsonify({"text": result["text"]})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5005)