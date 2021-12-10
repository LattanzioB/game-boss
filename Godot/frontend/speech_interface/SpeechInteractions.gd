extends Node

signal speech_trigger
signal new_speech
signal finish_loading_speech

onready var recorder = $Record
onready var stt = $Stt
onready var tts = $Tts
onready var translator = $TranslatorHelper
onready var audio_player = $AudioStreamPlayer
var chatbox 
onready var active = false


var npc
var question_countdown = 3
var recording = false
var text_from_mic
var openai

var speechs_to_play 


# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player.set_pitch_scale(0.18)
	openai = load("res://backend/talk_interactions/openai/Openai.py").new()
	var config = ConfigFile.new()
	var err = config.load("res://backend/key.cfg")
	if err != OK:
		return
	openai.set_api_key(config.get_value(config.get_sections()[0], "OPENAI_API_KEY"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("talk") && (!recording) && active:
		recording = true
		recorder.start_recording()
	elif Input.is_action_just_released("talk") && (recording) && active:
		recording = false
		recorder.stop_recording()
		recorder.save_to_wav()
	if text_from_mic != "":
		if (Input.is_action_just_pressed("validation") && active) || (Input.is_action_just_pressed("answer") && active):
			emit_signal("new_speech")
			valid_text(" ")
		if (Input.is_action_just_pressed("question") && active):
			emit_signal("new_speech")
			valid_text("?")


func set_active(bul):
	active = bul

func set_npc(npc_back):
	npc = npc_back

func set_chatbox(chatboxx):
	chatbox = chatboxx

func change_npc_player(npc_bus):
	audio_player.bus = npc_bus

func _on_Record_file_saved():
	text_from_mic = stt.wav_to_text()
	print(text_from_mic)
	if(chatbox != null):
		chatbox.spawn_player_tile(text_from_mic)

#Crear interfaz grafica que muestre el texto generado por el stt.
#Permitir al usuario modificar y validar el texto, y enviarlo con "enter"
func valid_text(messege_type):
	var input_text = translator.translate_to_english(text_from_mic)
	text_from_mic = ""
	var sentiment = npc.any_matches(input_text)
	var final_input ="Robert says: " + input_text + messege_type + "\n\n" + npc.get_name() + npc.get_adverb(sentiment[0]) +" says:"
	npc.add_player_coment(final_input)
	var response
	var new_dialog = ''
	if sentiment[1] == '':
		new_dialog = openai.get_response(npc.get_dialog_history() + npc.get_new_dialogs())
		response = new_dialog
	else:
		var triggered_answer = sentiment[1]
		npc.add_npc_coment(triggered_answer)
		if(sentiment[1][-1] == "."):
			response = triggered_answer
		else:
			new_dialog = openai.get_response( npc.get_dialog_history(), npc.get_new_dialogs())
			response = triggered_answer + new_dialog
	npc.add_npc_coment(new_dialog)
	question_countdown -= 1
	if question_countdown == 0:
		response = add_npc_question(response)
	response = translator.translate_to_spanish(response)
	speechs_to_play = response.split(" ", true)
	create_speechs()
#	print(response_wav)
#	audio_player.load_record(response_wav)
#	audio_player.play()

	
#
func create_speechs():
	if(len(speechs_to_play) > 0):
		var speech = ''
		var it = 0
		while (it < 10) && (0 < len(speechs_to_play)):
			speech += speechs_to_play[0] + " "
			it += 1
			if(speech[-2] == "," || speech[-1] == "."):
				it = 10
			speechs_to_play.remove(0)
		var response_wav = tts.create_speech(speech)
		audio_player.load_record(response_wav)
		audio_player.play()
		if(chatbox != null):
			chatbox.spawn_npc_tile(speech)
	else:
		emit_signal('finish_loading_speech')

func _on_AudioStreamPlayer_finished():
	create_speechs()

func add_npc_question(response):
	var response_plus_question 
	if response[-1] != "." && response[-1] != "?":
		response_plus_question = response + "." + npc.get_question()
	else:
		response_plus_question = response + npc.get_question()
	question_countdown = 5
	return response_plus_question



	
