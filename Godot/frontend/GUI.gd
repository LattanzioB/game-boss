extends MarginContainer

onready var interface_list
onready var toggle_record_button
onready var recorder
onready var stt
onready var translator
onready var openai
onready var chatbox
onready var input_text:String = ""
onready var output_text:String = "texto predeterminado"
onready var tts
onready var audio_player

func _ready():
	interface_list = get_node("VBoxContainer/InputDevicesList")
	toggle_record_button = get_node("VBoxContainer/HBoxContainer/ToggleRecordButton")
	recorder = get_node("../Record")
	stt = get_node("../Stt")
	translator = get_node("../TranslatorHelper")
	openai = get_node("../Openai")
	chatbox = get_node("VBoxContainer/ChatBox")
	tts = get_node("../Tts")
	audio_player = get_node("../AudioStreamPlayer")
	
	var input_devices = AudioServer.capture_get_device_list()
	for i_d in input_devices:
		interface_list.add_item(i_d)
		

func _on_ToggleRecordButton_pressed():
	if toggle_record_button.text == "Record":
		recorder.start_recording()
		toggle_record_button.text = "Stop"
	else:
		recorder.stop_recording()
		toggle_record_button.text = "Record"

func _on_STTButton_pressed():
	recorder.save_to_wav()
	input_text = stt.wav_to_text()
	chatbox.spawn_chat_tile(input_text)
	input_text = translator.translate_to_english(input_text)


func _on_GetResponse_pressed():
	var openai_response = openai.get_response(input_text)
	output_text = translator.translate_to_spanish(openai_response)
	chatbox.spawn_chat_tile(output_text)
	


func _on_PlayResponseButton_pressed():
	var output_wav = tts.create_speech(output_text)
	audio_player.load_record(output_wav)
	audio_player.set_pitch_scale(0.18)
	audio_player.play()
