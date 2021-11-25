extends Node


onready var fire_place = $FirePlacePlayer
onready var journal = $Journal
onready var sound_control =$SoundControl 
onready var speechIntr = $IntroductionPlayer
onready var gui
var speech_interactions

onready var sceneIntroduction = ['2Lascomodidades.wav','3TuColaboracion.wav', '4YaQueJose.wav','5SiendoUnForestero.wav']
onready var sceneIntroductionText = ['Bienvenido a nuestro hogar', 'las comodidades no son muchas pero espero que te sientas como en casa',' Tu colaboracion nos ayuda mucho ', 'ya que Walter, el dueño de la fabrica para la que trabajo, no nos paga muy bien','Siendo un forastero quizas tengas algunas preguntas']
onready var introduction_counter = 4




# Called when the node enters the scene tree for the first time.
func _ready():
	speechIntr.stream = load("res://assets/Speechs/1Bienvenido.wav")

func set_gui(newgui):
	gui = newgui

func set_speech_interactions(speechinteractions):
	speech_interactions = speechinteractions


func _on_SceneLoaded_timeout():
	speechIntr.play()
	gui.chatbox_spawn_npc_tile(sceneIntroductionText[0])
	sceneIntroductionText.remove(0)

func _on_IntroductionPlayer_finished():
	if introduction_counter > 0:
		speechIntr.stream = load("res://assets/Speechs/" + sceneIntroduction[0])
		sceneIntroduction.remove(0)
		speechIntr.play()
		gui.chatbox_spawn_npc_tile(sceneIntroductionText[0])
		sceneIntroductionText.remove(0)
		introduction_counter -= 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !fire_place.is_playing():
		fire_place.play()


