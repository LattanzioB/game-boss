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
onready var sage_state = $Sage_state
onready var first_time = true

onready var sceneIntroduction = ["1Bienvenido.wav", "2TeRecibira.wav",'3Buscame.wav', '4VeoQueYa.wav', '5JuanQueYa.wav', '6YBobQueTiene.wav', '7TeInvitoAQue.wav', '8CuandoHayasHablado.wav', '9UtilizaElMapa.wav', '10VuelveCuando.wav' ]
onready var sceneIntroductionText = ['Bienvenido al pueblo, tu objetivo por esta noche sera encontrar la casa de juan para hospedarte', 'te recibira por pocas monedas si logras encontrar sus intereses.', 'Buscame mañana antes del alba', 'En la ciudad existen 3 personajes principales', 'Juan que ya lo conociste, Walter que lo menciono Juan anoche', 'y Bob que tiene una opinion distinta a la que tiene Juan', 'Te invito a que recorras la ciudad y dialogues con ellos para formar tus propias ideas', 'Cuando hayas hablado con todos y descubras sus motivaciones vuelve a buscarme', 'Utiliza el mapa para desplazarte por la ciudad' ]
onready var player_counter 
onready var delete_speech_counter

# Called when the node enters the scene tree for the first time.
func _ready():
	forest_player.stream_paused = true
	
func hide_scene():
		forest_player.stream_paused = true

func set_gui(newgui):
	gui = newgui

func set_speech_interactions(speechinteractions):
	speech_interactions = speechinteractions

func load_scene(first_time):
	check_next_stage()
	var orders = sage_state.get_orders()
	player_counter = orders[0]
	delete_speech_counter = orders[1]
	speechIntr.stream = load("res://assets/Speechs/Sage/" + sceneIntroduction[0])
	sceneloader.start()
	forest_player.stream_paused = false
	speech_interactions.set_npc(back)

func _on_SceneLoaded_timeout():
	speechIntr.play()
	gui.chatbox_spawn_npc_tile(sceneIntroductionText[0])
	if(delete_speech_counter > 0):
		sceneIntroductionText.remove(0)
		sceneIntroduction.remove(0)
		delete_speech_counter -= 1
		player_counter -= 1
	else:
		player_counter -= 1
		

func _on_IntroductionPlayer_finished():
	if player_counter > 0:
		speechIntr.stream = load("res://assets/Speechs/Sage/" + sceneIntroduction[0])
		speechIntr.play()
		gui.chatbox_spawn_npc_tile(sceneIntroductionText[0])
		player_counter -= 1
	if (delete_speech_counter > 0):
		sceneIntroductionText.remove(0)
		sceneIntroduction.remove(0)
		delete_speech_counter -= 1
	if player_counter == 0:
		if first_time:
			changerTimer.start()
			first_time = false
# Called every frame. 'delta' is the elapsed time since the previous frame.

func check_next_stage():
	sage_state.set_current_stage(get_parent().next_stage())

func _process(delta):
	if !forest_player.is_playing():
		forest_player.play()




func _on_JohnBack_new_trigger_phrase(trigger, phrase, sentiment):
	emit_signal("new_trigger_phrase", trigger, phrase, sentiment)


func _on_SceneChangerTimer_timeout():
	emit_signal("introduction_finished")
