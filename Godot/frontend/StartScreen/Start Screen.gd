extends Control

signal intro_finish

onready var recorder = $Record
onready var stt = $Stt
onready var vbox_container = $Menu/VBoxContainer
onready var audio_player = $AudioStreamPlayer
onready var gameIntro = $GameIntroduction
onready var menu = $Menu
onready var menu2 = $Menu2
onready var popup = $PopUp
onready var popup_label = $PopUp/Label

export var rec_path:NodePath
onready var red_dot = get_node(rec_path)

onready var active = true

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
	if api_key_on:
		if Input.is_action_just_released("talk") && (!recording) && active:
			recording = true
			recorder.start_recording()
			red_dot.visible = true
		elif Input.is_action_just_released("talk") && (recording) && active:
			recording = false
			recorder.stop_recording()
			recorder.save_to_wav()
			text_from_mic = stt.wav_to_text()
			label.set_text(text_from_mic)
			red_dot.visible = false
			if (text_from_mic == "continuar"):
				audio_player.play()
				popup.visible = false
		if Input.is_action_just_released("validation") && text_from_mic == "comenzar juego" && menu2.visible && active:
			menu.visible = false 
			menu2.visible = false
			gameIntro.visible = true
		if (Input.is_action_just_released("answer") && gameIntro.visible && active) || Input.is_action_just_released("escape"):
			popup.visible = false
			emit_signal("intro_finish")


func disable():
	active = false

func _on_AudioStreamPlayer_finished():
	vbox_container.remove_child(label)
	menu.visible = false 
	menu2.visible = true
	gameIntro.visible = false
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
	

