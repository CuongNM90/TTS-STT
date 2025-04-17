from TTS.api import TTS

# Tải mô hình VietTTS
tts = TTS(model_name="tts_models/vi/viet_tts", progress_bar=False, gpu=False)

def synthesize_text(text, output_path):
    tts.tts_to_file(text=text, file_path=output_path)