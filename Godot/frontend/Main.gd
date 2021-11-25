extends Node

onready var john_back = $JohnBack
onready var john_scene = $JohnScene
onready var gui = $GUI
onready var chatbox = $GUI/Chatbox
onready var journal = $GUI/Journal
onready var speechinter = $SpeechInteractions



onready var trigger_spawned = false

func _ready():
	speechinter.set_chatbox(chatbox)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_john_scene():
	speechinter.set_npc(john_back)
	john_scene.set_gui(gui)


func _on_JohnBack_trigger(trigger):
	journal.show_trigger_text(trigger)
