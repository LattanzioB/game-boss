extends Node

signal new_trigger_phrase

onready var fire_place = $BackgroundPlayer
onready var speechIntr = $IntroductionPlayer
onready var sceneloader = $SceneLoaded
onready var back = $WalterBack
onready var gui
var speech_interactions

onready var lang = "es"

onready var sceneIntroduction = ["res://assets/Speechs/" + lang + "Walter/" + "1EstaEsMiFabrica.wav"]
onready var sceneIntroductionText = []
onready var sceneIntroductionTextEn = ["Hello, this is my factory. What brings you here?"]
onready var sceneIntroductionTextEs = ['Hola, esta es mi fabrica. Que te trae por aqui?'] 
onready var introduction_counter = 1




# Called when the node enters the scene tree for the first time.
func _ready():
	fire_place.stream_paused = true
	
func set_gui(newgui):
	gui = newgui

func set_language(language):
	lang = language
	if lang == "es":
		sceneIntroductionText = sceneIntroductionTextEs
	else:
		sceneIntroductionText = sceneIntroductionTextEn
		
	speechIntr.stream = load("res://assets/Speechs/" + lang + "/Walter/" + "1EstaEsMiFabrica.wav")

func set_speech_interactions(speechinteractions):
	speech_interactions = speechinteractions
	
func hide_scene():
	fire_place.stream_paused = true



func load_scene():
	sceneloader.start()
	fire_place.stream_paused = false
	speech_interactions.set_npc(back)

func _on_SceneLoaded_timeout():
	speechIntr.play()
	gui.chatbox_spawn_npc_tile(sceneIntroductionText[0])

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !fire_place.is_playing():
		fire_place.play()



func _on_WalterBack_new_trigger_phrase(trigger, phrase, sentiment, npc_name):
	emit_signal("new_trigger_phrase", trigger, phrase, sentiment, npc_name)
