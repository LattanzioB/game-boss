extends Node

onready var john_back = $JohnBack
onready var john_scene = $JohnScene
onready var first_time_john = true

onready var start_screen = $StartScreen

onready var gui = $GUI
onready var chatbox = $GUI/Chatbox
onready var journal = $GUI/Journal
onready var speechinter = $SpeechInteractions


onready var trigger_spawned = false

func _ready():
	#porque suena el fuego en esta escena?
	speechinter.set_chatbox(chatbox)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func change_scene_to_johns():
	#modificar para primera vez/ siguientes
	john_scene.visible = true
	gui.visible = true
	speechinter.visible = true
	speechinter.set_active(true)
	john_scene.set_gui(gui)
	john_scene.load_scene(first_time_john)
	first_time_john = false
	

func _on_JohnBack_trigger(trigger):
	journal.show_trigger_text(trigger)


func _on_JohnBack_new_trigger_phrase(trigger, phrase):
	journal.show_tigger_phrase(trigger, phrase)


func _on_StartScreen_intro_finish():
	start_screen.visible = false
	start_screen.disable()
	change_scene_to_johns()
