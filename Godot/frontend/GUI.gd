extends MarginContainer

onready var interface_list
onready var toggle_record_button
onready var recorder
onready var stt
onready var translator
onready var sttHolder: RichTextLabel
onready var engTextHolder: RichTextLabel

func _ready():
	interface_list = get_node("VBoxContainer/InputDevicesList")
	toggle_record_button = get_node("VBoxContainer/HBoxContainer/ToggleRecordButton")
	recorder = get_node("../Record")
	stt = get_node("../Stt")
	sttHolder = get_node("VBoxContainer/STTHolder")
	engTextHolder = get_node("VBoxContainer/EnglishTextHolder")
	translator = get_node("../TranslatorHelper")
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
	var textAux = stt.wav_to_text()
	sttHolder.add_text(textAux)

func _on_TranslateButton_pressed():
	var textAux = sttHolder.text
	textAux = translator.translate_to_english(textAux)
	engTextHolder.add_text(textAux)
