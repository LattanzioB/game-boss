extends Control

signal intro_finish

onready var recorder = $Record
onready var stt = $Stt
onready var vbox_container = $MicSelector/VBoxContainer
onready var audio_player = $AudioStreamPlayer
onready var gameIntro = $GameIntroduction
onready var languageSelector = $LanguageSelector
onready var menu2 = $Menu2
onready var popup = $PopUp
onready var popup_label = $PopUp/Label
onready var red_dot = $Rec
onready var translator = $TranslatorHelper
export var rec_path:NodePath

onready var apiKey = $ApiKey
onready var wrong_apikey = $ApiKey/VBoxContainer/WrongApiKey

onready var micSelector = $MicSelector
onready var micTester = $MicSelector/VBoxContainer/MicTester
onready var micTester2 = $MicSelector/VBoxContainer/MicTester2
onready var micTester3 = $MicSelector/VBoxContainer/MicTester3
onready var micWorking = $MicSelector/VBoxContainer/MicWorking
onready var micNotWorking = $MicSelector/VBoxContainer/MicNotWorking
onready var intruction = $MicSelector/VBoxContainer/Instruction 

onready var active = true
onready var first_talk = true

onready var esFlag = $LanguageSelector/VBoxContainer/EsFlag
onready var enFlag = $LanguageSelector/VBoxContainer/EnFlag
var language = ""

var recording = false
var text_from_mic = ""
var openai
var label
var api_key_on = false

# Called when the node enters the scene tree for the first time.
func _ready():
	label = Label.new()
	label.set_align(1)
	label.set_theme(load("res://assets/fonts/Pixel font.tres"))
	label.add_color_override("font_color", Color( 0.13, 0.55, 0.13, 1 ))
	vbox_container.add_child(label)
	audio_player.stream = load("res://assets/sfx/correct.mp3")
	audio_player.stream.set_loop(false)
	openai = load("res://backend/talk_interactions/openai/Openai.py").new()
	popup.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if languageSelector.visible && Input.is_action_just_released("Next") && (language != ""):
		languageSelector.visible = false
		micSelector.visible = true
		apply_language()
	if micSelector.visible && Input.is_action_just_released("Next") && ($MicSelector/VBoxContainer/InputDevicesList.get_selected_id() != 0):
		micTester.visible = true
	if micTester.visible || micTester3.visible:
		if Input.is_action_just_released("talk") && (!recording) && active:
			recording = true
			recorder.start_recording()
			red_dot.visible = true
			micTester2.visible = micTester.visible
		elif Input.is_action_just_released("talk") && (recording) && active:
			recording = false
			recorder.stop_recording()
			recorder.save_to_wav()
			text_from_mic = stt.wav_to_text()
			label.set_text(text_from_mic)
			if text_from_mic != '':
				intruction.visible = false
				micWorking.visible = true
				micNotWorking.visible = false
				micTester.visible = false
				micTester2.visible = false
				micTester3.visible = true
			else:
				intruction.visible = false
				micWorking.visible = false
				micNotWorking.visible = true
				micTester.visible = true
				micTester2.visible = true
				micTester3.visible = false
			red_dot.visible = false
	if (text_from_mic == "continuar" || text_from_mic == "continue") && !audio_player.playing && micSelector.visible:
		audio_player.play()
		popup.visible = true
			
	if apiKey.visible && api_key_on && Input.is_action_just_released("Next"):
		if popup_label.text == "API key funcionando!":
			apiKey.visible = false
			menu2.visible = true
		else:
			wrong_apikey.visible = true
	if Input.is_action_just_released("validation") && ((text_from_mic == "comenzar juego") || (text_from_mic == "start game")) && menu2.visible && active: 
		popup.visible = false
		menu2.visible = false
		gameIntro.visible = true
	if (Input.is_action_just_released("answer") && gameIntro.visible && active) || Input.is_action_just_released("escape"):
		emit_signal("intro_finish")


func disable():
	active = false

func _on_AudioStreamPlayer_finished():
	vbox_container.remove_child(label)
	micSelector.visible = false 
	apiKey.visible = true
	label.set_text("")
	$Menu2/VBoxContainer2.add_child(label)

func _on_TextEdit_text_entered(new_text):
	var config = ConfigFile.new()
	config.set_value("KEYS", "OPENAI_API_KEY", new_text)
	config.save("res://backend/key.cfg")
	
	var err = config.load("res://backend/key.cfg")
	openai.set_api_key(config.get_value(config.get_sections()[0], "OPENAI_API_KEY"))
	
	var response = openai.get_response("Hola")
	if response != "99999":
		api_key_on = true
		popup_label.set_text("API key funcionando!")
	else:
		popup_label.set_text("API key errónea")
	

func apply_language():
	stt.load_model(language)
	translate_everything_to(language)
	get_parent().set_language(language)


func translate_everything_to(lang):
	translate_item_to(lang, languageSelector)
	translate_item_to(lang, micSelector)
	translate_item_to(lang, menu2)
	translate_item_to(lang, gameIntro)
		
func translate_item_to(lang, item):
	for child in item.get_child(0).get_children():
		if !(child is Sprite) && (lang == 'es') && (child.text != 'SoulSeek'):
			child.text = translator.translate_to_spanish(child.text)
		elif !(child is Sprite) && (lang == 'en') && (child.text != 'SoulSeek'):
			child.text = translator.translate_to_english(child.text)



func _on_EsFlagArea_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton && event.pressed):
		language = "es"
		esFlag.set_texture(preload("res://assets/flags/EspA.png"))
		enFlag.set_texture(preload("res://assets/flags/Ing.png"))




func _on_EnFlagArea_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton && event.pressed):
		language = "en"
		esFlag.set_texture(preload("res://assets/flags/Esp.png"))
		enFlag.set_texture(preload("res://assets/flags/IngA.png"))


