extends Node

signal speech_trigger


onready var recorder = $Record
onready var stt = $Stt
onready var tts = $Tts
onready var translator = $TranslatorHelper
onready var npc = $NPC
onready var audio_player = $AudioStreamPlayer

export var chatbox_path:NodePath
onready var chatbox = get_node(chatbox_path)

export var rec_path:NodePath
onready var red_dot = get_node(rec_path)

var question_countdown = 3
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
		red_dot.visible = true
	elif Input.is_action_just_released("talk") && (recording):
		recording = false
		recorder.stop_recording()
		recorder.save_to_wav()
		red_dot.visible = false
	if Input.is_action_just_pressed("validation") || Input.is_action_just_pressed("answer"):
		valid_text("")
	if Input.is_action_just_pressed("question"):
		valid_text("?")



func _on_Record_file_saved():
	text_from_mic = stt.wav_to_text()
	print(text_from_mic)
	if(chatbox != null):
		chatbox.spawn_player_tile(text_from_mic)

#Crear interfaz grafica que muestre el texto generado por el stt.
#Permitir al usuario modificar y validar el texto, y enviarlo con "enter"
func valid_text(messege_type):
	var input_text = translator.translate_to_english(text_from_mic)
	npc.any_matches(input_text)
	var final_input ="Robert: " + input_text + messege_type + "\n\nJuan" + " says:"
	npc.add_player_coment(final_input)
	var dialog_history = npc.get_dialog_history()
	var response = openai.get_response(dialog_history)
	npc.add_npc_coment(response)
	question_countdown -= 1
	if question_countdown == 0:
		response = add_npc_question(response)
	response = translator.translate_to_spanish(response)
	var response_wav = tts.create_speech(response)
	print(response_wav)
	audio_player.load_record(response_wav)
	audio_player.play()
	if(chatbox != null):
		chatbox.spawn_npc_tile(response)


func add_npc_question(response):
	var response_plus_question 
	if response[-1] != "." && response[-1] != "?":
		response_plus_question = response + "." + npc.get_question()
	else:
		response_plus_question = response + npc.get_question()
	question_countdown = 5
	return response_plus_question

func _on_NPC_trigger(trigger_text):
	emit_signal("speech_trigger", trigger_text)


