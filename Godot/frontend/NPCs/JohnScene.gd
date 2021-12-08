extends Node

signal new_trigger_phrase


onready var fire_place = $FirePlacePlayer
onready var speechIntr = $IntroductionPlayer
onready var sceneloader = $SceneLoaded
onready var back = $JohnBack
onready var gui
var speech_interactions

onready var sceneIntroduction = ['2Lascomodidades.wav','3TuColaboracion.wav', '4YaQueWalter.wav','5SiendoUnForestero.wav', ]
onready var sceneIntroductionText = ['Bienvenido a nuestro hogar', 'las comodidades no son muchas pero espero que te sientas como en casa',' Tu colaboracion nos ayuda mucho ', 'ya que Walter, el dueño de la fabrica para la que trabajo, no nos paga muy bien','Siendo un forastero quizas tengas algunas preguntas', 'Hola!']
onready var introduction_counter = 4




# Called when the node enters the scene tree for the first time.
func _ready():
	speechIntr.stream = load("res://assets/Speechs/John/1Bienvenido.wav")
	fire_place.stream_paused = true
	
func set_gui(newgui):
	gui = newgui

func set_speech_interactions(speechinteractions):
	speech_interactions = speechinteractions
	
func hide_scene():
	fire_place.stream_paused = true

func load_scene(first_time):
	if(first_time):
		sceneloader.start()
	else:
		play_welcome()
	fire_place.stream_paused = false
	speech_interactions.set_npc(back)

func play_welcome():
	speechIntr.stream = load("res://assets/Speechs/John/6Hola.wav")
	speechIntr.play()
	gui.chatbox_spawn_npc_tile("Hola!")
	
func _on_SceneLoaded_timeout():
	speechIntr.play()
	gui.chatbox_spawn_npc_tile(sceneIntroductionText[0])
	sceneIntroductionText.remove(0)

func _on_IntroductionPlayer_finished():
	if introduction_counter > 0:
		speechIntr.stream = load("res://assets/Speechs/John/" + sceneIntroduction[0])
		sceneIntroduction.remove(0)
		speechIntr.play()
		gui.chatbox_spawn_npc_tile(sceneIntroductionText[0])
		sceneIntroductionText.remove(0)
		introduction_counter -= 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !fire_place.is_playing():
		fire_place.play()
	if Input.is_action_just_released("escape") && self.visible:
		get_parent().second_sage_scene()
		get_parent().start_scene_changer_timer()

func _on_JohnBack_new_trigger_phrase(trigger, phrase, sentiment, npc_name):
	emit_signal("new_trigger_phrase", trigger, phrase, sentiment, npc_name)


func _on_JohnBack_shifter_found():
	get_parent().new_shifter()
