extends Node

onready var recorder = $Record
onready var stt = $Stt
onready var tts = $Tts
onready var translator = $TranslatorHelper
onready var player = $AudioStreamPlayer

func _ready():
	pass # Replace with function body.

func _on_Record_file_saved():
	var text_recorded = stt.wav_to_text()
	var text_in_english = translator.translate_to_english(text_recorded)
	var text_in_spanish = translator.translate_to_spanish(text_in_english)
	var audio_file = tts.create_speech(text_in_spanish)
	print(audio_file)
	print(audio_file)
	player.load_record(audio_file)
	player.play()
