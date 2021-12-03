extends Node

signal new_trigger_phrase
signal introduction_finished

onready var changerTimer = $SceneChangerTimer
onready var forest_player = $ForestPlayer
onready var speechIntr = $IntroductionPlayer
onready var sceneloader = $SceneLoaded
onready var back = $Sage
onready var gui
var speech_interactions

onready var sceneIntroduction = ["2TeRecibira.wav",'3Buscame.wav']
onready var sceneIntroductionText = ['Bienvenido al pueblo, tu objetivo por esta noche sera encontrar la casa de juan para hospedarte', 'te recibira por pocas monedas si logras encontrar sus intereses.', 'Buscame mañana antes del alba']
onready var introduction_counter = 2






# Called when the node enters the scene tree for the first time.
func _ready():
	speechIntr.stream = load("res://assets/Speechs/Sage/1Bienvenido.wav")
	forest_player.stream_paused = true
	
func hide_scene():
		forest_player.stream_paused = true	

func set_gui(newgui):
	gui = newgui

func set_speech_interactions(speechinteractions):
	speech_interactions = speechinteractions

func load_scene(first_time):
	if(first_time):
		sceneloader.start()
	forest_player.stream_paused = false
	speech_interactions.set_npc(back)

func _on_SceneLoaded_timeout():
	speechIntr.play()
	gui.chatbox_spawn_npc_tile(sceneIntroductionText[0])
	sceneIntroductionText.remove(0)

func _on_IntroductionPlayer_finished():
	if introduction_counter > 0:
		speechIntr.stream = load("res://assets/Speechs/Sage/" + sceneIntroduction[0])
		sceneIntroduction.remove(0)
		speechIntr.play()
		gui.chatbox_spawn_npc_tile(sceneIntroductionText[0])
		sceneIntroductionText.remove(0)
		introduction_counter -= 1
	if introduction_counter == 0:
		changerTimer.start()
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !forest_player.is_playing():
		forest_player.play()




func _on_JohnBack_new_trigger_phrase(trigger, phrase, sentiment):
	emit_signal("new_trigger_phrase", trigger, phrase, sentiment)


func _on_SceneChangerTimer_timeout():
	emit_signal("introduction_finished")
