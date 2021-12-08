extends Node

signal new_trigger_phrase

onready var fire_place = $BackgroundPlayer
onready var speechIntr = $IntroductionPlayer
onready var sceneloader = $SceneLoaded
onready var back = $BobBack
onready var gui
var speech_interactions

onready var sceneIntroduction = ["2Hola.wav"]
onready var sceneIntroductionText = ['Hola! Juan me ha hablado de ti, bienvenido!', 'Hola!']
onready var introduction_counter = 1

onready var first_time = true


# Called when the node enters the scene tree for the first time.
func _ready():
	speechIntr.stream = load("res://assets/Speechs/Bob/1Hola.wav")
	fire_place.stream_paused = true
	
func set_gui(newgui):
	gui = newgui

func set_speech_interactions(speechinteractions):
	speech_interactions = speechinteractions
	
func hide_scene():
	fire_place.stream_paused = true

func load_scene():
	if(first_time):
		sceneloader.start()
	else:
		speechIntr.stream = load("res://assets/Speechs/Bob/" + sceneIntroduction[0])
		sceneloader.start()
	fire_place.stream_paused = false
	speech_interactions.set_npc(back)

func _on_SceneLoaded_timeout():
	speechIntr.play()
	gui.chatbox_spawn_npc_tile(sceneIntroductionText[0])
	if first_time:
		sceneIntroductionText.remove(0)
		first_time = false

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !fire_place.is_playing():
		fire_place.play()



func _on_BobBack_new_trigger_phrase(trigger, phrase, sentiment, npc_name):
	emit_signal("new_trigger_phrase", trigger, phrase, sentiment, npc_name)
