extends Node

signal speech_trigger

onready var recorder = $Record
onready var stt = $Stt
onready var tts = $Tts
onready var translator = $TranslatorHelper
onready var npc = $NPC
onready var audio_player = $AudioStreamPlayer

var recording = false
var text_from_mic
var openai

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player.set_pitch_scale(0.18)
	openai = load("res://backend/talk_interactions/openai/Openai.py").new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("talk") && (!recording):
		recording = true
		recorder.start_recording()
	elif Input.is_action_just_released("talk") && (recording):
		recording = false
		recorder.stop_recording()
		recorder.save_to_wav()
	if Input.is_action_just_pressed("validation"):
		valid_text()


func _on_Record_file_saved():
	text_from_mic = stt.wav_to_text()
	print(text_from_mic)
	

#Crear interfaz grafica que muestre el texto generado por el stt.
#Permitir al usuario modificar y validar el texto, y enviarlo con "enter"
func valid_text():
	var input_text = translator.translate_to_english(text_from_mic)
	print(input_text)
	npc.any_matches(input_text)
	var final_input ="Robert: " + input_text + "?\n\nJohn" + " says:"
	npc.add_player_coment(final_input)
	var dialog_history = npc.get_dialog_history()
	var response = openai.get_response(dialog_history)
	npc.add_npc_coment(response)
	response = translator.translate_to_spanish(response)
	var response_wav = tts.create_speech(response)
	audio_player.load_record(response_wav)
	audio_player.play()


func _on_NPC_trigger(trigger_text):
	emit_signal("speech_trigger", trigger_text)
