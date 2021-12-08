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

onready var sceneIntroduction = ["1Bienvenido.wav", "2TeRecibira.wav",'3Buscame.wav', '4VeoQueYa.wav', '5Walter.wav', '7TeInvitoAQue.wav', '8CuandoHayasHablado.wav', '9UtilizaElMapa.wav', '10VuelveCuando.wav', '11QueOpinas.wav', '12TeGustaria.wav', '13ComoPudisteNotar.wav', '14YCadaUno.wav', '15SiVolvieras.wav', '16VuelveConmigo.wav', '17TuIntervencion.wav', '18UnGranPoder.wav', '19UsaloSabiamente.wav' ]
onready var sceneIntroductionText = ['Bienvenido al pueblo, tu objetivo por esta noche sera encontrar la casa de Juan para hospedarte', 'te recibira por pocas monedas si logras encontrar sus intereses.', 'Buscame mañana antes del alba', 'Veo que ya conociste a Juan, en la ciudad hay otras dos personas con las que podrás hablar', 'Walter que lo menciono Juan anoche y Bob que tiene una opinion distinta a la que tiene Juan', 'Te invito a que recorras la ciudad y dialogues con ellos para formar tus propias ideas', 'Cuando hayas hablado con todos y descubras sus motivaciones vuelve a buscarme', 'Utiliza el mapa para desplazarte por la ciudad', 'Vuelve cuando descubras sus motivaciones', '¿Qué opinas de las relaciones de la ciudad?', '¿Te gustaría poder cambiarlo?', 'Como de pudiste notar, las opiniones de Juan y de Bob sobre Walter son opuestas', ' y cada uno tiene sus propios motivos.', 'Si volvieras a hablar con alguno de ellos podrías usar los argumentos del otro para cambiar su opinión', 'Vuelve conmigo una vez que hayas podido cambiar una de sus dos opiniones', 'Tu intervención en el mundo es muy poderosa, tus acciones pueden cambiar la vida de la gente', 'Un gran poder conlleva una gran responsabilidad', 'Usalo sabiamente en el resto de tu camino' ]
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

func load_scene():
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
		if sceneIntroductionText[0] == 'Utiliza el mapa para desplazarte por la ciudad':
			set_current_stage("journal_incompleted")
			get_parent().stages["journal_incompleted"] = true
			get_parent().stage = "journal_incompleted"
		if sceneIntroductionText[0] == "Vuelve conmigo una vez que hayas podido cambiar una de sus dos opiniones":
			set_current_stage("shifter_not_received")
			get_parent().stages["shifter_not_received"] = true
			get_parent().stage = "shifter_not_received"
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

func delete_one_dialog():
	sceneIntroductionText.remove(0)
	sceneIntroduction.remove(0)

func set_current_stage(stage):
	sage_state.set_current_stage(stage)

func check_next_stage():
	sage_state.set_current_stage(get_parent().next_stage())

func _process(delta):
	if !forest_player.is_playing():
		forest_player.play()




func _on_JohnBack_new_trigger_phrase(trigger, phrase, sentiment):
	emit_signal("new_trigger_phrase", trigger, phrase, sentiment)


func _on_SceneChangerTimer_timeout():
	emit_signal("introduction_finished")
